import 'package:ekmajstro_trejnisto/components/components.dart';
import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/screens/segment_item/segment_item_view_constants.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

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
      message = 'Guardado exitoso';
    } catch (e) {
      Navigator.of(context).pop();
      message = 'Guardado fallido';
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
                                const Text('Posición'),
                                Text(
                                  _segment.order == -1
                                      ? 'Sin asignar'
                                      : _segment.order.toString(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Medida'),
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
                                const Text('Clase'),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width / 2,
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Clase',
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
        Row(
          children: [
            Text(
              'Contenido',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 2,
              ),
              child: TextField(
                maxLines: 10,
                minLines: 5,
                decoration: InputDecoration(
                  hintText: 'Texto',
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
        ),
      ],
    );
  }

  Widget _buildImageSegment() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Imagen',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            CustomImageFieldComponent(
              height: 200,
              value: _segment.getMainContent(),
              onConfirm: (value) {
                setSegment('contenido_principal', value);
              },
            ),
          ],
        ),
      ],
    );
  }
}
