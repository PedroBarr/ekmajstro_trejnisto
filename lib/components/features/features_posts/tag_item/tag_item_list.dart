import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class TagItemListComponent extends StatefulWidget {
  final List<TagItem> tags;
  final bool include_add;

  const TagItemListComponent({
    super.key,
    required this.tags,
    this.include_add = false,
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
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.tags[index].name,
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 16.0,
                      ),
                    ),
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
                ? GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        height: 40.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: Theme.of(context).colorScheme.onPrimary,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
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
