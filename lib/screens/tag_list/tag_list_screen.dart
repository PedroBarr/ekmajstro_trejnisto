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
  }

  void loadTags() {
    getTags().then((tags) {
      setState(() {
        _tags = tags;
      });
    }).whenComplete(() {
      if (widget.post_id != null) {
        getPostTagsList(widget.post_id!).then((tags) {
          setState(() {
            _selected_tags = tags;
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
          body: Column(
            children: [
              const SizedBox(height: 10.0),
              (widget.post_id != null && _selected_tags.isNotEmpty)
                  ? Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _selected_tags.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 5.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final tag = _selected_tags[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selected_tags.remove(tag);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                tag.name,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: (_tags.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: getMainTags().length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 5.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final tag = getMainTags()[index];
                            return GestureDetector(
                              onTap: () {
                                tagPost(widget.post_id!, int.parse(tag.id))
                                    .then((tags) {
                                  setState(() {
                                    _selected_tags = tags;
                                  });
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  tag.name,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )),
              ),
            ],
          ),
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }

  List<Tag> getMainTags() {
    return _tags
        .where((tag) => !_selected_tags
            .map((tag) => tag.id.toString())
            .toList()
            .contains(tag.id.toString()))
        .toList();
  }
}
