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
      duration: item.duration ?? 0,
      size: item.size,
      quality: item.quality ?? '',
      taskId: item.taskId,
      status: item.status,
    );
  }

  static DownloadItemsCompanion mapToDownloadItem(DownloadItemEntity item) {
    return DownloadItemsCompanion(
      link: Value(item.link),
      title: Value(item.title),
      format: Value(item.format ?? ''),
      fps: Value(item.fps ?? ''),
      isAudio: Value(item.isAudio),
      thumbnailLink: Value(item.thumbnailLink ?? ""),
      duration: Value(item.duration ?? 0),
      size: Value(item.size),
      quality: Value(item.quality ?? ''),
      taskId: Value(item.taskId),
      status: Value(item.status),
    );
  }
}
