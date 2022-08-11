class AppSettings{
  String folderForFiles;
  int simultaneousDownloads;
  bool onlyWiFi;
  bool sendNotificationOnlyWhenFinished;

//<editor-fold desc="Data Methods">

  AppSettings({
    required this.folderForFiles,
    required this.simultaneousDownloads,
    required this.onlyWiFi,
    required this.sendNotificationOnlyWhenFinished,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettings &&
          runtimeType == other.runtimeType &&
          folderForFiles == other.folderForFiles &&
          simultaneousDownloads == other.simultaneousDownloads &&
          onlyWiFi == other.onlyWiFi &&
          sendNotificationOnlyWhenFinished ==
              other.sendNotificationOnlyWhenFinished);

  @override
  int get hashCode =>
      folderForFiles.hashCode ^
      simultaneousDownloads.hashCode ^
      onlyWiFi.hashCode ^
      sendNotificationOnlyWhenFinished.hashCode;

  @override
  String toString() {
    return 'AppSettings{' +
        ' folderForFiles: $folderForFiles,' +
        ' simultaneousDownloads: $simultaneousDownloads,' +
        ' onlyWiFi: $onlyWiFi,' +
        ' sendNotificationOnlyWhenFinished: $sendNotificationOnlyWhenFinished,' +
        '}';
  }

  AppSettings copyWith({
    String? folderForFiles,
    int? simultaneousDownloads,
    bool? onlyWiFi,
    bool? sendNotificationOnlyWhenFinished,
  }) {
    return AppSettings(
      folderForFiles: folderForFiles ?? this.folderForFiles,
      simultaneousDownloads:
          simultaneousDownloads ?? this.simultaneousDownloads,
      onlyWiFi: onlyWiFi ?? this.onlyWiFi,
      sendNotificationOnlyWhenFinished: sendNotificationOnlyWhenFinished ??
          this.sendNotificationOnlyWhenFinished,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'folderForFiles': this.folderForFiles,
      'simultaneousDownloads': this.simultaneousDownloads,
      'onlyWiFi': this.onlyWiFi,
      'sendNotificationOnlyWhenFinished': this.sendNotificationOnlyWhenFinished,
    };
  }

  factory AppSettings.fromMap(Map<String, dynamic> map) {
    return AppSettings(
      folderForFiles: map['folderForFiles'] as String,
      simultaneousDownloads: map['simultaneousDownloads'] as int,
      onlyWiFi: map['onlyWiFi'] as bool,
      sendNotificationOnlyWhenFinished:
          map['sendNotificationOnlyWhenFinished'] as bool,
    );
  }

//</editor-fold>
}