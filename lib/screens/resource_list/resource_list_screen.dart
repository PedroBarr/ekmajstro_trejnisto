import 'package:ekmajstro_trejnisto/models/models.dart';

import 'package:flutter/material.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:ekmajstro_trejnisto/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              const SizedBox(height: 10.0),
              Column(
                children: _resources.where((resource) {
                  return resource.name
                          .toLowerCase()
                          .contains(_search_text.toLowerCase()) ||
                      resource.description
                          .toLowerCase()
                          .contains(_search_text.toLowerCase());
                }).map<Widget>((resource) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width - 20.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              resource.name,
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.8,
                              ),
                              child: Text(
                                resource.description,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SvgPicture.network(
                          resource.parseTypeIcon(),
                          width: 35.0,
                          height: 35.0,
                        ),
                      ],
                    ),
                  );
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
