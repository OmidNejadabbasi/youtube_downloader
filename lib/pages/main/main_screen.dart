import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:fetchme/fetchme.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
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
  bool _isCompletedTabSelected = true;
  Set<int> selectedIDs = {};
  bool isInSelectMode = false;
  int completedCount = 0;
  int queueCount = 0;

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
                    BoxShadow(
                        color: Colors.black12, spreadRadius: -2, blurRadius: 5),
                  ],
                ),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: animation.drive(Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      )),
                      child: child,
                    );
                  },
                  child: !isInSelectMode
                      ? Row(
                          key: const ValueKey(1),
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
                        )
                      : Row(
                          key: const ValueKey(2),
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: NIconButton(
                                  icon: Icons.arrow_back,
                                  onPressed: () {
                                    setState(() {
                                      selectedIDs.clear();
                                      isInSelectMode = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                            NIconButton(
                              icon: Icons.delete,
                              onPressed: () {},
                            ),
                            NIconButton(
                              icon: Icons.select_all,
                              onPressed: () {},
                            ),
                          ],
                        ),
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
                                ? element.value.status ==
                                    DownloadTaskStatus.complete.value
                                : element.value.status !=
                                    DownloadTaskStatus.complete.value)
                            .toList();
                        completedCount = _isCompletedTabSelected
                            ? itemList.length
                            : -itemList.length +
                                state.observableItemList.length;

                        queueCount =
                            state.observableItemList.length - completedCount;
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
      bottomNavigationBar: AnimatedSwitcher(
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: animation.drive(Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            )),
            child: child,
          );
        },
        duration: const Duration(milliseconds: 250),
        child: isInSelectMode
            ? const SizedBox()
            : BottomNavigationBar(
                onTap: (value) {
                  setState(() {
                    _isCompletedTabSelected = value == 1;
                  });
                },
                currentIndex: _isCompletedTabSelected ? 1 : 0,
                items: [
                  BottomNavigationBarItem(
                    icon: Badge(
                      child: const Icon(Icons.stop_circle_outlined),
                      badgeContent: Text(queueCount.toString(),
                          style: Styles.labelTextStyle),
                      badgeColor: Colors.yellow.shade400,
                    ),
                    label: "Queue",
                  ),
                  BottomNavigationBarItem(
                    icon: Badge(
                      child: const Icon(Icons.done),
                      badgeContent: Text(completedCount.toString(),
                          style: Styles.labelTextStyle),
                      badgeColor: Colors.greenAccent.shade200,
                    ),
                    label: "Completed",
                  ),
                ],
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

  Widget _buildMainList(BuildContext context,
      List<BehaviorSubject<DownloadItemEntity>> itemList) {
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return StreamBuilder(
            key: ValueKey(itemList[index].value.id!),
            stream: itemList[index],
            builder: (context, AsyncSnapshot<DownloadItemEntity> snapshot) {
              if (snapshot.data == null) {
                return SizedBox();
              }
              print("build of item");
              var isSelected = selectedIDs.contains(snapshot.data!.id);
              return GestureDetector(
                onTap: () {
                  if (isInSelectMode) {
                    if (isSelected) {
                      selectedIDs.remove(snapshot.data!.id!);
                    } else {
                      selectedIDs.add(snapshot.data!.id!);
                    }
                    setState(() {
                      if (selectedIDs.isEmpty) {
                        isInSelectMode = false;
                      }
                    });
                    return;
                  }
                  if (snapshot.data!.status ==
                      DownloadTaskStatus.complete.value) {
                    _bloc.onItemOpenClicked(snapshot.data!.taskId!);
                  }
                },
                onLongPress: () {
                  if (isInSelectMode) {
                    return;
                  }
                  selectedIDs.add(snapshot.data!.id!);
                  setState(() {
                    isInSelectMode = true;
                  });
                },
                child: DownloadItemListTile(
                  downloadItem: snapshot.data!,
                  onPause: _bloc.onItemPauseClicked,
                  onResume: _bloc.onItemResumeClicked,
                  onRetry: _bloc.onItemRetryClicked,
                  isSelected: isSelected,
                ),
              );
            });
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
