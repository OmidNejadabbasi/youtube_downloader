
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:youtube_downloader/data/models/download_item.dart';

part 'database.g.dart';

@DriftDatabase(tables: [DownloadItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;


  Stream<List<DownloadItem>> getAllDownloadItems() {
    return select(downloadItems).watch();
  }

  Future<int> insertItems(DownloadItemsCompanion item){
    return into(downloadItems).insert(item);

  }

}
LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}