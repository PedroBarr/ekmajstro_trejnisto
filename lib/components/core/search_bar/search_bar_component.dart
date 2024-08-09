import 'package:flutter/material.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({super.key});

  @override
  State<SearchBarComponent> createState() => _SearchBarComponent();
}

class _SearchBarComponent extends State<SearchBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: const Text('PLACEHOLDER_SEARCHBAR'),
    );
  }
}
