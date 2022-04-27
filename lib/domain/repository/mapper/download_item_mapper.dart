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
      thumbnailLink: item.thumbnail_link ?? "",
      duration: item.duration ?? 0,
      size: item.size,
      quality: item.quality ?? '',
      taskId: item.task_id,
      status: item.status,
    );
  }

  static DownloadItemsCompanion mapToDownloadItem(DownloadItemEntity item) {
    return DownloadItemsCompanion(
      link: Value(item.link),
      title: Value(item.title),
      format: Value(item.format),
      fps: Value(item.fps),
      isAudio: Value(item.isAudio),
      thumbnail_link: Value(item.thumbnailLink),
      duration: Value(item.duration),
      size: Value(item.size),
      quality: Value(item.quality),
      task_id: Value(item.taskId),
      status: Value(item.status),
    );
  }
}
