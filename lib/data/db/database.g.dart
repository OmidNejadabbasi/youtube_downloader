// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class DownloadItem extends DataClass implements Insertable<DownloadItem> {
  final int id;
  final String link;
  final String title;
  final int size;
  final int downloaded;
  final String? format;
  final String? fps;
  final bool isAudio;
  final String? quality;
  final int? duration;
  final String? thumbnail_link;
  final String? task_id;
  final String? status;
  DownloadItem(
      {required this.id,
      required this.link,
      required this.title,
      required this.size,
      required this.downloaded,
      this.format,
      this.fps,
      required this.isAudio,
      this.quality,
      this.duration,
      this.thumbnail_link,
      this.task_id,
      this.status});
  factory DownloadItem.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DownloadItem(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      link: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}link'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      size: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}size'])!,
      downloaded: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}downloaded'])!,
      format: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}format']),
      fps: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}fps']),
      isAudio: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_audio'])!,
      quality: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}quality']),
      duration: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}duration']),
      thumbnail_link: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail_link']),
      task_id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}task_id']),
      status: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['link'] = Variable<String>(link);
    map['title'] = Variable<String>(title);
    map['size'] = Variable<int>(size);
    map['downloaded'] = Variable<int>(downloaded);
    if (!nullToAbsent || format != null) {
      map['format'] = Variable<String?>(format);
    }
    if (!nullToAbsent || fps != null) {
      map['fps'] = Variable<String?>(fps);
    }
    map['is_audio'] = Variable<bool>(isAudio);
    if (!nullToAbsent || quality != null) {
      map['quality'] = Variable<String?>(quality);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int?>(duration);
    }
    if (!nullToAbsent || thumbnail_link != null) {
      map['thumbnail_link'] = Variable<String?>(thumbnail_link);
    }
    if (!nullToAbsent || task_id != null) {
      map['task_id'] = Variable<String?>(task_id);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String?>(status);
    }
    return map;
  }

  DownloadItemsCompanion toCompanion(bool nullToAbsent) {
    return DownloadItemsCompanion(
      id: Value(id),
      link: Value(link),
      title: Value(title),
      size: Value(size),
      downloaded: Value(downloaded),
      format:
          format == null && nullToAbsent ? const Value.absent() : Value(format),
      fps: fps == null && nullToAbsent ? const Value.absent() : Value(fps),
      isAudio: Value(isAudio),
      quality: quality == null && nullToAbsent
          ? const Value.absent()
          : Value(quality),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      thumbnail_link: thumbnail_link == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnail_link),
      task_id: task_id == null && nullToAbsent
          ? const Value.absent()
          : Value(task_id),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
    );
  }

  factory DownloadItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DownloadItem(
      id: serializer.fromJson<int>(json['id']),
      link: serializer.fromJson<String>(json['link']),
      title: serializer.fromJson<String>(json['title']),
      size: serializer.fromJson<int>(json['size']),
      downloaded: serializer.fromJson<int>(json['downloaded']),
      format: serializer.fromJson<String?>(json['format']),
      fps: serializer.fromJson<String?>(json['fps']),
      isAudio: serializer.fromJson<bool>(json['isAudio']),
      quality: serializer.fromJson<String?>(json['quality']),
      duration: serializer.fromJson<int?>(json['duration']),
      thumbnail_link: serializer.fromJson<String?>(json['thumbnail_link']),
      task_id: serializer.fromJson<String?>(json['task_id']),
      status: serializer.fromJson<String?>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'link': serializer.toJson<String>(link),
      'title': serializer.toJson<String>(title),
      'size': serializer.toJson<int>(size),
      'downloaded': serializer.toJson<int>(downloaded),
      'format': serializer.toJson<String?>(format),
      'fps': serializer.toJson<String?>(fps),
      'isAudio': serializer.toJson<bool>(isAudio),
      'quality': serializer.toJson<String?>(quality),
      'duration': serializer.toJson<int?>(duration),
      'thumbnail_link': serializer.toJson<String?>(thumbnail_link),
      'task_id': serializer.toJson<String?>(task_id),
      'status': serializer.toJson<String?>(status),
    };
  }

  DownloadItem copyWith(
          {int? id,
          String? link,
          String? title,
          int? size,
          int? downloaded,
          String? format,
          String? fps,
          bool? isAudio,
          String? quality,
          int? duration,
          String? thumbnail_link,
          String? task_id,
          String? status}) =>
      DownloadItem(
        id: id ?? this.id,
        link: link ?? this.link,
        title: title ?? this.title,
        size: size ?? this.size,
        downloaded: downloaded ?? this.downloaded,
        format: format ?? this.format,
        fps: fps ?? this.fps,
        isAudio: isAudio ?? this.isAudio,
        quality: quality ?? this.quality,
        duration: duration ?? this.duration,
        thumbnail_link: thumbnail_link ?? this.thumbnail_link,
        task_id: task_id ?? this.task_id,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('DownloadItem(')
          ..write('id: $id, ')
          ..write('link: $link, ')
          ..write('title: $title, ')
          ..write('size: $size, ')
          ..write('downloaded: $downloaded, ')
          ..write('format: $format, ')
          ..write('fps: $fps, ')
          ..write('isAudio: $isAudio, ')
          ..write('quality: $quality, ')
          ..write('duration: $duration, ')
          ..write('thumbnail_link: $thumbnail_link, ')
          ..write('task_id: $task_id, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, link, title, size, downloaded, format,
      fps, isAudio, quality, duration, thumbnail_link, task_id, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadItem &&
          other.id == this.id &&
          other.link == this.link &&
          other.title == this.title &&
          other.size == this.size &&
          other.downloaded == this.downloaded &&
          other.format == this.format &&
          other.fps == this.fps &&
          other.isAudio == this.isAudio &&
          other.quality == this.quality &&
          other.duration == this.duration &&
          other.thumbnail_link == this.thumbnail_link &&
          other.task_id == this.task_id &&
          other.status == this.status);
}

