
import 'package:youtube_downloader/domain/entities/download_item.dart';

class CheckStoragePermission {}

class AddDownloadItemEvent{

  final DownloadItemEntity entity;

  AddDownloadItemEvent(this.entity);
}