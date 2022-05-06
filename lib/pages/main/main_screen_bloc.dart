import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/domain/entities/download_item.dart';
import 'package:youtube_downloader/domain/repository/download_item_repository.dart';
import 'package:youtube_downloader/pages/main/main_screeen_events.dart';

import 'main_screen_states.dart';

class MainScreenBloc {
  late DownloadItemRepository _repository;
  List<BehaviorSubject<DownloadItemEntity>> observableItemList = [];
  bool _permissionReady = false;
  late String _localPath;
  ReceivePort _port = ReceivePort();

  MainScreenBloc(DownloadItemRepository repository) {
    _repository = repository;
    _repository.getAllItemsStream().listen((event) {
      print('Download list updated');
      print(event.map((e) => e.id).toList());
      observableItemList = event.map((e) => BehaviorSubject.seeded(e)).toList();
      _mainScreenStateSubject.add(
        MainScreenState(
          observableItemList: observableItemList,
        ),
      );
    });
    _mainScreenEvents.stream.listen((event) async {
      if (event.runtimeType == CheckStoragePermission) {
        await _prepare();
      } else if (event.runtimeType == AddDownloadItemEvent) {
        final evt = event as AddDownloadItemEvent;

        String fileName = evt.entity.title+"-"+ evt.entity.fps + 'p.mp4';
        int counter = 1;
        while(File(_localPath +"/"+ fileName ).existsSync()){
          fileName = evt.entity.title+"-"+ evt.entity.fps + '($counter).mp4';
        }
        var taskId = await FlutterDownloader.enqueue(
            url: evt.entity.link,
            savedDir: _localPath,
            fileName: fileName,);
        await _repository
            .insertDownloadItemEntity(evt.entity.copyWith(taskId: taskId));
      }
    });
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      var item = observableItemList
          .where((element) => element.value.taskId == id)
          .toList()[0];
      print('update triggered');
      item.add(
        item.value.copyWith(
          status: status.value,
          downloaded: progress,
        ),
      );
      _repository.updateDownloadItemEntity(item.value);
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  final _mainScreenStateSubject = BehaviorSubject();
  final _mainScreenEvents = StreamController();

  Sink get eventSink => _mainScreenEvents.sink;

  Stream get mainScreenState => _mainScreenStateSubject.stream;

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
    print('download callback triggered');
  }

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
        print("Permission result   " + result.toString());
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
      try {
        await savedDir.create(recursive: true);
      } catch (e) {
        print("Error creating directory: " + e.toString());
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
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  void onItemPauseClicked(String taskId) {
    FlutterDownloader.pause(taskId: taskId);
  }

  void onItemResumeClicked(String taskId) async {
    var id = await FlutterDownloader.resume(taskId: taskId);
    var item = observableItemList
        .where((element) => element.value.taskId == id)
        .toList()[0];
    item.add(
      item.value.copyWith(
        taskId: id,
      ),
    );
    _repository.updateDownloadItemEntity(item.value);
  }
  void onItemRemoveClicked(String taskId) {
    FlutterDownloader.remove(taskId: taskId);
  }

  void onItemRetryClicked(String taskId)  async{
    var id = await FlutterDownloader.retry(taskId: taskId);
    var item = observableItemList
        .where((element) => element.value.taskId == id)
        .toList()[0];
    item.add(
      item.value.copyWith(
        taskId: id,
      ),
    );
    _repository.updateDownloadItemEntity(item.value);
  }
}
