
import 'package:drift/drift.dart';


@DataClassName("DownloadItem")
class DownloadItems extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get link => text()();
  TextColumn get title => text()();
  IntColumn get size => integer().withDefault(const Constant(0))();
  TextColumn get format => text().nullable()();
  TextColumn get fps => text().nullable()();
  BoolColumn get isAudio => boolean()();
  TextColumn get quality => text().nullable()();
  IntColumn get duration => integer().nullable()();
  TextColumn get thumbnail_link => text().nullable()();
  TextColumn get task_id => text()();
  TextColumn get status => text()();


}