import 'package:flutter/material.dart';

class CustomTextFieldComponent extends StatefulWidget {
  final String value;
  final Function? onConfirm;
  final double spacing;
  final double font_size;
  final bool bold_text;
  final bool is_editable;
  final int max_length;

  const CustomTextFieldComponent({
    super.key,
    this.value = '',
    this.onConfirm,
    this.spacing = double.infinity,
    this.font_size = 17.0,
    this.bold_text = true,
    this.is_editable = true,
    this.max_length = 0,
  });

  @override
  State<CustomTextFieldComponent> createState() => _CustomTextFieldComponent();
}

class _CustomTextFieldComponent extends State<CustomTextFieldComponent> {
  bool _is_edit_mode = false;
  final TextEditingController _controller = TextEditingController();
  bool _is_save_able = false;

  @override
  void initState() {
    super.initState();

    if (widget.value.isEmpty) {
      toggleEditMode(true);
    } else {
      toggleEditMode(false);
    }

    refreshValue();

    _controller.addListener(recalcSaveAble);
  }

  @override
  void dispose() {
    _controller.removeListener(recalcSaveAble);
    _controller.dispose();
    super.dispose();
  }

  void toggleEditMode(dynamic value) {
    if (!mounted) return;

    setState(() {
      if ([false, true].contains(value)) {
        _is_edit_mode = value;
      } else {
        _is_edit_mode = !_is_edit_mode;
      }
    });
  }

  void refreshValue() {
    if (!mounted) return;

    setState(() {
      _controller.text = widget.value;
    });
  }

  bool confirmValue() {
    if (_is_save_able) {
      widget.onConfirm!(_controller.text);
      return true;
    }
    return false;
  }

  void recalcSaveAble() {
    if (!mounted) return;

    final String text = _controller.text;

    setState(() {
      if (text.isEmpty || text.trim().isEmpty) {
        _is_save_able = false;
      } else {
        _is_save_able = true;
      }
    });
  }

  bool submit() {
    if (_is_save_able) {
      bool confirm = confirmValue();

      if (confirm) {
        toggleEditMode(null);

        return true;
      }
    }

    return false;
  }

  String getParsedText(String text) {
    if (widget.max_length == 0) {
      return text;
    }

    if (text.length > widget.max_length) {
      return "${text.substring(0, widget.max_length)}...";
    }

    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (_is_edit_mode) {
          return Container(
            constraints: BoxConstraints(
              maxWidth:
                  widget.spacing == double.infinity ? double.infinity : 500,
            ),
            child: Material(
              color: Colors.transparent,
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Builder(
                    builder: (context) {
                      if (!_is_save_able) {
                        return Container();
                      }

                      return GestureDetector(
                        onTap: () => submit(),
                        child: const Icon(
                          Icons.save_as_rounded,
                        ),
                      );
                    },
                  ),
                ),
                cursorColor: Theme.of(context).colorScheme.onSurface,
                controller: _controller,
                onSubmitted: (value) => submit(),
              ),
            ),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getParsedText(widget.value),
                style: TextStyle(
                  fontWeight:
                      widget.bold_text ? FontWeight.bold : FontWeight.normal,
                  fontSize: widget.font_size,
                  decoration: TextDecoration.none,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontFamily: 'Roboto',
                ),
              ),
              widget.spacing == double.infinity
                  ? const Spacer()
                  : SizedBox(
                      width: widget.spacing,
                    ),
              Builder(
                builder: (context) {
                  if (!widget.is_editable) {
                    return SizedBox.shrink();
                  } else {
                    return GestureDetector(
                      onTap: () {
                        toggleEditMode(null);
                        refreshValue();
                      },
                      child: Icon(
                        Icons.edit_square,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    );
                  }
                },
              ),
            ],
          );
        }
      },
    );
  }
}
