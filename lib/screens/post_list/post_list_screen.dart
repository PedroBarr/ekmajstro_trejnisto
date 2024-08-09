import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                                    .map(
                                        (post) => PostItemComponent(post: post))
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
      floatingActionButton: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/images/icons/ekmajstro.svg',
            width: 100.0,
            height: 100.0,
          )),
    );
  }
}
