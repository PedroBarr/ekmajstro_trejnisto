import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'add_resource_item_component.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class ResourceItemListComponent extends StatefulWidget {
  final List<ResourceItem> resources;
  final bool include_add;

  const ResourceItemListComponent({
    super.key,
    required this.resources,
    this.include_add = false,
  });

  @override
  State<ResourceItemListComponent> createState() =>
      _ResourceItemListComponent();
}

class _ResourceItemListComponent extends State<ResourceItemListComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
          direction: Axis.vertical,
          spacing: 10.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            [
              const SizedBox(
                height: 5,
              ),
            ],
            widget.resources.map<Widget>((resource) {
              return Container(
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
                          resource.name,
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
                            resource.description,
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
                      resource.parseTypeIcon(),
                      width: 35.0,
                      height: 35.0,
                    ),
                  ],
                ),
              );
            }).toList(),
            [
              Builder(
                builder: (context) {
                  return widget.include_add
                      ? AddResourceItemComponent()
                      : SizedBox.shrink();
                },
              ),
              const SizedBox(
                height: 5,
              ),
            ]
          ].expand((x) => x).toList()),
    );
  }
}
