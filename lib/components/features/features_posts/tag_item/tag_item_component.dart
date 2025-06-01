import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class TagItemComponent extends StatefulWidget {
  final TagItem tag;
  final Color? background_color;

  const TagItemComponent({
    super.key,
    required this.tag,
    this.background_color,
  });

  @override
  State<TagItemComponent> createState() => _TagItemComponent();
}

class _TagItemComponent extends State<TagItemComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color:
            widget.background_color ?? Theme.of(context).colorScheme.onSurface,
      ),
      alignment: Alignment.center,
      child: Text(
        widget.tag.name,
        style: TextStyle(
          color: Theme.of(context).scaffoldBackgroundColor,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
