import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/utils/utils.dart';

class AddTagItemComponent extends StatefulWidget {
  final String? post_id;

  const AddTagItemComponent({
    super.key,
    this.post_id,
  });

  @override
  State<AddTagItemComponent> createState() => _AddTagItemComponent();
}

class _AddTagItemComponent extends State<AddTagItemComponent> {
  void navigateToTagList() {
    Navigator.pushNamed(
      context,
      buildIdRouteById(
        ROUTER_TAG_VIEW_ROUTE,
        int.parse(widget.post_id!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateToTagList,
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
    );
  }
}
