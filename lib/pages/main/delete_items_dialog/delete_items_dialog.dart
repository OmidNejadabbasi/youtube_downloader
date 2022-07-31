import 'package:flutter/material.dart';
import 'package:youtube_downloader/pages/main/delete_items_dialog/delete_mode.dart';
import 'package:youtube_downloader/shared/styles.dart';
import 'package:youtube_downloader/shared/utils.dart';

class DeleteItemsDialog extends StatefulWidget {
  List<List<dynamic>> files;
  int totalSize;

  DeleteItemsDialog({Key? key, required this.files, required this.totalSize})
      : super(key: key);

  @override
  State<DeleteItemsDialog> createState() => _DeleteItemsDialogState();
}

class _DeleteItemsDialogState extends State<DeleteItemsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Container(
          padding:
              const EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 4),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              "Do you want to delete the following items? (${humanReadableByteCountBin(widget.totalSize)})",
              style: Styles.labelTextStyle.copyWith(fontSize: 16),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                children: List.generate(
                  widget.files.length,
                  (index) => Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const SizedBox(height: 8),
                          Text(widget.files[index][0],
                              style: Styles.labelTextStyle),
                          Text(humanReadableByteCountBin(widget.files[index][1]),
                              style: Styles.labelTextStyle),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, DeleteMode.delete);
                  },
                  child: Text(
                    'With File',
                    style: Styles.labelTextStyle.copyWith(color: Styles.labelTextStyle.color?.withRed(130)),
                  ),
                ),
                const Expanded(child: SizedBox()),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, DeleteMode.abort);
                  },
                  child: const Text(
                    'Cancel',
                    style: Styles.labelTextStyle,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, DeleteMode.remove);
                  },
                  child: const Text(
                    'OK',
                    style: Styles.labelTextStyle,
                  ),
                )
              ],
            ),
          ]),
        ));
  }
}
