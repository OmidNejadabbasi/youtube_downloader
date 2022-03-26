import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/pages/main/link_extractor_dialog/link_extractor_dialog_events.dart';
import 'package:youtube_downloader/pages/main/link_extractor_dialog/link_extractor_dialog_states.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class LinkExtractorDialogBloc {
  final StreamController<LinkExtractorDialogEvent> _eventController =
      StreamController();

  Sink<LinkExtractorDialogEvent> get eventSink => _eventController.sink;

  final BehaviorSubject dialogState = BehaviorSubject.seeded(IdleState());

  LinkExtractorDialogBloc() {
    _eventController.stream.listen((event) {
      mapDialogEventToState(event);
    });
  }

  void dispose() {
    _eventController.close();
  }

  void mapDialogEventToState(LinkExtractorDialogEvent event) async {

    if (event.runtimeType == ExtractLinkEvent){
      dialogState.add(LinksListLoading());

      try {
        var yt = YoutubeExplode();
        var videoId = VideoId((event as ExtractLinkEvent).link);

        Video video = await yt.videos.get(videoId);
        var manifest = await yt.videos.streamsClient.getManifest(videoId);

        // TODO extract download items
      }catch(e){

      }

    }

  }
}
