import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/components/components.dart';
import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreen();
}

class _PostListScreen extends State<PostListScreen> {
  late Future<List<PostItem>> _posts;
  String _searchText = '';

  @override
  void initState() {
    super.initState();

    _posts = getPosts(with_preview: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SearchBarComponent(
                    hint_text: HINT_SEARCH_POST,
                    onChanged: (String value) {
                      setState(() {
                        _searchText = value;
                      });
                    }),
                const SizedBox(
                  height: 10.0,
                ),
                Flexible(
                  child: FutureBuilder(
                    future: _posts,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<PostItem>> snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: Column(children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Wrap(
                                  direction: Axis.vertical,
                                  spacing: 10.0,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    snapshot.data!
                                        .where((post) => post.title
                                            .toLowerCase()
                                            .contains(
                                                _searchText.toLowerCase()))
                                        .map((post) =>
                                            PostItemComponent(post: post))
                                        .toList(),
                                    [
                                      const AddPostItemComponent(),
                                    ]
                                  ].expand((x) => x).toList(),
                                ),
                              ),
                            ),
                          ]),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const FABEkmajstroComponent(),
        ],
      ),
    );
  }
}
