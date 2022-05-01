import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/domain/entities/download_item.dart';

class DownloadItemListTile extends StatefulWidget {
  BehaviorSubject<DownloadItemEntity> downloadItem;
  void Function(String taskId) onPause;
  void Function(String taskId) onResume;
  void Function(String taskId) onRetry;

  DownloadItemListTile({
    Key? key,
    required this.downloadItem,
    required this.onPause,
    required this.onResume,
    required this.onRetry,
  }) : super(key: key);

  @override
  State<DownloadItemListTile> createState() => _DownloadItemListTileState();
}

class _DownloadItemListTileState extends State<DownloadItemListTile> {
  DownloadItemEntity? item;

  @override
  void initState() {
    super.initState();
    widget.downloadItem.listen((value) {
      setState(() {
        item = value;
        print('item ${item?.taskId} updated status ${item?.status}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Image.network(
            item?.thumbnailLink ?? 'https://via.placeholder.com/150',
            height: 96,
            width: 128,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/placeholder.jpeg',
                height: 96,
                width: 128,
                fit: BoxFit.cover,
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item?.title ?? '(...)',
                    style: const TextStyle(fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item?.quality ?? '(...)',
                    style: const TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: item?.status ==
                                  DownloadTaskStatus.paused.toString()
                              ? const Icon(Icons.play_arrow)
                              : const Icon(Icons.pause),
                        ),
                        onTap: () {
                          if (item?.status == null) return;
                          if (item?.status ==
                              DownloadTaskStatus.paused.toString()) {
                            widget.onPause(item!.taskId!);
                          } else if (item?.status ==
                              DownloadTaskStatus.running.toString()) {
                            widget.onResume(item!.taskId!);
                          } else if (item?.status ==
                              DownloadTaskStatus.canceled.toString()) {
                            widget.onRetry(item!.taskId!);
                          }
                        },
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    minHeight: 3,
                    value: (item?.downloaded ?? 0) / 100,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
