import 'package:flutter/material.dart';

import 'create_tag_item_component.dart';
import 'tag_list_constants.dart';

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

  String _search_text = '';

  bool _is_loading = false;

  @override
  void initState() {
    super.initState();

    loadTags();
  }

  void loadTags() {
    toggleLoading(true);

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
              CreateTagItemComponent(
                onTagAdded: (Tag tag) {
                  if (widget.post_id != null) {
                    tagPost(widget.post_id!, int.parse(tag.id))
                        .whenComplete(() {
                      loadTags();
                    });
                  } else {
                    loadTags();
                  }
                },
              ),
            ],
            title: const Text(TAG_LIST_TITLE),
          ),
          body: Column(
            children: [
              SearchBarComponent(
                  hint_text: HINT_TAG_LIST,
                  onChanged: (String value) {
                    setState(() {
                      _search_text = value;
                    });
                  }),
              const SizedBox(height: 10.0),
              (widget.post_id != null && _selected_tags.isNotEmpty)
                  ? Container(
                      margin: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TagItemListComponent(
                        tags: getSelectedTags(),
                        include_add: false,
                        tag_color: Theme.of(context).colorScheme.onPrimary,
                        onTapTag: (TagItem tag) {
                          untagPost(widget.post_id!, int.parse(tag.id!)).then(
                            (tags) {
                              setState(() {
                                _selected_tags = tags;
                              });
                            },
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: (!_is_loading
                    ? TagItemListComponent(
                        tags: getMainTags(),
                        include_add: widget.post_id != null,
                        tag_color: Theme.of(context).colorScheme.onSurface,
                        onTapTag: (TagItem tag) {
                          if (widget.post_id == null) {
                            return;
                          }

                          tagPost(widget.post_id!, int.parse(tag.id!)).then(
                            (tags) {
                              setState(() {
                                _selected_tags = tags;
                              });
                            },
                          );
                        },
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

  List<TagItem> getMainTags() {
    return _tags
        .where((tag) => !_selected_tags
            .map((tag) => tag.id.toString())
            .toList()
            .contains(tag.id.toString()))
        .where((tag) =>
            tag.name.toLowerCase().contains(_search_text.toLowerCase()))
        .map((tag) => TagItem(
              id: tag.id,
              name: tag.name,
            ))
        .toList();
  }

  List<TagItem> getSelectedTags() {
    return _selected_tags
        .map((tag) => TagItem(
              id: tag.id,
              name: tag.name,
            ))
        .toList();
  }
}
