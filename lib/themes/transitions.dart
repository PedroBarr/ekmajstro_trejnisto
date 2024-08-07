import 'package:flutter/material.dart';

Widget fadeTransition(_, animation, __, child) {
  return FadeTransition(opacity: animation, child: child);
}

Widget pushOverTop(_, animation, __, child) {
  const begin = Offset(0.0, 1.0);
  const end = Offset.zero;
  const curve = Curves.ease;

  var tween = Tween(
    begin: begin,
    end: end,
  ).chain(CurveTween(curve: curve));

  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}
