import 'dart:async';
import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:device_info/device_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/domain/entities/download_item.dart';
import 'package:youtube_downloader/domain/repository/download_item_repository.dart';
import 'package:youtube_downloader/pages/main/main_screeen_events.dart';

import 'main_screen_states.dart';

class MainScreenBloc {
  late DownloadItemRepository _repository;
  late List<BehaviorSubject<DownloadItemEntity>> observableItemList;
  bool _permissionReady = false;
  late String _localPath;

  MainScreenBloc(DownloadItemRepository repository) {
    _repository = repository;
    _repository.getAllItemsStream().listen((event) {
      observableItemList = event.map((e) => BehaviorSubject.seeded(e)).toList();
      _mainScreenStateSubject.add(
        MainScreenState(
          observableItemList:
              event.map((e) => BehaviorSubject.seeded(e)).toList(),
        ),
      );
    });
    _mainScreenEvents.stream.listen((event) async {
      if (event.runtimeType == CheckStoragePermission) {
        await _prepare();
      }
    });
  }

  final _mainScreenStateSubject = BehaviorSubject();
  final _mainScreenEvents = StreamController();

  Sink get eventSink => _mainScreenEvents.sink;

  Stream get mainScreenState => _mainScreenStateSubject.stream;

  Future<void> _prepare() async {
    _permissionReady = await _checkPermission();

    if (_permissionReady) {
      await _prepareSaveDir();
      _mainScreenStateSubject.add(MainScreenState(
        observableItemList: observableItemList,
      ));
    } else {
      _mainScreenStateSubject.add(
        PermissionNotGrantedState(message: "Storage Permission not granted"),
      );
    }
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) return true;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (Platform.isAndroid && androidInfo.version.sdkInt <= 30) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        print("Permission result   "+result.toString());
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      try{
        await savedDir.create(recursive: true);
      } catch (e) {
        print("Error creating directory: "+e.toString());
      }
    }
  }

  Future<String?> _findLocalPath() async {
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  void dispose() {
    _mainScreenStateSubject.close();
  }
}
