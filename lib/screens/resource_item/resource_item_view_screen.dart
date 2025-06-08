import 'package:flutter/material.dart';

import 'resource_item_view_constants.dart';
import 'resource_item_file_mode_box_component.dart';

import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/components/components.dart';

class ResourceItemViewScreen extends StatefulWidget {
  final int? resource_id;
  final int? post_id;

  const ResourceItemViewScreen({
    super.key,
    this.resource_id,
    this.post_id,
  });

  @override
  State<ResourceItemViewScreen> createState() => _ResourceItemViewScreen();
}

class _ResourceItemViewScreen extends State<ResourceItemViewScreen> {
  Resource _resource = Resource();
  ResourceTypeItem _selected_resource_type = ResourceTypeItem.nullable();

  int? _post_id = null;

  bool _is_loading = false;
  bool _is_modified = false;

  @override
  void initState() {
    super.initState();

    if (widget.post_id != null && isNumeric(widget.post_id!.toString())) {
      _post_id = widget.post_id;
    }

    if (widget.resource_id != null &&
        isNumeric(widget.resource_id!.toString())) {
      loadData();
    }
    toggleModified(false);
  }

  void loadData() {
    toggleLoading(true);

    getResource(widget.resource_id!.toString()).then((value) {
      if (!mounted) return;

      setState(() {
        _resource = Resource.fromResource(value);
      });
    }).whenComplete(() {
      if (!mounted) return;

      getResourceTypes().then((List<ResourceTypeItem> types) {
        if (!mounted) return;

        setState(() {
          if (types.isNotEmpty) {
            _selected_resource_type = types.firstWhere(
              (type) => type.id.toString() == _resource.type,
              orElse: () => ResourceTypeItem.nullable(),
            );
          } else {
            _selected_resource_type = ResourceTypeItem.nullable();
          }
        });
      }).whenComplete(() {
        toggleLoading(false);
      });
    });
  }

  void setResource(String attr, dynamic value) {
    if (!mounted) return;

    setState(() {
      Resource resource = Resource.fromResource(_resource);

      switch (attr) {
        case 'name':
          _resource.name = value;
          break;
        case 'description':
          _resource.description = value;
          break;
        case 'specification':
          _resource.specification = value;
          break;
        case 'type':
          if (value is ResourceTypeItem) {
            _resource.type = value.id.toString();
            _resource.type_key = value.key;
            _selected_resource_type = value;
          } else {
            _resource.type = '';
            _resource.type_key = '';
            _selected_resource_type = ResourceTypeItem.nullable();
          }

          break;
        case 'file_name':
          _resource.file_name = value;
          break;
        case 'file_uri':
          _resource.file_uri = value;
          break;
        case 'file_size':
          _resource.file_size = value;
          break;
        case 'file_mime':
          _resource.file_mime = value;
          break;
        case 'file_extension':
          _resource.file_extension = value;
          break;
        default:
          break;
      }

      if (!(resource == _resource)) {
        toggleModified(true);
      }
    });
  }

  void toggleLoading(dynamic value) {
    if (!mounted) return;

    setState(() {
      if ([true, false].contains(value)) {
        _is_loading = value;
      } else {
        _is_loading = !_is_loading;
      }
    });
  }

  void toggleModified(dynamic value) {
    if (!mounted) return;

    setState(() {
      if ([true, false].contains(value)) {
        _is_modified = value;
      } else {
        _is_modified = !_is_modified;
      }
    });
  }

  void onSave() {
    String? id = _resource.id.isNotEmpty ? _resource.id : null;

    String message = '';
    try {
      saveResource(_resource).then((value) {
        if (!mounted) return;

        setState(() {
          _resource = Resource.fromResource(value);
          toggleModified(false);
        });
      }).whenComplete(() {
        if (_post_id != null &&
            isNumeric(_post_id!.toString()) &&
            id == null &&
            _resource.id.isNotEmpty &&
            isNumeric(_resource.id)) {
          ResourceItem resource_item = ResourceItem(
            id: _resource.id,
            name: _resource.name,
            description: _resource.description,
            type: _resource.type,
            type_icon: '',
          );

          attachResourceToPost(_post_id!, resource_item).then((_) {
            showMessage(SAVE_POST_RESOURCE_SUCCESS_MESSAGE, context);
          });
        }
      });
      message = SAVE_RESOURCE_SUCCESS_MESSAGE;
    } catch (e) {
      Navigator.of(context).pop();
      message = SAVE_RESOURCE_ERROR_MESSAGE;
    } finally {
      showMessage(message, context);
    }
  }

  void detachResourceToPost() {
    ResourceItem resource = ResourceItem(
      id: _resource.id,
      name: _resource.name,
      description: _resource.description,
      type: _resource.type,
      type_icon: '',
    );

    detachResourceFromPost(_post_id!, resource).then((_) {
      showMessage(
        DETACH_RESOURCE_SUCCESS_MESSAGE,
        context,
      );

      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (context) {
                return _is_loading
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: iconNavResourceList(
                            Theme.of(context).colorScheme.onSurface),
                      );
              },
            ),
            actions: [
              Builder(
                builder: (context) {
                  return _is_modified
                      ? GestureDetector(
                          onTap: onSave,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Icon(
                              Icons.save_as_rounded,
                            ),
                          ),
                        )
                      : Container();
                },
              ),
              (_post_id != null &&
                      isNumeric(_post_id!.toString()) &&
                      _resource.id.isNotEmpty &&
                      isNumeric(_resource.id))
                  ? Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: detachResourceToPost,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Icon(Icons.remove_circle),
                          ),
                        );
                      },
                    )
                  : Container(),
            ],
            title: Builder(
              builder: (context) {
                if (!_is_loading) {
                  return CustomTextFieldComponent(
                    value: _resource.name,
                    spacing: 10.0,
                    font_size: 16,
                    max_length: 20,
                    onConfirm: (value) => setResource('name', value),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          body: Builder(
            builder: (context) {
              return _is_loading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            RESOURCE_DESCRIPTION_LABEL,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: RESOURCE_DESCRIPTION_LABEL,
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                            onSubmitted: (value) {
                              setResource('description', value);
                            },
                            controller: TextEditingController(
                              text: _resource.description,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            RESOURCE_SPECIFICATION_LABEL,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: RESOURCE_SPECIFICATION_LABEL,
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                            onSubmitted: (value) {
                              setResource('specification', value);
                            },
                            controller: TextEditingController(
                              text: _resource.getParseSpecification(),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            RESOURCE_TYPE_LABEL,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          ResourcesTypeRowComponent(
                            selected_resources_type: getSelectedResourceType(),
                            onSelect: (ResourceTypeItem type) {
                              setResource('type', type);
                            },
                            onUnselect: (ResourceTypeItem type) {
                              setResource('type', null);
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.onPrimary,
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.1),
                                  blurRadius: 5.0,
                                  offset: Offset(0, 15),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  RESOURCE_FILE_FORM_TITLE.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    letterSpacing: 5.0,
                                    fontWeight: FontWeight.bold,
                                    decorationThickness: 2.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                ResourceItemFileModeBoxComponent(
                                  resource: _resource,
                                  onResourceChanged: setResource,
                                  mode: (_resource.id.isEmpty ||
                                          !isNumeric(_resource.id))
                                      ? ResourceFileBoxMode.create
                                      : ResourceFileBoxMode.edit,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
            },
          ),
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }

  List<ResourceTypeItem> getSelectedResourceType() {
    return _resource.type_key.isNotEmpty ? [_selected_resource_type] : [];
  }
}
