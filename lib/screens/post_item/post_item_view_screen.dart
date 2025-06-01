import 'package:flutter/material.dart';

import 'post_item_view_constants.dart';

import 'package:ekmajstro_trejnisto/components/components.dart';
import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';

class PostItemView extends StatefulWidget {
  final int? post_id;

  const PostItemView({
    super.key,
    this.post_id,
  });

  @override
  State<PostItemView> createState() => _PostItemView();
}

class _PostItemView extends State<PostItemView> {
  Post _post = Post();
  List<SectionItem> _sections = [];
  List<ResourceItem> _resources = [];
  List<TagItem> _tags = [];
  PreviewItem _preview = PreviewItem();

  bool _is_loading = false;
  bool _is_modified = false;

  @override
  void initState() {
    super.initState();

    if (widget.post_id != null && isNumeric(widget.post_id!.toString())) {
      loadData();
    }
    toggleModified(false);
  }

  void loadData() {
    toggleLoading(true);

    getPost(widget.post_id.toString()).then((Post post) {
      if (!mounted) return;

      setState(() {
        _post = Post.fromPost(post);
      });
    }).whenComplete(() {
      if (!mounted) return;

      getPostSections(_post).then((List<SectionItem> sections) {
        _sections = sections;
      }).whenComplete(() {
        if (!mounted) return;

        getPostResources(_post).then((List<ResourceItem> resources) {
          _resources = resources;
        }).whenComplete(() {
          if (!mounted) return;

          getPostTags(_post).then((List<TagItem> tags) {
            _tags = tags;
          }).whenComplete(() {
            if (!mounted) return;

            getPostPreview(_post).then((PreviewItem preview) {
              if (!mounted) return;

              setState(() {
                _preview = preview;
              });
            }).whenComplete(() {
              toggleLoading(false);
            });
          });
        });
      });
    });
  }

  void setPost(String attr, String value) {
    if (!mounted) return;

    setState(() {
      Post post = Post.fromPost(_post);
      _post.setPost(attr, value);

      if (!(post == _post)) {
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
      savePost(_post).then((value) {
        if (!mounted) return;

        setState(() {
          _post = Post.fromPost(value);
        });
      });
      message = 'Guardado exitoso';
    } catch (e) {
      Navigator.of(context).pop();
      message = 'Guardado fallido';
    } finally {
      showMessage(message, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshSwipperComponent(
          onRefresh: () {
            loadData();
          },
          refreshing: _is_loading,
          child: Scaffold(
            appBar: AppBar(
              leading: Builder(
                builder: (context) {
                  return _is_loading
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: iconNavPostList(
                              Theme.of(context).colorScheme.onSurface),
                        );
                },
              ),
              actions: [
                Builder(builder: (context) {
                  if (_is_modified) {
                    return GestureDetector(
                      onTap: onSave,
                      child: const Padding(
                        padding: EdgeInsets.only(
                          right: 10.0,
                          left: 10.0,
                        ),
                        child: Icon(
                          Icons.save_as_rounded,
                        ),
                      ),
                    );
                  }
                  return Container();
                }),
              ],
              title: Builder(
                builder: (context) {
                  if (!_is_loading) {
                    return CustomTextFieldComponent(
                      value: _post.title,
                      spacing: 10.0,
                      font_size: 16,
                      onConfirm: (value) =>
                          setPost(Post.POST_ATTR_TITTLE, value),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
            body: Column(
              children: <Widget>[
                Flexible(
                  child: Builder(
                    builder: (context) {
                      if (_is_loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 250.0,
                                width: MediaQuery.of(context).size.width,
                                child: PostSummaryComponent(
                                  is_published: _preview.id!.isNotEmpty,
                                  post: _post,
                                  confirmEdit: (String attr, dynamic value) {
                                    setPost(attr, value);
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              AccordionComponent(
                                elements: <AccordionElement>[
                                  AccordionElement(
                                    name: post_sections_title,
                                    content: SectionItemListComponent(
                                      include_add: _post.id.isNotEmpty,
                                      sections: _sections,
                                      post: _post,
                                    ),
                                  ),
                                  AccordionElement(
                                    name: post_resources_title,
                                    content: ResourceItemListComponent(
                                      include_add: _post.id.isNotEmpty,
                                      resources: _resources,
                                    ),
                                  ),
                                  AccordionElement(
                                    name: post_tags_title,
                                    content: TagItemListComponent(
                                      include_add: _post.id.isNotEmpty,
                                      tags: _tags,
                                      post_id: _post.id,
                                    ),
                                  ),
                                  AccordionElement(
                                    name: post_preview_title,
                                    content: PreviewItemComponent(
                                      is_publishable: _post.id.isNotEmpty,
                                      preview: _preview,
                                      post_id: _post.id,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }
}
