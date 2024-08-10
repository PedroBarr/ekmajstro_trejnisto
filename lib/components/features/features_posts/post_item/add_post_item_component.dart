import 'package:flutter/material.dart';

class AddPostItemComponent extends StatefulWidget {
  const AddPostItemComponent({super.key});

  @override
  State<AddPostItemComponent> createState() => _AddPostItemComponent();
}

class _AddPostItemComponent extends State<AddPostItemComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            color: Theme.of(context).colorScheme.surface,
            width: 1.0,
          ),
        ),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
