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
      double screen_height = MediaQuery.of(context).size.height;
      double app_bar_height = AppBar().preferredSize.height;

      double segment_height = 50;
      double segment_spacing = 8;

      double canvas_height = screen_height - app_bar_height;
      double segment_lines = (canvas_height - segment_spacing) /
          (segment_height + segment_spacing);
      _MAX_SEGMENT_LINES = segment_lines.toInt();
    });

    if (widget.section_id != null && isNumeric(widget.section_id!.toString())) {
      toggleLoading(true);

      getSection(widget.section_id!.toString()).then((section) {
        setState(() {
          _section = section;
        });
      }).whenComplete(() {
        getSectionSegments(_section).then((segments) {
          segments.sort((a, b) => a.order.compareTo(b.order));

          setState(() {
            _segments = segments;
          });

          return segments;
        }).then((segments) {
          initSegmentLinesPages(segments);
        }).whenComplete(() {
          toggleLoading(false);
        });
      });
    }
    toggleModified(false);
  }

  void setSection(String attr, dynamic value) {
    setState(() {
      toggleModified(true);
    });
  }

  void toggleModified(dynamic value) {
    setState(() {
      if ([true, false].contains(value)) {
        _is_modified = value;
      } else {
        _is_modified = !_is_modified;
      }
    });
  }

  void toggleLoading(dynamic value) {
    setState(() {
      if ([true, false].contains(value)) {
        _is_loading = value;
      } else {
        _is_loading = !_is_loading;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {},
              child: Icon(Icons.keyboard_backspace),
            ),
            actions: [
              Builder(builder: (context) {
                if (_is_modified) {
                  return GestureDetector(
                    onTap: () {},
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
                if (_section.name.isNotEmpty) {
                  return CustomTextFieldComponent(
                    value: _section.name,
                    spacing: 10.0,
                    font_size: 16,
                    max_length: 30,
                    onConfirm: (value) {},
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
                    iconSize: 30,
                    onPressed: () {
                      previousPage();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: IconButton(
                    icon: const Icon(Icons.stars),
                    color: _section.is_mark_one
                        ? Theme.of(context).colorScheme.onSurface
                        : Colors.grey,
                    iconSize: 40,
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: IconButton(
                    icon: Icon(isLastPage()
                        ? Icons.arrow_circle_right_outlined
                        : Icons.arrow_circle_right_sharp),
                    color: isLastPage()
                        ? Colors.grey
                        : Theme.of(context).colorScheme.onSurface,
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            tooltip: section_segments_add,
            mini: true,
            shape: const CircleBorder(),
            child: Icon(
              Icons.add,
              color: Theme.of(context).primaryColor,
            ),
          ),
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
        child: Container(
          decoration: BoxDecoration(
            color: getColor(segment.type),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: Center(
            child: getIcon(segment.type),
          ),
        ),
      ),
    );
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
      setState(() {
        _segment_lines_page++;
      });
    }
  }

  void previousPage() {
    if (!isFirstPage()) {
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

      if (current_width >= 1) {
        current_line++;
        current_width = current_width == 1 ? 0 : width;
      }

      if (current_line >= _MAX_SEGMENT_LINES) {
        pages.add(current_page);
        current_page = [];
        current_line = 0;
      }

      current_page.add(segment);
    }

    if (current_page.isNotEmpty) {
      pages.add(current_page);
    }

    setState(() {
      _segment_lines_pages = pages;
    });

    if (pages.isNotEmpty) {
      setState(() {
        _segment_lines_page = 0;
      });
    }
  }
}
