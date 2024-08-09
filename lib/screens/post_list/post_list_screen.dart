import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreen();
}

class _PostListScreen extends State<PostListScreen> {
  late Future<List<PostItem>> _posts;

  @override
  void initState() {
    super.initState();

    _posts = getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
