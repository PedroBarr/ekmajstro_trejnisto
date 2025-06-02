import 'package:flutter/material.dart';

import 'resource_item_view_constants.dart';

import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:ekmajstro_trejnisto/models/models.dart';

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
      appBar: AppBar(),
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
