import 'package:flutter/material.dart';
import 'package:youtube_downloader/shared/styles.dart';

import '../../shared/my_flutter_app_icons.dart';
import '../../shared/widgets/icon_button.dart';

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
        padding: const EdgeInsets.all(14),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
            Text('Link', style: Styles.labelTextStyle,),
            NIconButton(
              icon: CustomIcons.clipboard,
              iconSize: 20,
            ),
          ]),
          const SizedBox(height: 12,),
          TextFormField(
            controller: _linkInputController,

            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Paste...',
              labelStyle: Styles.labelTextStyle,
            ),
          ),
        ]),
      ),
    );
  }
}
