import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:youtube_downloader/domain/entities/download_item.dart';

class DownloadItemListTile extends StatelessWidget {
  DownloadItemEntity downloadItem;
  void Function(int taskId) onPause;
  void Function(int taskId) onResume;
  void Function(int taskId) onRetry;

  DownloadItemListTile({
    Key? key,
    required this.downloadItem,
    required this.onPause,
    required this.onResume,
    required this.onRetry,
  }) : super(key: key);

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
            downloadItem.thumbnailLink,
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
                    downloadItem.title,
                    style: const TextStyle(fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    downloadItem.format.toUpperCase() +
                        " - " +
                        downloadItem.quality +
                        " - " +
                        Duration(seconds: downloadItem.duration)
                            .toString()
                            .replaceAll(RegExp(r'[.]\d+'), ""),
                    style: const TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(downloadItem.status == DownloadTaskStatus.failed.value
                          ? "Error!"
                          : _format((downloadItem.downloaded / downloadItem.size) * 100) + '%'),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: downloadItem.status ==
                                  DownloadTaskStatus.paused.value
                              ? const Icon(Icons.play_arrow)
                              : downloadItem.status ==
                                      DownloadTaskStatus.complete.value
                                  ? const Icon(Icons.check)
                                  : downloadItem.status ==
                                          DownloadTaskStatus.failed.value
                                      ? const Icon(Icons.restart_alt)
                                      : const Icon(Icons.pause),
                        ),
                        onTap: () {
                          if (downloadItem.status == null) return;
                          if (downloadItem.status ==
                              DownloadTaskStatus.running.value) {
                            onPause(downloadItem.taskId!);
                          } else if (downloadItem.status ==
                              DownloadTaskStatus.paused.value) {
                            onResume(downloadItem.taskId!);
                          } else if (downloadItem.status ==
                                  DownloadTaskStatus.canceled.value ||
                              downloadItem.status ==
                                  DownloadTaskStatus.failed.value) {
                            onRetry(downloadItem.taskId!);
                          }
                        },
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    minHeight: 3,
                    color: downloadItem.status == DownloadTaskStatus.complete.value
                        ? Colors.green
                        : Colors.blue,
                    value: (downloadItem.downloaded / downloadItem.size) ,
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

String _format(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
}