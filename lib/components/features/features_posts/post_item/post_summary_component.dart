import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'post_item_constants.dart';

import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/components/components.dart';

class PostSummaryComponent extends StatefulWidget {
  final Post post;
  final bool is_published;
  final Function(String, dynamic)? confirmEdit;

  const PostSummaryComponent({
    super.key,
    required this.post,
    this.is_published = false,
    this.confirmEdit,
  });

  @override
  State<PostSummaryComponent> createState() => _PostSummaryComponentState();
}

class _PostSummaryComponentState extends State<PostSummaryComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageFieldComponent(
                  height: 210,
                  value: widget.post.image_url,
                  onConfirm: (value) => widget.confirmEdit != null
                      ? widget.confirmEdit!(Post.POST_ATTR_IMAGE, value)
                      : null,
                  title: POST_COVER_IMAGE_TITLE,
                  is_title_editable: false,
                ),
                const Text(
                  POST_COVER_IMAGE_TITLE,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(
                        builder: (BuildContext context) {
                          return widget.is_published
                              ? Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      final Uri uri =
                                          Uri.parse(widget.post.getAppLink());

                                      Clipboard.setData(ClipboardData(
                                              text: uri.toString()))
                                          .then((_) {
                                        showMessage(
                                            CLIPBOARD_COPY_SUCCESS, context);
                                      });
                                    },
                                    child: Icon(
                                      Icons.gesture_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                )
                              : SizedBox.shrink();
                        },
                      ),
                      SizedBox(
                        height: widget.is_published ? 30.0 : 0,
                      ),
                      Text(
                        widget.post.user,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      const Text(
                        POST_USER_TITLE,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.getDateFormatted(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      const Text(
                        POST_PUBLISH_DATE_TITLE,
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
    );
  }
}
