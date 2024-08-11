import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/components/components.dart';
import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';

class PostItemView extends StatefulWidget {
  final int post_id;

  const PostItemView({
    super.key,
    required this.post_id,
  });

  @override
  State<PostItemView> createState() => _PostItemView();
}

class _PostItemView extends State<PostItemView> {
  late Future<Post> _post;

  @override
  void initState() {
    super.initState();

    _post = getPost(widget.post_id);
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
            title: FutureBuilder(
              future: _post,
              builder: (BuildContext context, AsyncSnapshot<Post> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.title);
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
