import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:device_info/device_info.dart';
import 'package:fetchme/fetchme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/domain/entities/download_item.dart';
import 'package:youtube_downloader/domain/repository/download_item_repository.dart';
import 'package:youtube_downloader/pages/main/delete_items_dialog/delete_mode.dart';
import 'package:youtube_downloader/pages/main/main_screen_events.dart';

import 'main_screen_states.dart';

class MainScreenBloc {
  late DownloadItemRepository _repository;
  List<BehaviorSubject<DownloadItemEntity>> observableItemList = [];

  List<DownloadItemEntity> get itemList =>
      observableItemList.map((e) => e.value).toList();
  BehaviorSubject<int> completedCount = BehaviorSubject.seeded(0);
  BehaviorSubject<int> queueCount = BehaviorSubject.seeded(0);

  bool _permissionReady = false;
  late String _localPath;

  MainScreenBloc(DownloadItemRepository repository) {
    _repository = repository;
    _repository.getAllItems().then((value) {
      observableItemList = value.map((e) => BehaviorSubject.seeded(e)).toList();
      refreshList();
    });
    // _repository.getAllItemsStream().listen((event) {
    //   for(var item in event){
    //
    //   }
    //   observableItemList = event.map((e) => BehaviorSubject.seeded(e)).toList();
    // });

    _mainScreenEvents.stream.listen((event) async {
      if (event.runtimeType == CheckStoragePermission) {
        await _prepare();
      } else if (event.runtimeType == AddDownloadItemEvent) {
        final evt = event as AddDownloadItemEvent;
        //
        String fileName =
            evt.entity.title.replaceAll(RegExp(r'[/|<>*\?":]'), "-") +
                "-" +
                evt.entity.fps +
                '.mp4';
        int counter = 1;
        while (File(_localPath + "/" + fileName).existsSync()) {
          fileName = evt.entity.title + "-" + evt.entity.fps + '($counter).mp4';
        }
        // var taskId = await FlutterDownloader.enqueue(
        //   url: evt.entity.link,
        //   savedDir: _localPath,
        //   fileName: fileName,
        //   saveInPublicStorage: true,
        // );
        // await _repository
        //     .insertDownloadItemEntity(evt.entity.copyWith(taskId: taskId));

        int newTaskId =
            await Fetchme.enqueue(evt.entity.link, _localPath, fileName);

        var itemEntity = evt.entity.copyWith(taskId: newTaskId);
        var newId = await _repository.insertDownloadItemEntity(itemEntity);
        itemEntity = itemEntity.copyWith(id: newId);
        observableItemList.add(BehaviorSubject.seeded(itemEntity));
        refreshList();
      } else if (event.runtimeType == DeleteDownloadsEvent) {
        final evt = event as DeleteDownloadsEvent;
        if (evt.deleteMode == DeleteMode.delete) {
          evt.idsToBeDeleted.forEach((element) {
            Fetchme.delete(id: element);
          });
          deleteItems(evt);
        } else if (evt.deleteMode == DeleteMode.remove) {
          evt.idsToBeDeleted.forEach((element) {
            Fetchme.remove(id: element);
          });
          deleteItems(evt);
        }
      }
    });

    //   IsolateNameServer.registerPortWithName(
    //       _port.sendPort, 'downloader_send_port');
    //   _port.listen((dynamic data) {
    //     String id = data[0];
    //     DownloadTaskStatus status = data[1];
    //     int progress = data[2];
    //     var indexOf =
    //         observableItemList.indexWhere((element) => element.taskId == id);
    //     if (indexOf < 0) return;
    //     observableItemList[indexOf] = observableItemList[indexOf]
    //         .copyWith(taskId: id, status: status.value, downloaded: progress);
    //     _mainScreenStateSubject.add(
    //       MainScreenState(
    //         observableItemList: observableItemList,
    //       ),
    //     );
    //     _repository.updateDownloadItemEntity(observableItemList[indexOf]);
    //   });
    //
    //   FlutterDownloader.registerCallback(downloadCallback);

    Fetchme.getUpdateStream().listen((updatedItem) {
      int index = observableItemList
          .map((e) => e.value)
          .toList()
          .indexWhere((element) => element.taskId == updatedItem.id);
      if (updatedItem.status.value > 6) return;
      if (index > 0) {
        print("item status " + updatedItem.downloaded.toString());
        observableItemList[index].add(observableItemList[index].value.copyWith(
            downloaded: updatedItem.downloaded,
            status: updatedItem.status.value,
            size: updatedItem.total));
        _repository.updateDownloadItemEntity(observableItemList[index].value);
        // _mainScreenStateSubject.add(
        //   MainScreenState(
        //     observableItemList: observableItemList,
        //   ),
        // );
      }
    });
  }

  void deleteItems(DeleteDownloadsEvent evt) {
    _repository.deleteItems(evt.idsToBeDeleted);
    observableItemList.removeWhere((element) => evt.idsToBeDeleted.contains(element.value.id));
    refreshList();
  }

  void refreshList() {
    _mainScreenStateSubject.add(
      MainScreenState(
        observableItemList: observableItemList,
      ),
    );
  }

  final _mainScreenStateSubject = BehaviorSubject();
  final _mainScreenEvents = StreamController();

  Sink get eventSink => _mainScreenEvents.sink;

  Stream get mainScreenState => _mainScreenStateSubject.stream;

// @pragma('vm:entry-point')
// static void downloadCallback(
//     String id, DownloadTaskStatus status, int progress) {
//   final SendPort send =
//       IsolateNameServer.lookupPortByName('downloader_send_port')!;
//   send.send([id, status, progress]);
//   print('download callback triggered');
// }

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
    if (Platform.isAndroid && androidInfo.version.sdkInt <= 33) {
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

  void onItemPauseClicked(int taskId) {
    Fetchme.pause(id: taskId);
  }

  void onItemResumeClicked(int taskId) async {
    await Fetchme.resume(id: taskId);
    // var indexOf =
    //     observableItemList.indexWhere((element) => element.taskId == taskId);
    // if (indexOf < 0) return;
    // observableItemList[indexOf] =
    //     observableItemList[indexOf].copyWith(taskId: id);
    // _repository.updateDownloadItemEntity(observableItemList[indexOf]);
    // var item =
    //     observableItemList.where((element) => element.taskId == id).toList()[0];
    // _repository.updateDownloadItemEntity(item);
  }

  void onItemRemoveClicked(int taskId) async {
    await Fetchme.delete(id: taskId);
  }

  void onItemOpenClicked(int taskId) async {
    // print(await Fetchme.open(taskId: taskId));
  }

  void onItemRetryClicked(int taskId) async {
    await Fetchme.retry(id: taskId);
  }
}
