import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:youtube_downloader/dependency_container.dart';
import 'package:youtube_downloader/domain/entities/download_item.dart';
import 'package:youtube_downloader/pages/main/link_extractor_dialog/link_extractor_dialog.dart';
import 'package:youtube_downloader/pages/main/main_screeen_events.dart';
import 'package:youtube_downloader/pages/main/main_screen_bloc.dart';
import 'package:youtube_downloader/shared/widgets/download_item_list_tile.dart';

import '../../shared/styles.dart';
import '../../shared/widgets/icon_button.dart';
import 'main_screen_states.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainScreenBloc _bloc;
  ReceivePort _port = ReceivePort();
  bool isStoragePermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _bloc = sl<MainScreenBloc>();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    _bloc.mainScreenState.listen((event) {
      if (event.runtimeType == PermissionNotGrantedState) {
        setState(() {
          isStoragePermissionGranted = false;
        });
      } else {
        setState(() {
          isStoragePermissionGranted = false;
        });
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
    _bloc.eventSink.add(CheckStoragePermission());
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 3),
          ]),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NIconButton(
                    icon: Icons.menu,
                    onPressed: () {},
                  ),
                  const Expanded(
                    child: Text(
                      'Youtube Downloader',
                      textAlign: TextAlign.center,
                      style: Styles.appTitleStyle,
                    ),
                  ),
                  NIconButton(
                    icon: Icons.search,
                    onPressed: () {},
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _bloc.mainScreenState,
                  builder: (context, snapshot) {
                    if (snapshot.data is MainScreenState &&
                        (snapshot.data as MainScreenState)
                            .observableItemList
                            .isNotEmpty) {
                      print('some state');
                      return _buildMainList(
                          context, snapshot.data! as MainScreenState);
                    } else if (snapshot.data is PermissionNotGrantedState) {
                      return _buildPermissionNotGrantedView(
                          context, snapshot.data! as PermissionNotGrantedState);
                    }
                    print('no state yet');
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/idea.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'No items to show!\nPress the add button to download new items',
                          style: Styles.labelTextStyle.copyWith(
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Styles.colorPrimary,
        onPressed: () async {
          DownloadItemEntity entity = await showDialog(
              context: context,
              builder: (context) {
                return const YoutubeLinkExtractorDialog();
              });
          if (entity != null) {
            _bloc.eventSink.add(AddDownloadItemEvent(entity));
          }
        },
      ),
    );
  }

  Widget _buildMainList(BuildContext context, MainScreenState state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.observableItemList.length,
        itemBuilder: (context, index) {
          return DownloadItemListTile(
              downloadItem: state.observableItemList[index]);
        },
      ),
    );
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    _bloc.dispose();
    super.dispose();
  }

  Widget _buildPermissionNotGrantedView(BuildContext context,
      PermissionNotGrantedState permissionNotGrantedState) {
    return Container(
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Permission not granted'),
          SizedBox(height: 10),
          ElevatedButton(
            child: Text('Retry'),
            onPressed: () async {
              _bloc.eventSink.add(CheckStoragePermission());
            },
          ),
        ],
      )),
    );
  }
}
