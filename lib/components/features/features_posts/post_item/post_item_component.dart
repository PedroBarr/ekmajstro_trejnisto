import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';

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
  void navigateToPost(BuildContext context) {
    Navigator.of(context).pushNamed(
      buildIdRoute(ROUTER_POST_VIEW_ROUTE, widget.post!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToPost(context),
      child: Container(
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
              (widget.post!.trimTitle(max_length: 23)).toUpperCase(),
              style: const TextStyle(
                fontSize: 16.0,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const SizedBox(width: 10.0),
            Builder(builder: (context) {
              if (widget.post!.with_preview) {
                return Icon(
                  Icons.public_sharp,
                  color: Theme.of(context).colorScheme.onSurface,
                );
              }
              return Icon(
                Icons.public_off_sharp,
                color: Theme.of(context).scaffoldBackgroundColor,
              );
            }),
            const SizedBox(width: 10.0),
          ],
        ),
      ),
    );
  }
}
