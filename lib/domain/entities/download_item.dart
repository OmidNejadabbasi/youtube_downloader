

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
  final String taskId;
  final String status;

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
    required this.taskId,
    required this.status,
  });

  DownloadItemEntity copyWith({
    String? link,
    String? title,
    int? size,
    String? format,
    String? fps,
    bool? isAudio,
    String? quality,
    int? duration,
    String? thumbnailLink,
    String? taskId,
    String? status,
  }) {
    return DownloadItemEntity(
      link: link ?? this.link,
      title: title ?? this.title,
      size: size ?? this.size,
      format: format ?? this.format,
      fps: fps ?? this.fps,
      isAudio: isAudio ?? this.isAudio,
      quality: quality ?? this.quality,
      duration: duration ?? this.duration,
      thumbnailLink: thumbnailLink ?? this.thumbnailLink,
      taskId: taskId ?? this.taskId,
      status: status ?? this.status,
    );
  }
}