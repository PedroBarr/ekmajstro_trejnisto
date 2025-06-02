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
              ResourcesTypeRowComponent(),
              (_is_loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  : ResourceItemListComponent(
                      resources: _resources.where((resource) {
                        return resource.name
                                .toLowerCase()
                                .contains(_search_text.toLowerCase()) ||
                            resource.description
                                .toLowerCase()
                                .contains(_search_text.toLowerCase());
                      }).toList(),
                      selected_resources: _selected_resources,
                    )),
            ]),
          ),
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }
}
