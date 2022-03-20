import 'package:flutter/material.dart';
import 'package:youtube_downloader/shared/styles.dart';

import '../../../shared/my_flutter_app_icons.dart';
import '../../../shared/widgets/icon_button.dart';

class YoutubeLinkExtractorDialog extends StatefulWidget {
  const YoutubeLinkExtractorDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<YoutubeLinkExtractorDialog> createState() =>
      _YoutubeLinkExtractorDialogState();
}

class _YoutubeLinkExtractorDialogState
    extends State<YoutubeLinkExtractorDialog> {
  final _linkInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 4),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Link',
                    style: Styles.labelTextStyle,
                  ),
                  NIconButton(
                    icon: CustomIcons.clipboard,
                    iconSize: 20,
                  ),
                ]),
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: _linkInputController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Video Link or Id…',
              labelStyle: Styles.labelTextStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: const Text(
                'Cancel',
                style: Styles.labelTextStyle,
              ),
            ),
            const TextButton(
              onPressed: null,
              child: Text(
                'Start',
                style: Styles.labelTextStyle,
              ),
            )
          ],),
        ]),
      ),
    );
  }
}
