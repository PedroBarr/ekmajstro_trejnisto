import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/utils/utils.dart';

class AddResourceItemComponent extends StatefulWidget {
  final String? post_id;

  const AddResourceItemComponent({
    super.key,
    this.post_id,
  });

  @override
  State<AddResourceItemComponent> createState() => _AddResourceItemComponent();
}

class _AddResourceItemComponent extends State<AddResourceItemComponent> {
  void navigateToResourceList() {
    Navigator.pushNamed(
      context,
      buildIdRouteById(
        ROUTER_POST_RESOURCES_VIEW_ROUTE,
        int.parse(widget.post_id!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateToResourceList,
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
