import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'FAB_ekmajstro_constants.dart';

class FABEkmajstroComponent extends StatefulWidget {
  const FABEkmajstroComponent({super.key});

  @override
  State<FABEkmajstroComponent> createState() => _FABEkmajstroComponent();
}

class _FABEkmajstroComponent extends State<FABEkmajstroComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      width: 60.0,
      height: 60.0,
      padding: const EdgeInsets.all(2.0),
      child: IconButton(
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {},
        icon: ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            0.2126,
            0.7152,
            0.0722,
            0.0,
            0.0,
            //
            0.2126,
            0.7152,
            0.0722,
            0.0,
            0.0,
            //
            0.2126,
            0.7152,
            0.0722,
            0.0,
            0.0,
            //
            0.0,
            0.0,
            0.0,
            1.0,
            0.0,
          ]),
          child: SvgPicture.asset(
            FAB_ICON,
            width: 100.0,
            height: 100.0,
          ),
        ),
      ),
    );
  }
}
