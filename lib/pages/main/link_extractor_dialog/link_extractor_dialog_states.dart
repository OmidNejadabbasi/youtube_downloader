
import 'package:youtube_downloader/domain/entities/download_item.dart';

class IdleState{}

class LinksListLoading {}

class LinksLoadedState {
  final List<DownloadItemEntity> links;

  LinksLoadedState(this.links);
}

class LoadingUnsuccessful {
  final Error e;

  LoadingUnsuccessful(this.e);
}
