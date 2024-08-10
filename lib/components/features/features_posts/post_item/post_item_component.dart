import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class PostItemComponent extends StatefulWidget {
  final PostItem? post;

  const PostItemComponent({
    super.key,
    this.post,
  });

  @override
  State<PostItemComponent> createState() => _PostItemComponent();
}

class _PostItemComponent extends State<PostItemComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Theme.of(context).primaryColor,
      ),
      padding: const EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width - 20.0,
      child: Row(
        children: [
          const SizedBox(width: 10.0),
          Text(
            (widget.post!.title).toUpperCase(),
            style: const TextStyle(
              fontSize: 16.0,
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.fast_forward_rounded,
            ),
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
          ),
          const SizedBox(width: 10.0),
        ],
      ),
    );
  }
}
