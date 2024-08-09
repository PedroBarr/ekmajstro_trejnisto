import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class PostItemComponent extends StatefulWidget {
  final PostItem? post;

  const PostItemComponent({
    Key? key,
    this.post,
  }) : super(key: key);

  @override
  State<PostItemComponent> createState() => _PostItemComponent();
}

class _PostItemComponent extends State<PostItemComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Theme.of(context).colorScheme.primary,
      ),
      padding: const EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width - 20.0,
      child: Row(
        children: [
          Text(widget.post!.title),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.play_arrow_rounded,
              )),
        ],
      ),
    );
  }
}
