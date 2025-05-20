import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/components/components.dart';

class SectionItemView extends StatefulWidget {
  final int post_id;
  final int? section_id;

  const SectionItemView({
    super.key,
    required this.post_id,
    this.section_id,
  });

  @override
  State<SectionItemView> createState() => _SectionItemView();
}

class _SectionItemView extends State<SectionItemView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          // appBar: AppBar(
          // leading: GestureDetector(
          //   onTap: () => navigateToPostList(context),
          //   child: iconNavPostList(Theme.of(context).colorScheme.onSurface),
          // ),
          // actions: [
          //   Builder(builder: (context) {
          //     if (_is_modified) {
          //       return GestureDetector(
          //         onTap: onSave,
          //         child: const Padding(
          //           padding: EdgeInsets.only(
          //             right: 10.0,
          //             left: 10.0,
          //           ),
          //           child: Icon(
          //             Icons.save_as_rounded,
          //           ),
          //         ),
          //       );
          //     }
          //     return Container();
          //   }),
          // ],
          // title: Builder(
          //   builder: (context) {
          //     if (!_is_loading) {
          //       return CustomTextFieldComponent(
          //         value: _post.title,
          //         spacing: 10.0,
          //         font_size: 16,
          //         onConfirm: (value) => setPost(Post.POST_ATTR_TITTLE, value),
          //       );
          //     } else {
          //       return const CircularProgressIndicator();
          //     }
          //   },
          // ),
          // ),
          body: SizedBox.shrink(),
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }
}
