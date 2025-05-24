import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';

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
  List<Tag> _tags = [];
  List<Tag> _selected_tags = [];

  @override
  void initState() {
    super.initState();

    loadTags();
    debugPrint('TagListScreen initialized with post_id: ${widget.post_id}');
  }

  void loadTags() {
    getTags().then((tags) {
      setState(() {
        _tags = tags;
        debugPrint('Tags loaded: $_tags');
      });
    }).whenComplete(() {
      if (widget.post_id != null) {
        getPostTagsList(widget.post_id!).then((tags) {
          setState(() {
            _selected_tags = tags;
            debugPrint('Selected tags loaded: $_selected_tags');
          });
        });
      }
    });
  }

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
