import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/screens/section_item/section_item_view_constants.dart';
import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:ekmajstro_trejnisto/components/components.dart';

class SectionItemView extends StatefulWidget {
  final int post_id;
  final int? section_id;

  const SectionItemView({
    super.key,
    required this.post_id,
    this.section_id,
  });

  @override
  State<SectionItemView> createState() => _SectionItemView();
}

class _SectionItemView extends State<SectionItemView> {
  Section _section = Section();
  List<SegmentItem> _segments = [];

  bool _is_loading = false;
  bool _is_modified = false;

  int _MAX_SEGMENT_LINES = 5;
  List<List<SegmentItem>> _segment_lines_pages = [];
  int _segment_lines_page = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      double screen_height = MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.vertical;
      double app_bar_height =
          AppBar().preferredSize.height + MediaQuery.of(context).padding.top;
      double navigation_bar_height = MediaQuery.of(context).padding.bottom + 70;

      double segment_height = 50;
      double segment_spacing = 10;

      double canvas_height =
          screen_height - app_bar_height - navigation_bar_height;
      double segment_lines = (canvas_height - segment_spacing) /
          (segment_height + segment_spacing);
      _MAX_SEGMENT_LINES = segment_lines.toInt();
    });

    if (widget.section_id != null && isNumeric(widget.section_id!.toString())) {
      toggleLoading(true);

      getSection(widget.section_id!.toString()).then((section) {
        if (!mounted) return;

        setState(() {
          _section = section;
        });
      }).whenComplete(() {
        if (!mounted) return;

        loadSegments();
      });
    }
    toggleModified(false);
  }

  void setSection(String attr, dynamic value) {
    if (!mounted) return;

    switch (attr) {
      case 'name':
        setState(() {
          _section.name = value;
        });
        break;
      default:
        break;
    }

    setState(() {
      toggleModified(true);
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

  void onSave() {
    String message = '';

    try {
      saveSection(_section, widget.post_id).then((value) {
        if (!mounted) return;

        setState(() {
          _section = Section.fromSection(value);
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

  void onMark() {
    String message = '';

    try {
      markSection(_section).then((value) {
        if (!mounted) return;

        setState(() {
          _section = Section.fromSection(value);
        });
      });
      message = 'Marcado exitoso';
    } catch (e) {
      Navigator.of(context).pop();
      message = 'Marcado fallido';
    } finally {
      showMessage(message, context);
    }
  }

  void navigateToSegment(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }

  String _buildRoute({SegmentItem? segment}) {
    List<String> subpaths = [
      buildIdRouteById(ROUTER_POST_VIEW_ROUTE, widget.post_id),
      buildIdRoute(ROUTER_SECTION_ITEM_SUB_ROUTE,
          SectionItem.fromJson(_section.toMap(false, false))),
      (segment == null
          ? ROUTER_SEGMENT_ADD_SUB_ROUTE
          : buildIdRoute(ROUTER_SEGMENT_ADD_SUB_ROUTE, segment)),
    ];

    return buildSubRoute(subpaths);
  }

  void onRelocateSegment(
    SegmentItem segment,
    SegmentDirection direction,
  ) {
    relocateSegment(segment, getSegmentDirectionName(direction))
        .whenComplete(() {
      loadSegments();
    });
  }

  loadSegments() {
    toggleLoading(true);

    getSectionSegments(_section).then((segments) {
      segments.sort((a, b) => a.order.compareTo(b.order));

      if (mounted) {
        setState(() {
          _segments = segments;
        });
      }

      return segments;
    }).then((segments) {
      if (!mounted) return;

      initSegmentLinesPages(segments);
    }).whenComplete(() {
      if (!mounted) return;

      toggleLoading(false);
    });
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
                        child: iconNavPost(
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
                  return CustomTextFieldComponent(
                    value: _section.name,
                    spacing: 10.0,
                    font_size: 16,
                    max_length: 30,
                    onConfirm: (value) {
                      setSection('name', value);
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          body: Builder(
            builder: (context) {
              return _is_loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : (_segment_lines_pages.isNotEmpty
                      ? FlexGrid(
                          children: getSegmentCurrentPage()
                              .map(
                                (segment) => FlexGridItem(
                                  size: getFlexGridSize(segment.measure),
                                  child: getContainer(segment),
                                ),
                              )
                              .toList())
                      : const Center(
                          child: Text(
                            section_segments_empty,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ));
            },
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_segments.length}',
                  style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily: 'Roboto',
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: IconButton(
                    icon: Icon(isFirstPage()
                        ? Icons.arrow_circle_left_outlined
                        : Icons.arrow_circle_left_sharp),
                    color: isFirstPage()
                        ? Colors.grey
                        : Theme.of(context).colorScheme.onSurface,
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
                    iconSize: 30,
                    onPressed: () {
                      previousPage();
                    },
                  ),
                ),
                Builder(builder: (context) {
                  return _section.id.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: IconButton(
                            icon: const Icon(Icons.stars),
                            color: _section.is_mark_one
                                ? Theme.of(context).colorScheme.onSurface
                                : Colors.grey,
                            style: ButtonStyle(
                              overlayColor: WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                            ),
                            iconSize: 40,
                            onPressed: () {
                              if (!_section.is_mark_one) {
                                onMark();
                              } else {
                                showMessage(
                                  segment_mark_already,
                                  context,
                                );
                              }
                            },
                          ),
                        )
                      : SizedBox(
                          width: 10,
                        );
                }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: IconButton(
                    icon: Icon(isLastPage()
                        ? Icons.arrow_circle_right_outlined
                        : Icons.arrow_circle_right_sharp),
                    color: isLastPage()
                        ? Colors.grey
                        : Theme.of(context).colorScheme.onSurface,
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
                    iconSize: 30,
                    onPressed: () {
                      nextPage();
                    },
                  ),
                ),
                const Spacer(),
                Text(
                  '${_segments.length}',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.transparent,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: (_section.id.isNotEmpty
              ? FloatingActionButton(
                  onPressed: () {
                    navigateToSegment(context, _buildRoute());
                  },
                  backgroundColor: Theme.of(context).colorScheme.onSurface,
                  tooltip: section_segments_add,
                  mini: true,
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : null),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }

  Widget getContainer(SegmentItem segment) {
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
          top: 5,
          bottom: 5,
        ),
        child: GestureDetector(
          onTap: () {
            navigateToSegment(context, _buildRoute(segment: segment));
          },
          child: Container(
            decoration: BoxDecoration(
              color: getColor(segment.type),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Builder(
                  builder: (context) {
                    return isFirstSegment(segment)
                        ? const SizedBox(
                            width: 20,
                          )
                        : GestureDetector(
                            onTap: () {
                              onRelocateSegment(
                                segment,
                                SegmentDirection.up,
                              );
                            },
                            child: Icon(
                              getSegmentDirectionIcon(SegmentDirection.up),
                              color: Colors.white,
                              size: 20,
                            ),
                          );
                  },
                ),
                const Spacer(),
                getIcon(segment.type),
                const Spacer(),
                Builder(
                  builder: (context) {
                    return isLastSegment(segment)
                        ? const SizedBox(
                            width: 20,
                          )
                        : GestureDetector(
                            onTap: () {
                              onRelocateSegment(
                                segment,
                                SegmentDirection.down,
                              );
                            },
                            child: Icon(
                              getSegmentDirectionIcon(SegmentDirection.down),
                              color: Colors.white,
                              size: 20,
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isFirstSegment(SegmentItem segment) {
    return _segments.indexOf(segment) == 0;
  }

  Color getColor(SegmentType type) {
    return switch (type) {
      SegmentType.text => Color.fromARGB(255, 207, 194, 152),
      SegmentType.image => const Color.fromARGB(255, 51, 46, 100),
    };
  }

  Icon getIcon(SegmentType type) {
    return switch (type) {
      SegmentType.text => const Icon(Icons.text_fields),
      SegmentType.image => const Icon(
          Icons.image,
          color: Colors.white,
        ),
    };
  }

  bool isLastSegment(SegmentItem segment) {
    return _segments.indexOf(segment) == _segments.length - 1;
  }

  FlexGridSize getFlexGridSize(SegmentMeasure measure) {
    return switch (measure) {
      SegmentMeasure.full => FlexGridSize.full,
      SegmentMeasure.half => FlexGridSize.half,
      SegmentMeasure.third => FlexGridSize.third,
    };
  }

  List<SegmentItem> getSegmentCurrentPage() {
    return _segment_lines_pages[_segment_lines_page];
  }

  bool isLastPage() {
    return _segment_lines_pages.isEmpty ||
        _segment_lines_page == _segment_lines_pages.length - 1;
  }

  bool isFirstPage() {
    return _segment_lines_page == 0;
  }

  void nextPage() {
    if (!isLastPage()) {
      if (!mounted) return;

      setState(() {
        _segment_lines_page++;
      });
    }
  }

  void previousPage() {
    if (!isFirstPage()) {
      if (!mounted) return;

      setState(() {
        _segment_lines_page--;
      });
    }
  }

  void initSegmentLinesPages(List<SegmentItem> segments) {
    Map<SegmentMeasure, double> widthDict = {
      SegmentMeasure.full: 1,
      SegmentMeasure.half: 0.5,
      SegmentMeasure.third: 0.33,
    };

    double current_width = 0;
    List<SegmentItem> current_page = [];
    List<List<SegmentItem>> pages = [];
    int current_line = 0;

    for (var segment in segments) {
      double width = widthDict[segment.measure]!;
      current_width += width;

      if (current_line >= _MAX_SEGMENT_LINES) {
        pages.add(current_page);
        current_page = [];
        current_line = 0;
      }

      if (current_width >= 1) {
        current_line++;
        current_width = current_width == 1 ? 0 : width;
      }

      current_page.add(segment);
    }

    if (current_page.isNotEmpty) {
      pages.add(current_page);
    }

    if (!mounted) return;

    setState(() {
      _segment_lines_pages = pages;
    });

    if (pages.isNotEmpty && mounted) {
      setState(() {
        _segment_lines_page = 0;
      });
    }
  }
}
