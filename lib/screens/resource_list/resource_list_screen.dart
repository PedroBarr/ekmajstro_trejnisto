import 'package:flutter/material.dart';

import 'resource_list_constants.dart';

import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/components/components.dart';

class ResourceListScreen extends StatefulWidget {
  final int? post_id;

  const ResourceListScreen({
    super.key,
    this.post_id,
  });

  @override
  State<ResourceListScreen> createState() => _ResourceListScreen();
}

class _ResourceListScreen extends State<ResourceListScreen> {
  List<ResourceItem> _resources = [];
  List<ResourceItem> _selected_resources = [];

  List<ResourceTypeItem> _search_resources_type = [];

  String _search_text = '';

  bool _is_loading = false;

  @override
  void initState() {
    super.initState();

    loadResources();
  }

  void loadResources() {
    toggleLoading(true);

    getResources().then((resources) {
      if (mounted) {
        setState(() {
          _resources = resources;
        });
      }
    }).whenComplete(() {
      if (widget.post_id != null) {
        getPostResources(
          Post(
            id: widget.post_id!.toString(),
          ),
        ).then((resources) {
          setState(() {
            _selected_resources = resources;
          });
        }).whenComplete(() {
          toggleLoading(false);
        });
      } else {
        toggleLoading(false);
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

  void addSelectedResourceType(ResourceTypeItem resourceType) {
    if (!mounted) return;
    if (_search_resources_type.any((item) => item.id == resourceType.id)) {
      return;
    }

    setState(() {
      _search_resources_type.add(resourceType);
    });
  }

  void removeSelectedResourceType(ResourceTypeItem resourceType) {
    if (!mounted) return;
    if (!_search_resources_type.any((item) => item.id == resourceType.id)) {
      return;
    }

    setState(() {
      _search_resources_type.removeWhere((item) => item.id == resourceType.id);
    });
  }

  void processResourceSelection(
    BuildContext context,
    ResourceItem resource,
  ) {
    if (widget.post_id != null) {
      if (_selected_resources.any((item) => item.id == resource.id)) {
        showDialog(
          context: context,
          builder: (context) {
            return DialogActionOptionsComponent(
              actions: getActionsForSelectedResource(
                context,
                resource,
                widget.post_id!,
                toggleLoading,
                loadResources,
              ),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return DialogActionOptionsComponent(
              actions: getActionsForUnselectedResource(
                context,
                resource,
                widget.post_id!,
                toggleLoading,
                loadResources,
              ),
            );
          },
        );
      }
    } else {
      navigateToResourceItemViewScreen(context, int.parse(resource.id!));
    }
  }

  @override
  build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                if (widget.post_id != null) {
                  Navigator.of(context).pop();
                } else {
                  navigateToLocation(context, ROUTER_POST_LIST_ROUTE);
                }
              },
              child: iconNavPostList(
                Theme.of(context).colorScheme.onSurface,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () {
                  if (widget.post_id != null) {
                    Navigator.of(context).pushNamed(
                      buildSubRoute([
                        buildIdRouteById(
                            ROUTER_POST_VIEW_ROUTE, widget.post_id!),
                        ROUTER_RESOURCE_ADD_VIEW_SUB_PATH,
                      ]),
                    );
                  } else {
                    Navigator.of(context).pushNamed(
                      ROUTER_RESOURCE_ADD_ROUTE,
                    );
                  }
                },
              ),
            ],
            title: const Text(RESOURCE_LIST_TITLE),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              SearchBarComponent(
                  hint_text: HINT_RESOURCE_LIST,
                  onChanged: (String value) {
                    setState(() {
                      _search_text = value;
                    });
                  }),
              SizedBox(height: 5),
              ResourcesTypeRowComponent(
                selected_resources_type: _search_resources_type,
                onSelect: addSelectedResourceType,
                onUnselect: removeSelectedResourceType,
              ),
              (_is_loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  : ResourceItemListComponent(
                      resources: getFilteredResources(),
                      selected_resources: _selected_resources,
                      onTap: (ResourceItem r) {
                        processResourceSelection(
                          context,
                          r,
                        );
                      },
                    )),
            ]),
          ),
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }

  List<ResourceItem> getFilteredResources() {
    return _resources.where((resource) {
      return resource.name.toLowerCase().contains(_search_text.toLowerCase()) ||
          resource.description
              .toLowerCase()
              .contains(_search_text.toLowerCase());
    }).where((resource) {
      if (_search_resources_type.isEmpty) {
        return true;
      }

      return _search_resources_type.any(
        (type) => type.name == resource.type,
      );
    }).toList();
  }
}
