import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/domain/entities/download_item.dart';

class DownloadItemListTile extends StatefulWidget {
  BehaviorSubject<DownloadItemEntity> downloadItem;

  DownloadItemListTile({Key? key, required this.downloadItem})
      : super(key: key);

  @override
  State<DownloadItemListTile> createState() => _DownloadItemListTileState();
}

class _DownloadItemListTileState extends State<DownloadItemListTile> {
  late DownloadItemEntity item;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image.network(
            item.thumbnailLink,
            height: 96,
            width: 128,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    item.title,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
