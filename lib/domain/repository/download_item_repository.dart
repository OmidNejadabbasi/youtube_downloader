import 'package:youtube_downloader/data/db/database.dart';
import 'package:youtube_downloader/domain/entities/download_item.dart';
import 'package:youtube_downloader/domain/repository/mapper/download_item_mapper.dart';

class DownloadItemRepository {
  final AppDatabase db;

  const DownloadItemRepository({
    required this.db,
  });

  Future<void> insertDownloadItemEntity(DownloadItemEntity entity) async {
    await db.insertItems(DownloadItemMapper.mapToDownloadItem(entity));
  }

  Future<void> updateEntity(DownloadItemEntity entity) async{

  }

  Stream<List<DownloadItemEntity>> getAllItemsStream() {
    return db.getAllDownloadItems().map((event) =>
        event.map((e) => DownloadItemMapper.mapToEntity(e)).toList());
  }

  void updateDownloadItemEntity(DownloadItemEntity value) {
    db.updateDownloadItem(DownloadItemMapper.mapToDownloadItem(value));
  }
}
