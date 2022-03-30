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
  final String? format;
  final String? fps;
  final bool isAudio;
  final String? thumbnailLink;
  DownloadItem(
      {required this.id,
      required this.link,
      required this.title,
      required this.size,
      this.format,
      this.fps,
      required this.isAudio,
      this.thumbnailLink});
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
      format: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}format']),
      fps: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}fps']),
      isAudio: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_audio'])!,
      thumbnailLink: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail_link']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['link'] = Variable<String>(link);
    map['title'] = Variable<String>(title);
    map['size'] = Variable<int>(size);
    if (!nullToAbsent || format != null) {
      map['format'] = Variable<String?>(format);
    }
    if (!nullToAbsent || fps != null) {
      map['fps'] = Variable<String?>(fps);
    }
    map['is_audio'] = Variable<bool>(isAudio);
    if (!nullToAbsent || thumbnailLink != null) {
      map['thumbnail_link'] = Variable<String?>(thumbnailLink);
    }
    return map;
  }

  DownloadItemsCompanion toCompanion(bool nullToAbsent) {
    return DownloadItemsCompanion(
      id: Value(id),
      link: Value(link),
      title: Value(title),
      size: Value(size),
      format:
          format == null && nullToAbsent ? const Value.absent() : Value(format),
      fps: fps == null && nullToAbsent ? const Value.absent() : Value(fps),
      isAudio: Value(isAudio),
      thumbnailLink: thumbnailLink == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailLink),
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
      format: serializer.fromJson<String?>(json['format']),
      fps: serializer.fromJson<String?>(json['fps']),
      isAudio: serializer.fromJson<bool>(json['isAudio']),
      thumbnailLink: serializer.fromJson<String?>(json['thumbnailLink']),
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
      'format': serializer.toJson<String?>(format),
      'fps': serializer.toJson<String?>(fps),
      'isAudio': serializer.toJson<bool>(isAudio),
      'thumbnailLink': serializer.toJson<String?>(thumbnailLink),
    };
  }

  DownloadItem copyWith(
          {int? id,
          String? link,
          String? title,
          int? size,
          String? format,
          String? fps,
          bool? isAudio,
          String? thumbnailLink}) =>
      DownloadItem(
        id: id ?? this.id,
        link: link ?? this.link,
        title: title ?? this.title,
        size: size ?? this.size,
        format: format ?? this.format,
        fps: fps ?? this.fps,
        isAudio: isAudio ?? this.isAudio,
        thumbnailLink: thumbnailLink ?? this.thumbnailLink,
      );
  @override
  String toString() {
    return (StringBuffer('DownloadItem(')
          ..write('id: $id, ')
          ..write('link: $link, ')
          ..write('title: $title, ')
          ..write('size: $size, ')
          ..write('format: $format, ')
          ..write('fps: $fps, ')
          ..write('isAudio: $isAudio, ')
          ..write('thumbnailLink: $thumbnailLink')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, link, title, size, format, fps, isAudio, thumbnailLink);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadItem &&
          other.id == this.id &&
          other.link == this.link &&
          other.title == this.title &&
          other.size == this.size &&
          other.format == this.format &&
          other.fps == this.fps &&
          other.isAudio == this.isAudio &&
          other.thumbnailLink == this.thumbnailLink);
}

class DownloadItemsCompanion extends UpdateCompanion<DownloadItem> {
  final Value<int> id;
  final Value<String> link;
  final Value<String> title;
  final Value<int> size;
  final Value<String?> format;
  final Value<String?> fps;
  final Value<bool> isAudio;
  final Value<String?> thumbnailLink;
  const DownloadItemsCompanion({
    this.id = const Value.absent(),
    this.link = const Value.absent(),
    this.title = const Value.absent(),
    this.size = const Value.absent(),
    this.format = const Value.absent(),
    this.fps = const Value.absent(),
    this.isAudio = const Value.absent(),
    this.thumbnailLink = const Value.absent(),
  });
  DownloadItemsCompanion.insert({
    this.id = const Value.absent(),
    required String link,
    required String title,
    this.size = const Value.absent(),
    this.format = const Value.absent(),
    this.fps = const Value.absent(),
    required bool isAudio,
    this.thumbnailLink = const Value.absent(),
  })  : link = Value(link),
        title = Value(title),
        isAudio = Value(isAudio);
  static Insertable<DownloadItem> custom({
    Expression<int>? id,
    Expression<String>? link,
    Expression<String>? title,
    Expression<int>? size,
    Expression<String?>? format,
    Expression<String?>? fps,
    Expression<bool>? isAudio,
    Expression<String?>? thumbnailLink,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (link != null) 'link': link,
      if (title != null) 'title': title,
      if (size != null) 'size': size,
      if (format != null) 'format': format,
      if (fps != null) 'fps': fps,
      if (isAudio != null) 'is_audio': isAudio,
      if (thumbnailLink != null) 'thumbnail_link': thumbnailLink,
    });
  }

  DownloadItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? link,
      Value<String>? title,
      Value<int>? size,
      Value<String?>? format,
      Value<String?>? fps,
      Value<bool>? isAudio,
      Value<String?>? thumbnailLink}) {
    return DownloadItemsCompanion(
      id: id ?? this.id,
      link: link ?? this.link,
      title: title ?? this.title,
      size: size ?? this.size,
      format: format ?? this.format,
      fps: fps ?? this.fps,
      isAudio: isAudio ?? this.isAudio,
      thumbnailLink: thumbnailLink ?? this.thumbnailLink,
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
    if (format.present) {
      map['format'] = Variable<String?>(format.value);
    }
    if (fps.present) {
      map['fps'] = Variable<String?>(fps.value);
    }
    if (isAudio.present) {
      map['is_audio'] = Variable<bool>(isAudio.value);
    }
    if (thumbnailLink.present) {
      map['thumbnail_link'] = Variable<String?>(thumbnailLink.value);
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
          ..write('format: $format, ')
          ..write('fps: $fps, ')
          ..write('isAudio: $isAudio, ')
          ..write('thumbnailLink: $thumbnailLink')
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
  final VerificationMeta _thumbnailLinkMeta =
      const VerificationMeta('thumbnailLink');
  @override
  late final GeneratedColumn<String?> thumbnailLink = GeneratedColumn<String?>(
      'thumbnail_link', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, link, title, size, format, fps, isAudio, thumbnailLink];
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
    if (data.containsKey('thumbnail_link')) {
      context.handle(
          _thumbnailLinkMeta,
          thumbnailLink.isAcceptableOrUnknown(
              data['thumbnail_link']!, _thumbnailLinkMeta));
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
