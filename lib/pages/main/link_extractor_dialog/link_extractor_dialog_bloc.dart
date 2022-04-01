import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/domain/entities/download_item.dart';
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
    dialogState.close();
  }

  void mapDialogEventToState(LinkExtractorDialogEvent event) async {
    if (event.runtimeType == ExtractLinkEvent) {
      print("extract link event");
      dialogState.add(LinksListLoading());

      try {
        var yt = YoutubeExplode();

        var videoId = VideoId((event as ExtractLinkEvent).link);

        print('vidoe id found : ${videoId.value}');

        Video video = await yt.videos.get(videoId);
        print('video data fetched');
        var manifest = await yt.videos.streamsClient.getManifest(videoId);

        // TODO extract download items
        List<DownloadItemEntity> linksList = [];
        for (var item in manifest.muxed) {
          linksList.add(DownloadItemEntity(
            link: item.url.toString(),
            thumbnailLink: video.thumbnails.mediumResUrl,
            isAudio: false,
            fps: item.framerate.toString(),
            format: item.container.toString(),
            title: video.title,
            quality: item.videoQuality.toString().replaceAll(RegExp('[A-Za-z.]+'), '') + "p",
          ));
        }
        for (var item in manifest.video) {
          linksList.add(DownloadItemEntity(
            link: item.url.toString(),
            thumbnailLink: video.thumbnails.mediumResUrl,
            isAudio: false,
            fps: item.framerate.toString(),
            format: item.container.toString(),
            title: video.title,
            quality: item.videoQuality.toString().replaceAll(RegExp('[A-za-z.]'), '') + "p",
          ));
        }
        dialogState.add(LinksLoadedState(linksList, video));
      } catch (err) {
        dialogState.add(LoadingUnsuccessful(err as Error));
      }
    }
  }
}
