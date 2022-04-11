

class DownloadItemEntity {

  final String link;
  final String title;
  int size;
  final String format;
  final String fps;
  final bool isAudio;
  final String quality;
  final int duration;
  final String thumbnailLink;

  DownloadItemEntity({
    required this.link,
    required this.title,
    this.size = -1,
    required this.format,
    required this.fps,
    required this.isAudio,
    required this.quality,
    required this.duration,
    required this.thumbnailLink,
  });
}