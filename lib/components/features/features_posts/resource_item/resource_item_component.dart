import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class ResourceItemComponent extends StatefulWidget {
  final ResourceItem resource;

  const ResourceItemComponent({
    super.key,
    required this.resource,
  });

  @override
  State<ResourceItemComponent> createState() => _ResourceItemComponent();
}

class _ResourceItemComponent extends State<ResourceItemComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width - 20.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.resource.name,
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),
                  child: Text(
                    widget.resource.description,
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SvgPicture.network(
              widget.resource.parseTypeIcon(),
              width: 35.0,
              height: 35.0,
            ),
          ],
        ),
      ),
    );
  }
}
