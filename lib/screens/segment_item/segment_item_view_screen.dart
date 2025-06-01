import 'package:flutter/material.dart';

import 'segment_item_view_constants.dart';

import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/components/components.dart';

class SegmentItemView extends StatefulWidget {
  final int post_id;
  final int section_id;
  final int? segment_id;

  const SegmentItemView({
    super.key,
    required this.post_id,
    required this.section_id,
    this.segment_id,
  });

  @override
  State<SegmentItemView> createState() => _SegmentItemView();
}

class _SegmentItemView extends State<SegmentItemView> {
  Segment _segment = Segment();

  bool _is_loading = false;
  bool _is_modified = false;

  String _part_name = '';

  @override
  void initState() {
    super.initState();

    if (widget.segment_id != null && isNumeric(widget.segment_id.toString())) {
      toggleLoading(true);

      getSegment(widget.segment_id!.toString()).then((segment) {
        if (!mounted) return;

        setState(() {
          _segment = segment;
        });
      }).whenComplete(() {
        if (!mounted) return;
        toggleLoading(false);
      });

      toggleModified(false);
    } else {
      toggleModified(true);
    }
  }

  void toggleLoading(dynamic value) {
    if (!mounted) return;

    setState(() {
      if ([true, false].contains(value)) {
        _is_loading = value;
      } else {
        _is_loading = !_is_loading;
      }
    });
  }

  void toggleModified(dynamic value) {
    if (!mounted) return;

    setState(() {
      if ([true, false].contains(value)) {
        _is_modified = value;
      } else {
        _is_modified = !_is_modified;
      }
    });
  }

  void setSegment(String attr, dynamic value) {
    if (!mounted) return;

    setState(() {
      Segment segment = Segment.fromSegment(_segment);
      _segment.setSegment(attr, value);

      if (!(segment == _segment)) {
        toggleModified(true);
      }
    });
  }

  void onSave() {
    String message = '';

    try {
      saveSegment(_segment, widget.section_id).then((value) {
        if (!mounted) return;

        setState(() {
          _segment = Segment.fromSegment(value);
        });
      });
      message = SEGMENT_SAVE_SUCCESS_MESSAGE;
    } catch (e) {
      Navigator.of(context).pop();
      message = SEGMENT_SAVE_ERROR_MESSAGE;
    } finally {
      showMessage(message, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (context) {
                return _is_loading
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: iconNavSection(
                            Theme.of(context).colorScheme.onSurface),
                      );
              },
            ),
            actions: [
              Builder(builder: (context) {
                if (_is_modified) {
                  return GestureDetector(
                    onTap: onSave,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        right: 10.0,
                        left: 10.0,
                      ),
                      child: Icon(
                        Icons.save_as_rounded,
                      ),
                    ),
                  );
                }
                return Container();
              }),
            ],
            title: Builder(
              builder: (context) {
                if (!_is_loading) {
                  return DropdownMenu<IconSegmentType>(
                    initialSelection: IconSegmentType.values.firstWhere(
                      (entry) => entry.type == _segment.type,
                      orElse: () => IconSegmentType.text,
                    ),
                    onSelected: (value) {
                      setSegment('type', getTextType(value!));
                    },
                    dropdownMenuEntries: IconSegmentType.entries,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          body: Builder(
            builder: (context) {
              return !_is_loading
                  ? Container(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 10.0,
                        bottom: 10.0,
                      ),
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.height - 20,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(SEGMENT_LABEL_POSITION),
                                Text(
                                  _segment.order == -1
                                      ? SEGMENT_POSITION_ERROR_MESSAGE
                                      : _segment.order.toString(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(SEGMENT_LABEL_MEASURE),
                                DropdownMenu<IconSegmentMeasure>(
                                  initialSelection:
                                      IconSegmentMeasure.values.firstWhere(
                                    (entry) =>
                                        entry.measure == _segment.measure,
                                    orElse: () => IconSegmentMeasure.full,
                                  ),
                                  onSelected: (value) {
                                    setSegment('measure', value!.measure);
                                  },
                                  dropdownMenuEntries:
                                      IconSegmentMeasure.entries,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(SEGMENT_LABEL_CLASS),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width / 2,
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: SEGMENT_LABEL_CLASS,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    controller: TextEditingController(
                                      text: _segment.getClass(),
                                    ),
                                    onSubmitted: (value) {
                                      setSegment('clase', value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Builder(
                              builder: (context) {
                                return !_is_loading
                                    ? switch (_segment.type) {
                                        SegmentType.text => _buildTextSegment(),
                                        SegmentType.image =>
                                          _buildImageSegment(),
                                      }
                                    : SizedBox.shrink();
                              },
                            ),
                            const SizedBox(height: 10.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                getContentKeys().length,
                                (index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(getContentKeys()[index]),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                        ),
                                        padding: const EdgeInsets.only(
                                          top: 5.0,
                                          bottom: 5.0,
                                        ),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: SEGMENT_LABEL_CONTENT,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          controller: TextEditingController(
                                            text: _segment.getContent(
                                                getContentKeys()[index]),
                                          ),
                                          onSubmitted: (value) {
                                            setSegment(
                                                getContentKeys()[index], value);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            (_segment.id.isEmpty
                                ? const SizedBox.shrink()
                                : GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return DialogSimpleTextComponent(
                                            title: SEGMENT_LABEL_ADD_PART,
                                            text:
                                                '$SEGMENT_LABEL_ADD_PART_MESSAGE_BASE${getSegmentTypeText(_segment.type)}',
                                            onConfirm: () {
                                              if (_part_name.isNotEmpty &&
                                                  mounted) {
                                                setState(() {
                                                  _segment.addPart(
                                                    _part_name,
                                                  );
                                                  _part_name = '';
                                                });

                                                Navigator.of(context).pop();
                                              }
                                            },
                                            showField: true,
                                            field: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                              constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75,
                                              ),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  hintText:
                                                      SEGMENT_PART_LABEL_NAME,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                                onSubmitted: (value) {
                                                  if (mounted) {
                                                    setState(() {
                                                      _part_name = value;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                            onCancel: () {
                                              if (mounted) {
                                                setState(() {
                                                  _part_name = '';
                                                });
                                              }

                                              Navigator.of(context).pop();
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          20,
                                      height: 50.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          style: BorderStyle.solid,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        size: 30.0,
                                      ),
                                    ),
                                  )),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }

  Widget _buildTextSegment() {
    return Column(
      children: [
        Text(
          SEGMENT_LABEL_CONTENT,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 20,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 20,
          ),
          child: TextField(
            maxLines: 10,
            minLines: 5,
            decoration: InputDecoration(
              hintText: SEGMENT_CONTENT_LABEL_TEXT_TYPE,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            controller: TextEditingController(
              text: _segment.getMainContent(),
            ),
            onSubmitted: (value) {
              setSegment('contenido_principal', value);
            },
            textInputAction: TextInputAction.done,
          ),
        ),
      ],
    );
  }

  Widget _buildImageSegment() {
    return Column(
      children: [
        Text(
          SEGMENT_CONTENT_LABEL_IMAGE_TYPE,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomImageFieldComponent(
          height: 200,
          value: _segment.getMainContent(),
          onConfirm: (value) {
            setSegment('contenido_principal', value);
          },
        ),
      ],
    );
  }

  List<String> getContentKeys() {
    return _segment.content.keys
        .where((key) => !defaultParts.contains(key))
        .toList();
  }
}
