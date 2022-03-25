import 'package:drift/drift.dart';
import 'package:youtube_downloader/data/models/download_item.dart';

part 'database.g.dart';

@DriftDatabase(tables: [DownloadItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e, );

  @override
  int get schemaVersion => 1;


  Stream<List<DownloadItem>> getAllDownloadItems() {
    return select(downloadItems).watch();
  }

  Future<int> insertItems(DownloadItem item){
    return into(downloadItems).insert(item);

  }

}
