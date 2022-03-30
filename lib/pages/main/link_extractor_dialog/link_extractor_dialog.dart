import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_downloader/dependency_container.dart';
import 'package:youtube_downloader/pages/main/link_extractor_dialog/link_extractor_dialog_bloc.dart';
import 'package:youtube_downloader/pages/main/link_extractor_dialog/link_extractor_dialog_events.dart';
import 'package:youtube_downloader/pages/main/link_extractor_dialog/link_extractor_dialog_states.dart';
import 'package:youtube_downloader/shared/styles.dart';

import 'package:youtube_downloader/shared/my_flutter_app_icons.dart';
import 'package:youtube_downloader/shared/widgets/icon_button.dart';

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

  late LinkExtractorDialogBloc _bloc;
  int selectedLinkInd = 0;

  @override
  void initState() {
    super.initState();
    _bloc = sl();
  }

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
                children: [
                  const Text(
                    'Link',
                    style: Styles.labelTextStyle,
                  ),
                  NIconButton(
                    icon: CustomIcons.clipboard,
                    iconSize: 20,
                    onPressed: () async {
                      ClipboardData? cData =
                          await Clipboard.getData("text/plain");
                      if (cData == null) {
                        _bloc.eventSink.add(NoClipboardDataEvent());
                        return;
                      } else {
                        var link = cData.text ?? '';
                        _bloc.eventSink.add(ExtractLinkEvent(link));
                        _linkInputController.text = link;
                      }
                    },
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
          StreamBuilder(
            stream: _bloc.dialogState,
            builder: (context, snapshot) {
              if (snapshot.data.runtimeType == LinksLoadedState) {
                var state = snapshot.data as LinksLoadedState;
                return Column(children: List.generate(state.links.length, (index) {
                  return Row(
                    children: [
                      Radio(value: index, groupValue: selectedLinkInd, onChanged: (val) {
                        if (val == null) return;
                        selectedLinkInd = val as int;
                      }),
                      Text(state.links[index].title, maxLines: 1,overflow: TextOverflow.ellipsis,),
                    ],
                  );
                }));
              } else if (snapshot.data.runtimeType == LoadingUnsuccessful){
                return Text("Error: ${(snapshot.data as LoadingUnsuccessful).e.toString()}");
              }
              return CircularProgressIndicator();
            },
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
            ],
          ),
        ]),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
