import 'package:flutter/material.dart';

class SplashscreenScreen extends StatefulWidget {
  const SplashscreenScreen({super.key});

  @override
  State<SplashscreenScreen> createState() => _SplashscreenScreen();
}

class _SplashscreenScreen extends State<SplashscreenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Here I Stand',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
