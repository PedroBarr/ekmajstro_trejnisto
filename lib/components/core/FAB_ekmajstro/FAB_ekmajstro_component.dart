import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'FAB_ekmajstro_constants.dart';
import 'package:ekmajstro_trejnisto/components/core/navmenu/navmenu.dart';

class FABEkmajstroComponent extends StatefulWidget {
  const FABEkmajstroComponent({super.key});

  @override
  State<FABEkmajstroComponent> createState() => _FABEkmajstroComponent();
}

class _FABEkmajstroComponent extends State<FABEkmajstroComponent> {
  late bool _menu_open;

  @override
  void initState() {
    super.initState();

    _menu_open = false;
  }

  void toggleMenuOpen() {
    setState(() {
      _menu_open = !_menu_open;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Builder(builder: (context) {
            if (_menu_open) {
              return GestureDetector(
                onTap: () => toggleMenuOpen(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 3.0,
                    sigmaY: 3.0,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Theme.of(context).dialogBackgroundColor,
                    child: Center(
                      child: NavmenuComponent(
                        width: MediaQuery.of(context).size.width * 3 / 5,
                        height: MediaQuery.of(context).size.height * 7 / 10,
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          }),
          Positioned(
            right: 10.0,
            bottom: 10.0,
            child: Container(
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
                onPressed: () => toggleMenuOpen(),
                icon: switch (_menu_open) {
                  true => SvgPicture.asset(
                      FAB_ICON,
                      width: 150.0,
                      height: 150.0,
                    ),
                  _ => ColorFiltered(
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
