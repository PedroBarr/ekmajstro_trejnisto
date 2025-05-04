import 'package:flutter/material.dart';

class BackdropComponent extends StatefulWidget {
  bool is_showing;
  final Function? onBackdropTap;
  final Widget child;

  BackdropComponent({
    super.key,
    required this.is_showing,
    required this.child,
    this.onBackdropTap,
  });

  @override
  State<BackdropComponent> createState() => _BackdropComponent();
}

class _BackdropComponent extends State<BackdropComponent> {
  void confirmBackdroptap() {
    widget.onBackdropTap!();
  }

  @override
  void didUpdateWidget(BackdropComponent oldWidget) {
    if (widget.is_showing) {
      // _showDialog();
    }

    super.didUpdateWidget(oldWidget);
  }

  void _showDialog() {
    Navigator.of(context).push(
      MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return Container(
            width: 200,
            height: 200,
            color: Colors.amber,
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // return Builder(
    //   builder: (context) {
    //     if (widget.is_showing) {
    //       return Dialog.fullscreen(
    //         backgroundColor: Colors.transparent,
    //         child: Positioned(
    //           top: 0,
    //           left: 0,
    //           width: MediaQuery.of(context).size.width,
    //           height: MediaQuery.of(context).size.height,
    //           child: Stack(
    //             children: [
    //               GestureDetector(
    //                 onTap: () => confirmBackdroptap(),
    //                 child: BackdropFilter(
    //                   filter: ImageFilter.blur(
    //                     sigmaX: 3.0,
    //                     sigmaY: 3.0,
    //                   ),
    //                   child: Container(
    //                     width: MediaQuery.of(context).size.width,
    //                     height: MediaQuery.of(context).size.height,
    //                     color: Theme.of(context).dialogBackgroundColor,
    //                     child: Center(
    //                       child: widget.child,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     }
    //     return Container();
    //   },
    // );
  }
}
