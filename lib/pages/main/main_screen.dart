import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:youtube_downloader/dependency_container.dart';
import 'package:youtube_downloader/domain/entities/download_item.dart';
import 'package:youtube_downloader/pages/main/link_extractor_dialog/link_extractor_dialog.dart';
import 'package:youtube_downloader/pages/main/link_extractor_dialog/link_extractor_dialog_events.dart';
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
  bool _isCompletedTabSelected = true;

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
                    BoxShadow(color: Colors.black12, spreadRadius: -2, blurRadius: 5),
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
              const SizedBox(height: 0),
              Expanded(
                child: Container(
                  color: Colors.white70,
                  child: StreamBuilder(
                    stream: _bloc.mainScreenState,
                    builder: (context, snapshot) {
                      var state = snapshot.data;

                      if ((snapshot.data is MainScreenState)) {
                        var itemList = (state as MainScreenState)
                            .observableItemList
                            .where((element) => _isCompletedTabSelected
                                ? element.status ==
                                    DownloadTaskStatus.complete.value
                                : element.status !=
                                    DownloadTaskStatus.complete.value)
                            .toList();
                        if (itemList.isNotEmpty) {
                          return _buildMainList(context, itemList);
                        } else {
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
                        }
                      } else if (state is PermissionNotGrantedState) {
                        return _buildPermissionNotGrantedView(context, state);
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _isCompletedTabSelected = value == 1;
          });
        },
        currentIndex: _isCompletedTabSelected ? 1 : 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.stop_circle_outlined),
            label: "Queue",
          ),
          BottomNavigationBarItem(
            label: "Completed",
            icon: Icon(Icons.done_all),
          ),
        ],
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

  Widget _buildMainList(
      BuildContext context, List<DownloadItemEntity> itemList) {
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (itemList[index].status == DownloadTaskStatus.complete.value) {
              _bloc.onItemOpenClicked(itemList[index].taskId!);
            }
          },
          child: DownloadItemListTile(
            downloadItem: itemList[index],
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
