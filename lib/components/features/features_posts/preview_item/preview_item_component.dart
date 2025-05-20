import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/components/components.dart';
import 'package:ekmajstro_trejnisto/screens/post_item/post_item.dart';

class PreviewItemComponent extends StatefulWidget {
  final PreviewItem preview;
  final bool is_publishable;

  const PreviewItemComponent({
    super.key,
    required this.preview,
    this.is_publishable = false,
  });

  @override
  State<PreviewItemComponent> createState() => _PreviewItemComponent();
}

class _PreviewItemComponent extends State<PreviewItemComponent> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return widget.is_publishable
            ? Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageFieldComponent(
                          height: 210,
                          value: widget.preview.image_url,
                          onConfirm: (value) {},
                          title: preview_cover_image_title,
                          is_title_editable: false,
                        ),
                        const Text(
                          preview_cover_image_title,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFieldComponent(
                      value: widget.preview.short_text,
                      font_size: 14,
                      bold_text: false,
                      max_length: 50,
                      onConfirm: (value) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFieldComponent(
                      value: widget.preview.long_text,
                      font_size: 14,
                      bold_text: false,
                      max_length: 50,
                      onConfirm: (value) {},
                    ),
                    SizedBox(
                      height: widget.is_publishable ? 10 : 0,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          height: 40.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              style: BorderStyle.solid,
                              color: Theme.of(context).colorScheme.onPrimary,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            Icons.swipe_up_alt_outlined,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    preview_warning_first_save,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onError,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
      },
    );
  }
}
