import 'package:flutter/material.dart';

class ResourceItemViewScreen extends StatefulWidget {
  final int? resource_id;
  final int? post_id;

  const ResourceItemViewScreen({
    super.key,
    this.resource_id,
    this.post_id,
  });

  @override
  State<ResourceItemViewScreen> createState() => _ResourceItemViewScreen();
}

class _ResourceItemViewScreen extends State<ResourceItemViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
