import 'package:ekmajstro_trejnisto/models/models.dart';

import 'package:flutter/material.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:ekmajstro_trejnisto/components/components.dart';

class ResourceListScreen extends StatefulWidget {
  const ResourceListScreen({super.key});

  @override
  State<ResourceListScreen> createState() => _ResourceListScreen();
}

class _ResourceListScreen extends State<ResourceListScreen> {
  List<ResourceItem> _resources = [];

  String _search_text = '';

  @override
  void initState() {
    super.initState();
    getResources().then((resources) {
      if (mounted) {
        setState(() {
          _resources = resources;
        });
      }
    });
  }

  @override
  build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Recursos'),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              SearchBarComponent(
                  hint_text: 'Buscar etiqueta',
                  onChanged: (String value) {
                    setState(() {
                      _search_text = value;
                    });
                  }),
              ResourceItemListComponent(
                resources: _resources.where((resource) {
                  return resource.name
                          .toLowerCase()
                          .contains(_search_text.toLowerCase()) ||
                      resource.description
                          .toLowerCase()
                          .contains(_search_text.toLowerCase());
                }).toList(),
              ),
            ]),
          ),
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }
}
