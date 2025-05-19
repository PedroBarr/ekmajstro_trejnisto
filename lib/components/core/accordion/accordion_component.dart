import 'package:flutter/material.dart';

import 'accordion_utils.dart';

class AccordionComponent extends StatefulWidget {
  final List<AccordionElement> elements;

  const AccordionComponent({
    super.key,
    required this.elements,
  });

  @override
  State<AccordionComponent> createState() => _AccordionComponent();
}

class _AccordionComponent extends State<AccordionComponent> {
  List<AccordionElement> _elements = [];

  @override
  void initState() {
    super.initState();

    if (widget.elements.isNotEmpty) {
      setState(() {
        _elements = widget.elements;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool is_expand) {
            setState(() {
              _elements[index].is_expanded = is_expand;
            });
          },
          children: _elements.map<ExpansionPanel>((AccordionElement element) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool is_expand) {
                return ListTile(
                  title: Text(
                    element.name,
                    textAlign: TextAlign.center,
                  ),
                );
              },
              body: Builder(
                builder: (BuildContext context) {
                  return element.content;
                },
              ),
              isExpanded: element.is_expanded,
              canTapOnHeader: true,
            );
          }).toList(),
          expandIconColor: Theme.of(context).colorScheme.onSurface,
          expandedHeaderPadding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
