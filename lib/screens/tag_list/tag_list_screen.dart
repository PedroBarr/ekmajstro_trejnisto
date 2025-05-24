import 'package:flutter/material.dart';

class TagListScreen extends StatefulWidget {
  final int? post_id;

  const TagListScreen({
    super.key,
    this.post_id,
  });

  @override
  State<TagListScreen> createState() => _TagListScreenState();
}

class _TagListScreenState extends State<TagListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tag List'),
      ),
      body: Center(
        child: Text('Tag List Screen'),
      ),
    );
  }
}
