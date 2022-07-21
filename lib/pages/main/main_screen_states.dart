import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/domain/entities/download_item.dart';

class MainScreenState {

  final List<BehaviorSubject<DownloadItemEntity>> observableItemList;

  MainScreenState({required this.observableItemList, });

}

class PermissionNotGrantedState {
  final String message;

  PermissionNotGrantedState({required this.message});
}