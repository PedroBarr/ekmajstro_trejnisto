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
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar publicación',
          prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
        ),
        style: TextStyle(color: Theme.of(context).primaryColor),
        onChanged: (event) {},
      ),
    );
  }
}
