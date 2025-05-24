import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/components/components.dart';

class TagListScreen extends StatefulWidget {
  final int? post_id;

  const TagListScreen({
    super.key,
    this.post_id,
  });

  @override
  State<TagListScreen> createState() => _TagListScreenState();
}

class _TagListScreenState extends State<TagListScreen> {
  List<Tag> _tags = [];
  List<Tag> _selected_tags = [];

  @override
  void initState() {
    super.initState();

    loadTags();
    debugPrint('TagListScreen initialized with post_id: ${widget.post_id}');
  }

  void loadTags() {
    getTags().then((tags) {
      setState(() {
        _tags = tags;
        debugPrint('Tags loaded: $_tags');
      });
    }).whenComplete(() {
      if (widget.post_id != null) {
        getPostTagsList(widget.post_id!).then((tags) {
          setState(() {
            _selected_tags = tags;
            debugPrint('Selected tags loaded: $_selected_tags');
          });
        });
      }
    });
  }

  void navigateToPostList() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      ROUTER_POST_LIST_ROUTE,
      (Route<dynamic> route) => route.settings.name == ROUTER_POST_LIST_ROUTE,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                if (widget.post_id != null) {
                  Navigator.of(context).pop();
                } else {
                  navigateToPostList();
                }
              },
              child: iconNavPostList(Theme.of(context).colorScheme.onSurface),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.my_library_add),
                tooltip: 'Agregar etiqueta',
                onPressed: () {},
              ),
            ],
            title: const Text('Etiquetas'),
          ),
          body: Center(
            child: Text('Tag List Screen'),
          ),
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }
}
