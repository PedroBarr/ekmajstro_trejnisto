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
  bool _is_loading = false;
  bool _is_modified = false;

  @override
  void initState() {
    super.initState();

    if (widget.post_id != null && isNumeric(widget.post_id!.toString())) {
      toggleLoading(true);

      getPost(widget.post_id.toString()).then((Post post) {
        setState(() {
          _post = Post.fromPost(post);
        });
      }).whenComplete(() {
        getPostSections(_post).then((List<SectionItem> sections) {
          _sections = sections;
        }).whenComplete(() {
          toggleLoading(false);
        });
      });
    }
    toggleModified(false);
  }

  void setPost(String attr, String value) {
    setState(() {
      Post post = Post.fromPost(_post);
      _post.setPost(attr, value);

      if (!(post == _post)) {
        toggleModified(true);
      }
    });
  }

  void navigateToPostList(BuildContext context) {
    Navigator.of(context).pushNamed(ROUTER_POST_LIST_ROUTE);
  }

  void toggleLoading(dynamic value) {
    setState(() {
      if ([true, false].contains(value)) {
        _is_loading = value;
      } else {
        _is_loading = !_is_loading;
      }
    });
  }

  void toggleModified(dynamic value) {
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
        Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () => navigateToPostList(context),
              child: iconNavPostList(Theme.of(context).colorScheme.onSurface),
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
                    onConfirm: (value) => setPost(Post.POST_ATTR_TITTLE, value),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          body: Flexible(
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
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomImageFieldComponent(
                                        height: 210,
                                        value: _post.image_url,
                                        onConfirm: (value) => setPost(
                                            Post.POST_ATTR_IMAGE, value),
                                        title: post_cover_image_title,
                                        is_title_editable: false,
                                      ),
                                      const Text(
                                        post_cover_image_title,
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _post.user,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const Text(
                                              'USUARIO',
                                              style: TextStyle(
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _post.getDateFormatted(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const Text(
                                              'FECHA DE PUBLICACIÓN',
                                              style: TextStyle(
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        AccordionComponent(
                          elements: <AccordionElement>[
                            AccordionElement(
                              name: 'Secciones',
                              content: SectionItemListComponent(
                                sections: _sections,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }
}
