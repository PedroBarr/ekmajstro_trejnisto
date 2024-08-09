import 'package:flutter/material.dart';
import 'dart:async';

import 'package:ekmajstro_trejnisto/components/components.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          children: [
            const SearchBarComponent(),
            const SizedBox(
              height: 10.0,
            ),
            FutureBuilder(
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
                                    .map((post) => Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          padding: const EdgeInsets.all(10.0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              20.0,
                                          child: Row(
                                            children: [
                                              Text(post.title),
                                            ],
                                          ),
                                        ))
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
                    return const CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
