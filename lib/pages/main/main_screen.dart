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
  bool isStoragePermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _bloc = sl<MainScreenBloc>();

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

    _bloc.eventSink.add(CheckStoragePermission());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 3),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 3),
                  ],
                ),
                child: Row(
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
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  color: Colors.white38,
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
                        return _buildPermissionNotGrantedView(context,
                            snapshot.data! as PermissionNotGrantedState);
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Styles.colorPrimary,
        onPressed: () async {
          var entity = await showDialog(
              context: context,
              builder: (context) {
                return const YoutubeLinkExtractorDialog();
              });
          if (entity.runtimeType != Null) {
            _bloc.eventSink
                .add(AddDownloadItemEvent(entity as DownloadItemEntity));
          }
        },
      ),
    );
  }

  Widget _buildMainList(BuildContext context, MainScreenState state) {
    return ListView.builder(
      itemCount: state.observableItemList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (state.observableItemList[index].status ==
                DownloadTaskStatus.complete.value) {
              _bloc.onItemOpenClicked(state.observableItemList[index].taskId!);
            }
          },
          child: DownloadItemListTile(
            downloadItem: state.observableItemList[index],
            onPause: _bloc.onItemPauseClicked,
            onResume: _bloc.onItemResumeClicked,
            onRetry: _bloc.onItemRetryClicked,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Widget _buildPermissionNotGrantedView(BuildContext context,
      PermissionNotGrantedState permissionNotGrantedState) {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Permission not granted'),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('Retry'),
            onPressed: () async {
              _bloc.eventSink.add(CheckStoragePermission());
            },
          ),
        ],
      )),
    );
  }
}
