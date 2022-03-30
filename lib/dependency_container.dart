import 'package:get_it/get_it.dart';
import 'package:youtube_downloader/data/db/database.dart';
import 'package:youtube_downloader/pages/main/link_extractor_dialog/link_extractor_dialog_bloc.dart';

var sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory(() => LinkExtractorDialogBloc());

  // database and repos
  sl.registerLazySingleton(() => AppDatabase);
}
