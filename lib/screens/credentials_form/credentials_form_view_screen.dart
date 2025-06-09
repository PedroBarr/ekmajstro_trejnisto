import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/components/components.dart';

class CredentialsFormViewScreen extends StatefulWidget {
  const CredentialsFormViewScreen({super.key});

  @override
  State<CredentialsFormViewScreen> createState() =>
      _CredentialsFormViewScreenState();
}

class _CredentialsFormViewScreenState extends State<CredentialsFormViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const FABEkmajstroComponent(),
        ],
      ),
    );
  }
}
