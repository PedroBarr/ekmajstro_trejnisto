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
      color: Colors.white,
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: const Text('PLACEHOLDER_ADDPOSTITEM'),
    );
  }
}
