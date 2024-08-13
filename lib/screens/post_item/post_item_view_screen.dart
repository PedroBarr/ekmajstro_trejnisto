import 'package:flutter/material.dart';

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
        toggleLoading(false);
        toggleModified(false);
      });
    } else {
      toggleModified(true);
    }
  }

  void setPost(String attr, String value) {
    setState(() {
      toggleModified(true);
      _post.setPost(attr, value);
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
                  return const Icon(
                    Icons.save_as_rounded,
                  );
                }
                return Container();
              }),
            ],
            title: Builder(
              builder: (context) {
                if (!_is_loading) {
                  return Center(
                    child: Row(
                      children: [
                        Text(_post.title),
                        const SizedBox(width: 10.0),
                        const Icon(Icons.edit_square),
                      ],
                    ),
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
                        Container(
                          height: 250.0,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Wrap(
                                    direction: Axis.vertical,
                                    runAlignment: WrapAlignment.start,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if (_post.image_url.isEmpty) {
                                            return Container();
                                          } else {
                                            return Image.network(
                                              _post.image_url,
                                              height: 200.0,
                                              fit: BoxFit.fitHeight,
                                            );
                                          }
                                        },
                                      ),
                                      const Text(
                                        'IMAGEN DE PORTADA',
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
                                            Row(
                                              children: [
                                                Text(
                                                  _post.user,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Icon(
                                                  Icons.edit_square,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                ),
                                              ],
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
                                            Row(
                                              children: [
                                                Text(
                                                  _post.getDateFormatted(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Icon(
                                                  Icons.edit_square,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                ),
                                              ],
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
                                      //       Row(
                                      //         children: [
                                      //           Text(_post.user),
                                      //           const Spacer(),
                                      //           Icon(
                                      //             Icons.edit_square,
                                      //             color: Theme.of(context)
                                      //                 .colorScheme
                                      //                 .onSurface,
                                      //           )
                                      //         ],
                                      //       ),
                                      //       const Text('Usuario'),
                                      //     ],
                                      //   ),
                                      //   Text('adsa'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
