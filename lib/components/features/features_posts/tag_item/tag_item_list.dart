import 'package:flutter/material.dart';

import 'add_tag_item_component.dart';
import 'tag_item_component.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class TagItemListComponent extends StatefulWidget {
  final List<TagItem> tags;
  final bool include_add;
  final String? post_id;
  final Function(TagItem)? onTapTag;
  final Color? tag_color;

  const TagItemListComponent({
    super.key,
    required this.tags,
    this.include_add = false,
    this.post_id,
    this.onTapTag,
    this.tag_color,
  });

  @override
  State<TagItemListComponent> createState() => _TagItemListComponent();
}

class _TagItemListComponent extends State<TagItemListComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              height: null,
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 5.0,
                ),
                itemCount: widget.tags.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (widget.onTapTag != null) {
                        widget.onTapTag!(widget.tags[index]);
                      }
                    },
                    child: TagItemComponent(
                      tag: widget.tags[index],
                      background_color: widget.tag_color ??
                          Theme.of(context).colorScheme.onSurface,
                    ),
                  );
                },
              ),
              // ),
            );
          },
        ),
        (widget.include_add
            ? const SizedBox(
                height: 10,
              )
            : SizedBox.shrink()),
        Builder(
          builder: (context) {
            return widget.include_add && widget.post_id != null
                ? AddTagItemComponent(
                    post_id: widget.post_id,
                  )
                : SizedBox.shrink();
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
