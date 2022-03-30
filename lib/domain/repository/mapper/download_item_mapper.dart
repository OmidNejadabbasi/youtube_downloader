import 'package:drift/drift.dart';
import 'package:youtube_downloader/data/db/database.dart';
import 'package:youtube_downloader/domain/entities/download_item.dart';

class DownloadItemMapper {
  static DownloadItemEntity mapToEntity(DownloadItem item) {
    return DownloadItemEntity(
      link: item.link,
      title: item.title,
      format: item.format ?? '',
      fps: item.fps ?? '',
      isAudio: item.isAudio,
      thumbnailLink: item.thumbnailLink ?? "",
      size: item.size,
    );
  }

  static DownloadItemsCompanion mapToDownloadItem(DownloadItemEntity entity) {
    return DownloadItemsCompanion(link: Value(entity.link));
  }
}
