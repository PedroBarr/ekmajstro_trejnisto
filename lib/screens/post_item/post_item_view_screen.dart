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

  @override
  void initState() {
    super.initState();

    if (widget.post_id != null && isNumeric(widget.post_id!.toString())) {
      setState(() {
        _is_loading = true;
      });
      getPost(widget.post_id.toString()).then((Post post) {
        setState(() {
          _post = Post.fromPost(post);
        });
      }).whenComplete(() {
        setState(() {
          _is_loading = false;
        });
      });
    }
  }

  void setPost(String attr, String value) {
    setState(() {
      _post.setPost(attr, value);
    });
  }

  void navigateToPostList(BuildContext context) {
    Navigator.of(context).pushNamed(ROUTER_POST_LIST_ROUTE);
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
            title: Builder(
              builder: (context) {
                if (!_is_loading) {
                  return Text(_post.title);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          body: const Stack(
            children: [],
          ),
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }
}
