import 'package:flutter/material.dart';

import 'add_tag_item_component.dart';
import 'tag_item_component.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class TagItemListComponent extends StatefulWidget {
  final List<TagItem> tags;
  final bool include_add;
  final String post_id;

  const TagItemListComponent({
    super.key,
    required this.tags,
    this.include_add = false,
    required this.post_id,
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
                  return TagItemComponent(
                    tag: widget.tags[index],
                  );
                },
              ),
              // ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Builder(
          builder: (context) {
            return widget.include_add
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
