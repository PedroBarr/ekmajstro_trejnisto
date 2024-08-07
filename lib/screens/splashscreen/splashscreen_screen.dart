import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'splashscreen_constants.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:ekmajstro_trejnisto/themes/themes.dart';

class SplashscreenScreen extends StatefulWidget {
  const SplashscreenScreen({super.key});

  @override
  State<SplashscreenScreen> createState() => _SplashscreenScreen();
}

class _SplashscreenScreen extends State<SplashscreenScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(milliseconds: SPLASHSCREEN_REMAIN_MS), () {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => ROUTER_MAIN_PAGE,
          transitionDuration:
              const Duration(milliseconds: SPLASHSCREEN_TRANSITION_MS),
          transitionsBuilder: fadeTransition,
          maintainState: true,
        ),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              SPLASHSCREEN_MAIN_ICON,
              width: 100.0,
              height: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}
