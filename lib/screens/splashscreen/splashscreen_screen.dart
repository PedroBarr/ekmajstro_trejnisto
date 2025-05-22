import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:drop_shadow/drop_shadow.dart';

import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:ekmajstro_trejnisto/config/config.dart';

import 'splashscreen_constants.dart';

class SplashscreenScreen extends StatefulWidget {
  const SplashscreenScreen({super.key});

  @override
  State<SplashscreenScreen> createState() => _SplashscreenScreen();
}

class _SplashscreenScreen extends State<SplashscreenScreen>
    with SingleTickerProviderStateMixin {
  // Timer timer;
  late double _centered_point;
  late double _centered_point_x;
  late double _centered_point_y;
  late double _centered_point_r;
  late double _centered_point_f;

  @override
  void initState() {
    super.initState();
    _centered_point = 1.0;
    _centered_point_x = 0.0;
    _centered_point_y = 1.0;
    _centered_point_r = 1.0;
    _centered_point_f = 2.0;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(milliseconds: SPLASHSCREEN_REMAIN_MS), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        ROUTER_MAIN_ROUTE,
        (Route<dynamic> route) => false,
      );
    });

    _addOffset(0.0);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  void _addOffset(double offset) {
    setState(() {
      _centered_point += offset;
      _centered_point_x += 4 / 18 * offset;
      _centered_point_y += 45 / 120 * offset;
      _centered_point_r += offset / 5;
      _centered_point_f -= offset * 1.5;
    });

    if (_centered_point > -0.8) {
      Future.delayed(const Duration(milliseconds: 10), () {
        _addOffset(-0.1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.black,
                  Theme.of(context).colorScheme.onError,
                  Theme.of(context).primaryColor,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).primaryColor,
                  Theme.of(context).colorScheme.onError,
                  Colors.black,
                  Theme.of(context).colorScheme.onError,
                  Theme.of(context).primaryColor,
                  Colors.black,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.onError,
                  Colors.black,
                ],
                center: Alignment(
                  _centered_point_x,
                  _centered_point_y,
                ),
                radius: _centered_point_r,
                focal: Alignment.bottomLeft,
                focalRadius: _centered_point_f,
                tileMode: TileMode.mirror,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      APP_PARENT,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 19.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    SvgPicture.asset(
                      SPLASHSCREEN_SEPARATOR_ICON,
                      width: 9.0,
                      height: 9.0,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      APP_NAME,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 28.0,
                        letterSpacing: 9.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50.0,
                ),
                ColorFiltered(
                  colorFilter: ColorFilter.matrix(<double>[
                    0.2126 + (0.3937 - (0.3937 * _centered_point)),
                    0.7152 - (0.3576 - (0.3576 * _centered_point)),
                    0.0722 - (0.0361 - (0.0361 * _centered_point)),
                    0.0,
                    0.0,
                    //
                    0.2126 - (0.1063 - (0.1063 * _centered_point)),
                    0.7152 + (0.1424 - (0.1424 * _centered_point)),
                    0.0722 - (0.0361 - (0.0361 * _centered_point)),
                    0.0,
                    0.0,
                    //
                    0.2126 - (0.1063 - (0.1063 * _centered_point)),
                    0.7152 - (0.3576 - (0.3576 * _centered_point)),
                    0.0722 + (0.4639 - (0.4639 * _centered_point)),
                    0.0,
                    0.0,
                    //
                    0.0,
                    0.0,
                    0.0,
                    1.0,
                    0.0,
                  ]),
                  child: DropShadow(
                    blurRadius: 5.0,
                    offset: Offset(
                        _centered_point - 1, 3 / 2 * (_centered_point - 1)),
                    color: Theme.of(context).colorScheme.error,
                    child: SvgPicture.asset(
                      SPLASHSCREEN_MAIN_ICON,
                      width: 150.0,
                      height: 150.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40.0 - (_centered_point * 24),
            left: -24.0 - (_centered_point * 24),
            child: Image.asset(
              SPLASHSCREEN_TOP_LEFT_IMAGE,
              width: 150.0,
              height: 150.0,
              opacity: const AlwaysStoppedAnimation(0.3),
            ),
          ),
          Positioned(
            top: 40.0 + (_centered_point * 24),
            right: -24.0 - (_centered_point * 24),
            child: Image.asset(
              SPLASHSCREEN_TOP_RIGHT_IMAGE,
              width: 150.0,
              height: 150.0,
              opacity: const AlwaysStoppedAnimation(0.3),
            ),
          ),
          Positioned(
            bottom: 45.0,
            left: 0,
            child: Image.asset(
              SPLASHSCREEN_BOTTOM_LEFT_IMAGE,
              width: 150.0,
              height: 150.0,
              opacity: const AlwaysStoppedAnimation(0.5),
            ),
          ),
          // Positioned(
          //   bottom: 50.0,
          //   right: 0,
          //   child: Image.asset(
          //     SPLASHSCREEN_BOTTOM_RIGHT_IMAGE,
          //     width: 150.0,
          //     height: 150.0,
          //   ),
          // ),
        ],
      ),
    );
  }
}
