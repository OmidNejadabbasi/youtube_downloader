
import 'package:drift/drift.dart';


@DataClassName("DownloadItem")
class DownloadItems extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get link => text()();

}