import 'package:flutter/material.dart';

class AddResourceItemComponent extends StatefulWidget {
  const AddResourceItemComponent({
    super.key,
  });

  @override
  State<AddResourceItemComponent> createState() => _AddResourceItemComponent();
}

class _AddResourceItemComponent extends State<AddResourceItemComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}
