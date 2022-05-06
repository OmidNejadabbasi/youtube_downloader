import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/domain/entities/download_item.dart';

class DownloadItemListTile extends StatefulWidget {
  DownloadItemEntity downloadItem;
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

  @override
  void initState() {
    super.initState();
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
            widget.downloadItem.thumbnailLink ?? 'https://via.placeholder.com/150',
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
                    widget.downloadItem.title ?? '(...)',
                    style: const TextStyle(fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.downloadItem.quality ?? '(...)',
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
                          child: widget.downloadItem.status ==
                                  DownloadTaskStatus.paused.value
                              ? const Icon(Icons.play_arrow)
                              : widget.downloadItem.status ==
                                      DownloadTaskStatus.complete.value
                                  ? const Icon(Icons.check)
                                  : widget.downloadItem.status ==
                                          DownloadTaskStatus.failed.value
                                      ? const Icon(Icons.restart_alt)
                                      : const Icon(Icons.pause),
                        ),
                        onTap: () {
                          if (widget.downloadItem.status == null) return;
                          if (widget.downloadItem.status ==
                              DownloadTaskStatus.running.value) {
                            widget.onPause(widget.downloadItem.taskId!);
                          } else if (widget.downloadItem.status ==
                              DownloadTaskStatus.paused.value) {
                            widget.onResume(widget.downloadItem.taskId!);
                          } else if (widget.downloadItem.status ==
                              DownloadTaskStatus.canceled.value || widget.downloadItem.status ==
                              DownloadTaskStatus.failed.value) {
                            widget.onRetry(widget.downloadItem.taskId!);
                          }
                        },
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    minHeight: 3,
                    value: (widget.downloadItem.downloaded ?? 0) / 100,
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
