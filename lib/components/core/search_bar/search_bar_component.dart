import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/config/config.dart';

class SearchBarComponent extends StatefulWidget {
  final String hint_text;
  final Function? onChanged;

  const SearchBarComponent({
    super.key,
    this.hint_text = HINT_SEARCH_DEFAULT,
    this.onChanged,
  });

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
          hintText: widget.hint_text,
          prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
        ),
        style: TextStyle(color: Theme.of(context).primaryColor),
        onChanged: (event) {
          if (widget.onChanged != null) {
            widget.onChanged!(event);
          }
        },
      ),
    );
  }
}
