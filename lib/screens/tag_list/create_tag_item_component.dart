import 'package:flutter/material.dart';

import 'tag_list_constants.dart';

import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/components/components.dart';

class CreateTagItemComponent extends StatefulWidget {
  final Function(Tag)? onTagAdded;

  const CreateTagItemComponent({
    super.key,
    this.onTagAdded,
  });

  @override
  State<CreateTagItemComponent> createState() => _CreateTagItemComponentState();
}

class _CreateTagItemComponentState extends State<CreateTagItemComponent> {
  String _name = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.my_library_add),
      tooltip: CREATE_TAG_TITLE,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return DialogSimpleTextComponent(
              title: CREATE_TAG_TITLE,
              text: CREATE_TAG_DESCRIPTION,
              confirmText: CREATE_TAG_CONFIRM_TEXT,
              onConfirm: () {
                Tag tag = Tag(
                  name: _name,
                  description: _description,
                );

                createTag(tag).then((newTag) {
                  setState(() {
                    _name = '';
                    _description = '';
                  });

                  if (widget.onTagAdded != null) {
                    widget.onTagAdded!(newTag);
                  }
                });

                Navigator.of(context).pop();
              },
              showField: true,
              field: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.height * 0.75,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10.0),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: CREATE_TAG_NAME_LABEL,
                        hintText: CREATE_TAG_NAME_HINT,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: CREATE_TAG_DESCRIPTION_LABEL,
                        hintText: CREATE_TAG_DESCRIPTION_HINT,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          _description = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              onCancel: () {
                setState(() {
                  _name = '';
                  _description = '';
                });

                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }
}
