import 'package:flutter/material.dart';

import 'resource_item_view_constants.dart';

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

  bool _is_loading = false;
  bool _is_modified = false;

  @override
  void initState() {
    super.initState();

    if (widget.resource_id != null &&
        isNumeric(widget.resource_id!.toString())) {
      loadData();
    }
    toggleModified(false);
  }

  void loadData() {
    toggleLoading(true);

    toggleLoading(false);
  }

  void setResource(String attr, dynamic value) {
    if (!mounted) return;

    setState(() {
      Resource resource = Resource.fromResource(_resource);

      switch (attr) {
        case 'name':
          _resource.name = value;
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
    String message = '';
    try {
      message = SAVE_RESOURCE_SUCCESS_MESSAGE;
    } catch (e) {
      Navigator.of(context).pop();
      message = SAVE_RESOURCE_ERROR_MESSAGE;
    } finally {
      showMessage(message, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ],
        title: Builder(
          builder: (context) {
            if (!_is_loading) {
              return CustomTextFieldComponent(
                value: _resource.name,
                spacing: 10.0,
                font_size: 16,
                onConfirm: (value) => setResource('name', value),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