class DownloadItemsCompanion extends UpdateCompanion<DownloadItem> {
  final Value<int> id;
  final Value<String> link;
  final Value<String> title;
  final Value<int> size;
  final Value<int> downloaded;
  final Value<String?> format;
  final Value<String?> fps;
  final Value<bool> isAudio;
  final Value<String?> quality;
  final Value<int?> duration;
  final Value<String?> thumbnail_link;
  final Value<String?> task_id;
  final Value<String?> status;
  const DownloadItemsCompanion({
    this.id = const Value.absent(),
    this.link = const Value.absent(),
    this.title = const Value.absent(),
    this.size = const Value.absent(),
    this.downloaded = const Value.absent(),
    this.format = const Value.absent(),
    this.fps = const Value.absent(),
    this.isAudio = const Value.absent(),
    this.quality = const Value.absent(),
    this.duration = const Value.absent(),
    this.thumbnail_link = const Value.absent(),
    this.task_id = const Value.absent(),
    this.status = const Value.absent(),
  });
  DownloadItemsCompanion.insert({
    this.id = const Value.absent(),
    required String link,
    required String title,
    this.size = const Value.absent(),
    this.downloaded = const Value.absent(),
    this.format = const Value.absent(),
    this.fps = const Value.absent(),
    required bool isAudio,
    this.quality = const Value.absent(),
    this.duration = const Value.absent(),
    this.thumbnail_link = const Value.absent(),
    this.task_id = const Value.absent(),
    this.status = const Value.absent(),
  })  : link = Value(link),
        title = Value(title),
        isAudio = Value(isAudio);
  static Insertable<DownloadItem> custom({
    Expression<int>? id,
    Expression<String>? link,
    Expression<String>? title,
    Expression<int>? size,
    Expression<int>? downloaded,
    Expression<String?>? format,
    Expression<String?>? fps,
    Expression<bool>? isAudio,
    Expression<String?>? quality,
    Expression<int?>? duration,
    Expression<String?>? thumbnail_link,
    Expression<String?>? task_id,
    Expression<String?>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (link != null) 'link': link,
      if (title != null) 'title': title,
      if (size != null) 'size': size,
      if (downloaded != null) 'downloaded': downloaded,
      if (format != null) 'format': format,
      if (fps != null) 'fps': fps,
      if (isAudio != null) 'is_audio': isAudio,
      if (quality != null) 'quality': quality,
      if (duration != null) 'duration': duration,
      if (thumbnail_link != null) 'thumbnail_link': thumbnail_link,
      if (task_id != null) 'task_id': task_id,
      if (status != null) 'status': status,
    });
  }

  DownloadItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? link,
      Value<String>? title,
      Value<int>? size,
      Value<int>? downloaded,
      Value<String?>? format,
      Value<String?>? fps,
      Value<bool>? isAudio,
      Value<String?>? quality,
      Value<int?>? duration,
      Value<String?>? thumbnail_link,
      Value<String?>? task_id,
      Value<String?>? status}) {
    return DownloadItemsCompanion(
      id: id ?? this.id,
      link: link ?? this.link,
      title: title ?? this.title,
      size: size ?? this.size,
      downloaded: downloaded ?? this.downloaded,
      format: format ?? this.format,
      fps: fps ?? this.fps,
      isAudio: isAudio ?? this.isAudio,
      quality: quality ?? this.quality,
      duration: duration ?? this.duration,
      thumbnail_link: thumbnail_link ?? this.thumbnail_link,
      task_id: task_id ?? this.task_id,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (downloaded.present) {
      map['downloaded'] = Variable<int>(downloaded.value);
    }
    if (format.present) {
      map['format'] = Variable<String?>(format.value);
    }
    if (fps.present) {
      map['fps'] = Variable<String?>(fps.value);
    }
    if (isAudio.present) {
      map['is_audio'] = Variable<bool>(isAudio.value);
    }
    if (quality.present) {
      map['quality'] = Variable<String?>(quality.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int?>(duration.value);
    }
    if (thumbnail_link.present) {
      map['thumbnail_link'] = Variable<String?>(thumbnail_link.value);
    }
    if (task_id.present) {
      map['task_id'] = Variable<String?>(task_id.value);
    }
    if (status.present) {
      map['status'] = Variable<String?>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadItemsCompanion(')
          ..write('id: $id, ')
          ..write('link: $link, ')
          ..write('title: $title, ')
          ..write('size: $size, ')
          ..write('downloaded: $downloaded, ')
          ..write('format: $format, ')
          ..write('fps: $fps, ')
          ..write('isAudio: $isAudio, ')
          ..write('quality: $quality, ')
          ..write('duration: $duration, ')
          ..write('thumbnail_link: $thumbnail_link, ')
          ..write('task_id: $task_id, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $DownloadItemsTable extends DownloadItems
    with TableInfo<$DownloadItemsTable, DownloadItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DownloadItemsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String?> link = GeneratedColumn<String?>(
      'link', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int?> size = GeneratedColumn<int?>(
      'size', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _downloadedMeta = const VerificationMeta('downloaded');
  @override
  late final GeneratedColumn<int?> downloaded = GeneratedColumn<int?>(
      'downloaded', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String?> format = GeneratedColumn<String?>(
      'format', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _fpsMeta = const VerificationMeta('fps');
  @override
  late final GeneratedColumn<String?> fps = GeneratedColumn<String?>(
      'fps', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _isAudioMeta = const VerificationMeta('isAudio');
  @override
  late final GeneratedColumn<bool?> isAudio = GeneratedColumn<bool?>(
      'is_audio', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_audio IN (0, 1))');
  final VerificationMeta _qualityMeta = const VerificationMeta('quality');
  @override
  late final GeneratedColumn<String?> quality = GeneratedColumn<String?>(
      'quality', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _durationMeta = const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int?> duration = GeneratedColumn<int?>(
      'duration', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _thumbnail_linkMeta =
      const VerificationMeta('thumbnail_link');
  @override
  late final GeneratedColumn<String?> thumbnail_link = GeneratedColumn<String?>(
      'thumbnail_link', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _task_idMeta = const VerificationMeta('task_id');
  @override
  late final GeneratedColumn<String?> task_id = GeneratedColumn<String?>(
      'task_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String?> status = GeneratedColumn<String?>(
      'status', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        link,
        title,
        size,
        downloaded,
        format,
        fps,
        isAudio,
        quality,
        duration,
        thumbnail_link,
        task_id,
        status
      ];
  @override
  String get aliasedName => _alias ?? 'download_items';
  @override
  String get actualTableName => 'download_items';
  @override
  VerificationContext validateIntegrity(Insertable<DownloadItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    }
    if (data.containsKey('downloaded')) {
      context.handle(
          _downloadedMeta,
          downloaded.isAcceptableOrUnknown(
              data['downloaded']!, _downloadedMeta));
    }
    if (data.containsKey('format')) {
      context.handle(_formatMeta,
          format.isAcceptableOrUnknown(data['format']!, _formatMeta));
    }
    if (data.containsKey('fps')) {
      context.handle(
          _fpsMeta, fps.isAcceptableOrUnknown(data['fps']!, _fpsMeta));
    }
    if (data.containsKey('is_audio')) {
      context.handle(_isAudioMeta,
          isAudio.isAcceptableOrUnknown(data['is_audio']!, _isAudioMeta));
    } else if (isInserting) {
      context.missing(_isAudioMeta);
    }
    if (data.containsKey('quality')) {
      context.handle(_qualityMeta,
          quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta));
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    }
    if (data.containsKey('thumbnail_link')) {
      context.handle(
          _thumbnail_linkMeta,
          thumbnail_link.isAcceptableOrUnknown(
              data['thumbnail_link']!, _thumbnail_linkMeta));
    }
    if (data.containsKey('task_id')) {
      context.handle(_task_idMeta,
          task_id.isAcceptableOrUnknown(data['task_id']!, _task_idMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DownloadItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DownloadItem.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DownloadItemsTable createAlias(String alias) {
    return $DownloadItemsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $DownloadItemsTable downloadItems = $DownloadItemsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [downloadItems];
}
