// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $GroupTable extends Group with TableInfo<$GroupTable, GroupData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES "group" (id)'));
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sku, title, path, tags, parentId, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group';
  @override
  VerificationContext validateIntegrity(Insertable<GroupData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    }
    if (data.containsKey('body')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['body']!, _tagsMeta));
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $GroupTable createAlias(String alias) {
    return $GroupTable(attachedDatabase, alias);
  }
}

class GroupData extends DataClass implements Insertable<GroupData> {
  final int id;
  final String? sku;
  final String title;
  final String? path;
  final String tags;
  final int? parentId;
  final DateTime lastUpdated;
  const GroupData(
      {required this.id,
      this.sku,
      required this.title,
      this.path,
      required this.tags,
      this.parentId,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    map['body'] = Variable<String>(tags);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  GroupCompanion toCompanion(bool nullToAbsent) {
    return GroupCompanion(
      id: Value(id),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      title: Value(title),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      tags: Value(tags),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory GroupData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupData(
      id: serializer.fromJson<int>(json['id']),
      sku: serializer.fromJson<String?>(json['sku']),
      title: serializer.fromJson<String>(json['title']),
      path: serializer.fromJson<String?>(json['path']),
      tags: serializer.fromJson<String>(json['tags']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sku': serializer.toJson<String?>(sku),
      'title': serializer.toJson<String>(title),
      'path': serializer.toJson<String?>(path),
      'tags': serializer.toJson<String>(tags),
      'parentId': serializer.toJson<int?>(parentId),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  GroupData copyWith(
          {int? id,
          Value<String?> sku = const Value.absent(),
          String? title,
          Value<String?> path = const Value.absent(),
          String? tags,
          Value<int?> parentId = const Value.absent(),
          DateTime? lastUpdated}) =>
      GroupData(
        id: id ?? this.id,
        sku: sku.present ? sku.value : this.sku,
        title: title ?? this.title,
        path: path.present ? path.value : this.path,
        tags: tags ?? this.tags,
        parentId: parentId.present ? parentId.value : this.parentId,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('GroupData(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('title: $title, ')
          ..write('path: $path, ')
          ..write('tags: $tags, ')
          ..write('parentId: $parentId, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sku, title, path, tags, parentId, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupData &&
          other.id == this.id &&
          other.sku == this.sku &&
          other.title == this.title &&
          other.path == this.path &&
          other.tags == this.tags &&
          other.parentId == this.parentId &&
          other.lastUpdated == this.lastUpdated);
}

class GroupCompanion extends UpdateCompanion<GroupData> {
  final Value<int> id;
  final Value<String?> sku;
  final Value<String> title;
  final Value<String?> path;
  final Value<String> tags;
  final Value<int?> parentId;
  final Value<DateTime> lastUpdated;
  const GroupCompanion({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    this.title = const Value.absent(),
    this.path = const Value.absent(),
    this.tags = const Value.absent(),
    this.parentId = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  GroupCompanion.insert({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    required String title,
    this.path = const Value.absent(),
    required String tags,
    this.parentId = const Value.absent(),
    required DateTime lastUpdated,
  })  : title = Value(title),
        tags = Value(tags),
        lastUpdated = Value(lastUpdated);
  static Insertable<GroupData> custom({
    Expression<int>? id,
    Expression<String>? sku,
    Expression<String>? title,
    Expression<String>? path,
    Expression<String>? tags,
    Expression<int>? parentId,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sku != null) 'sku': sku,
      if (title != null) 'title': title,
      if (path != null) 'path': path,
      if (tags != null) 'body': tags,
      if (parentId != null) 'parent_id': parentId,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  GroupCompanion copyWith(
      {Value<int>? id,
      Value<String?>? sku,
      Value<String>? title,
      Value<String?>? path,
      Value<String>? tags,
      Value<int?>? parentId,
      Value<DateTime>? lastUpdated}) {
    return GroupCompanion(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      title: title ?? this.title,
      path: path ?? this.path,
      tags: tags ?? this.tags,
      parentId: parentId ?? this.parentId,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (tags.present) {
      map['body'] = Variable<String>(tags.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupCompanion(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('title: $title, ')
          ..write('path: $path, ')
          ..write('tags: $tags, ')
          ..write('parentId: $parentId, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $HTMLContentsTable extends HTMLContents
    with TableInfo<$HTMLContentsTable, HTMLContent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HTMLContentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rectoMeta = const VerificationMeta('recto');
  @override
  late final GeneratedColumn<String> recto = GeneratedColumn<String>(
      'recto', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _versoMeta = const VerificationMeta('verso');
  @override
  late final GeneratedColumn<String> verso = GeneratedColumn<String>(
      'verso', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _isTemplatedMeta =
      const VerificationMeta('isTemplated');
  @override
  late final GeneratedColumn<bool> isTemplated = GeneratedColumn<bool>(
      'is_templated', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_templated" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _cardTemplatedJsonMeta =
      const VerificationMeta('cardTemplatedJson');
  @override
  late final GeneratedColumn<String> cardTemplatedJson =
      GeneratedColumn<String>('card_templated_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant(""));
  static const VerificationMeta _isAssemblyMeta =
      const VerificationMeta('isAssembly');
  @override
  late final GeneratedColumn<bool> isAssembly = GeneratedColumn<bool>(
      'is_assembly', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_assembly" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sku,
        path,
        recto,
        verso,
        isTemplated,
        cardTemplatedJson,
        isAssembly,
        lastUpdated
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'h_t_m_l_contents';
  @override
  VerificationContext validateIntegrity(Insertable<HTMLContent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    }
    if (data.containsKey('recto')) {
      context.handle(
          _rectoMeta, recto.isAcceptableOrUnknown(data['recto']!, _rectoMeta));
    }
    if (data.containsKey('verso')) {
      context.handle(
          _versoMeta, verso.isAcceptableOrUnknown(data['verso']!, _versoMeta));
    }
    if (data.containsKey('is_templated')) {
      context.handle(
          _isTemplatedMeta,
          isTemplated.isAcceptableOrUnknown(
              data['is_templated']!, _isTemplatedMeta));
    }
    if (data.containsKey('card_templated_json')) {
      context.handle(
          _cardTemplatedJsonMeta,
          cardTemplatedJson.isAcceptableOrUnknown(
              data['card_templated_json']!, _cardTemplatedJsonMeta));
    }
    if (data.containsKey('is_assembly')) {
      context.handle(
          _isAssemblyMeta,
          isAssembly.isAcceptableOrUnknown(
              data['is_assembly']!, _isAssemblyMeta));
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HTMLContent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HTMLContent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path']),
      recto: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recto'])!,
      verso: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}verso'])!,
      isTemplated: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_templated'])!,
      cardTemplatedJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}card_templated_json'])!,
      isAssembly: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_assembly'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $HTMLContentsTable createAlias(String alias) {
    return $HTMLContentsTable(attachedDatabase, alias);
  }
}

class HTMLContent extends DataClass implements Insertable<HTMLContent> {
  final int id;
  final String? sku;
  final String? path;
  final String recto;
  final String verso;
  final bool isTemplated;
  final String cardTemplatedJson;
  final bool isAssembly;
  final DateTime lastUpdated;
  const HTMLContent(
      {required this.id,
      this.sku,
      this.path,
      required this.recto,
      required this.verso,
      required this.isTemplated,
      required this.cardTemplatedJson,
      required this.isAssembly,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    map['recto'] = Variable<String>(recto);
    map['verso'] = Variable<String>(verso);
    map['is_templated'] = Variable<bool>(isTemplated);
    map['card_templated_json'] = Variable<String>(cardTemplatedJson);
    map['is_assembly'] = Variable<bool>(isAssembly);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  HTMLContentsCompanion toCompanion(bool nullToAbsent) {
    return HTMLContentsCompanion(
      id: Value(id),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      recto: Value(recto),
      verso: Value(verso),
      isTemplated: Value(isTemplated),
      cardTemplatedJson: Value(cardTemplatedJson),
      isAssembly: Value(isAssembly),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory HTMLContent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HTMLContent(
      id: serializer.fromJson<int>(json['id']),
      sku: serializer.fromJson<String?>(json['sku']),
      path: serializer.fromJson<String?>(json['path']),
      recto: serializer.fromJson<String>(json['recto']),
      verso: serializer.fromJson<String>(json['verso']),
      isTemplated: serializer.fromJson<bool>(json['isTemplated']),
      cardTemplatedJson: serializer.fromJson<String>(json['cardTemplatedJson']),
      isAssembly: serializer.fromJson<bool>(json['isAssembly']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sku': serializer.toJson<String?>(sku),
      'path': serializer.toJson<String?>(path),
      'recto': serializer.toJson<String>(recto),
      'verso': serializer.toJson<String>(verso),
      'isTemplated': serializer.toJson<bool>(isTemplated),
      'cardTemplatedJson': serializer.toJson<String>(cardTemplatedJson),
      'isAssembly': serializer.toJson<bool>(isAssembly),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  HTMLContent copyWith(
          {int? id,
          Value<String?> sku = const Value.absent(),
          Value<String?> path = const Value.absent(),
          String? recto,
          String? verso,
          bool? isTemplated,
          String? cardTemplatedJson,
          bool? isAssembly,
          DateTime? lastUpdated}) =>
      HTMLContent(
        id: id ?? this.id,
        sku: sku.present ? sku.value : this.sku,
        path: path.present ? path.value : this.path,
        recto: recto ?? this.recto,
        verso: verso ?? this.verso,
        isTemplated: isTemplated ?? this.isTemplated,
        cardTemplatedJson: cardTemplatedJson ?? this.cardTemplatedJson,
        isAssembly: isAssembly ?? this.isAssembly,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('HTMLContent(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('path: $path, ')
          ..write('recto: $recto, ')
          ..write('verso: $verso, ')
          ..write('isTemplated: $isTemplated, ')
          ..write('cardTemplatedJson: $cardTemplatedJson, ')
          ..write('isAssembly: $isAssembly, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sku, path, recto, verso, isTemplated,
      cardTemplatedJson, isAssembly, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HTMLContent &&
          other.id == this.id &&
          other.sku == this.sku &&
          other.path == this.path &&
          other.recto == this.recto &&
          other.verso == this.verso &&
          other.isTemplated == this.isTemplated &&
          other.cardTemplatedJson == this.cardTemplatedJson &&
          other.isAssembly == this.isAssembly &&
          other.lastUpdated == this.lastUpdated);
}

class HTMLContentsCompanion extends UpdateCompanion<HTMLContent> {
  final Value<int> id;
  final Value<String?> sku;
  final Value<String?> path;
  final Value<String> recto;
  final Value<String> verso;
  final Value<bool> isTemplated;
  final Value<String> cardTemplatedJson;
  final Value<bool> isAssembly;
  final Value<DateTime> lastUpdated;
  const HTMLContentsCompanion({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    this.path = const Value.absent(),
    this.recto = const Value.absent(),
    this.verso = const Value.absent(),
    this.isTemplated = const Value.absent(),
    this.cardTemplatedJson = const Value.absent(),
    this.isAssembly = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  HTMLContentsCompanion.insert({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    this.path = const Value.absent(),
    this.recto = const Value.absent(),
    this.verso = const Value.absent(),
    this.isTemplated = const Value.absent(),
    this.cardTemplatedJson = const Value.absent(),
    this.isAssembly = const Value.absent(),
    required DateTime lastUpdated,
  }) : lastUpdated = Value(lastUpdated);
  static Insertable<HTMLContent> custom({
    Expression<int>? id,
    Expression<String>? sku,
    Expression<String>? path,
    Expression<String>? recto,
    Expression<String>? verso,
    Expression<bool>? isTemplated,
    Expression<String>? cardTemplatedJson,
    Expression<bool>? isAssembly,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sku != null) 'sku': sku,
      if (path != null) 'path': path,
      if (recto != null) 'recto': recto,
      if (verso != null) 'verso': verso,
      if (isTemplated != null) 'is_templated': isTemplated,
      if (cardTemplatedJson != null) 'card_templated_json': cardTemplatedJson,
      if (isAssembly != null) 'is_assembly': isAssembly,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  HTMLContentsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? sku,
      Value<String?>? path,
      Value<String>? recto,
      Value<String>? verso,
      Value<bool>? isTemplated,
      Value<String>? cardTemplatedJson,
      Value<bool>? isAssembly,
      Value<DateTime>? lastUpdated}) {
    return HTMLContentsCompanion(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      path: path ?? this.path,
      recto: recto ?? this.recto,
      verso: verso ?? this.verso,
      isTemplated: isTemplated ?? this.isTemplated,
      cardTemplatedJson: cardTemplatedJson ?? this.cardTemplatedJson,
      isAssembly: isAssembly ?? this.isAssembly,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (recto.present) {
      map['recto'] = Variable<String>(recto.value);
    }
    if (verso.present) {
      map['verso'] = Variable<String>(verso.value);
    }
    if (isTemplated.present) {
      map['is_templated'] = Variable<bool>(isTemplated.value);
    }
    if (cardTemplatedJson.present) {
      map['card_templated_json'] = Variable<String>(cardTemplatedJson.value);
    }
    if (isAssembly.present) {
      map['is_assembly'] = Variable<bool>(isAssembly.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HTMLContentsCompanion(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('path: $path, ')
          ..write('recto: $recto, ')
          ..write('verso: $verso, ')
          ..write('isTemplated: $isTemplated, ')
          ..write('cardTemplatedJson: $cardTemplatedJson, ')
          ..write('isAssembly: $isAssembly, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $ReviseCardsTable extends ReviseCards
    with TableInfo<$ReviseCardsTable, ReviseCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviseCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
      'group_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES "group" (id)'));
  static const VerificationMeta _htmlContentMeta =
      const VerificationMeta('htmlContent');
  @override
  late final GeneratedColumn<int> htmlContent = GeneratedColumn<int>(
      'html_content', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES h_t_m_l_contents (id)'));
  static const VerificationMeta _displayerTypeMeta =
      const VerificationMeta('displayerType');
  @override
  late final GeneratedColumnWithTypeConverter<CardDisplayerType, int>
      displayerType = GeneratedColumn<int>('displayer_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<CardDisplayerType>(
              $ReviseCardsTable.$converterdisplayerType);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nextRevisionDateMultiplicatorMeta =
      const VerificationMeta('nextRevisionDateMultiplicator');
  @override
  late final GeneratedColumn<double> nextRevisionDateMultiplicator =
      GeneratedColumn<double>(
          'next_revision_date_multiplicator', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _nextRevisionDateMeta =
      const VerificationMeta('nextRevisionDate');
  @override
  late final GeneratedColumn<DateTime> nextRevisionDate =
      GeneratedColumn<DateTime>('next_revision_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mnemotechnicHintMeta =
      const VerificationMeta('mnemotechnicHint');
  @override
  late final GeneratedColumn<String> mnemotechnicHint = GeneratedColumn<String>(
      'mnemotechnic_hint', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sku,
        groupId,
        htmlContent,
        displayerType,
        tags,
        nextRevisionDateMultiplicator,
        nextRevisionDate,
        path,
        mnemotechnicHint,
        lastUpdated
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'revise_cards';
  @override
  VerificationContext validateIntegrity(Insertable<ReviseCard> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('html_content')) {
      context.handle(
          _htmlContentMeta,
          htmlContent.isAcceptableOrUnknown(
              data['html_content']!, _htmlContentMeta));
    } else if (isInserting) {
      context.missing(_htmlContentMeta);
    }
    context.handle(_displayerTypeMeta, const VerificationResult.success());
    if (data.containsKey('body')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['body']!, _tagsMeta));
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    if (data.containsKey('next_revision_date_multiplicator')) {
      context.handle(
          _nextRevisionDateMultiplicatorMeta,
          nextRevisionDateMultiplicator.isAcceptableOrUnknown(
              data['next_revision_date_multiplicator']!,
              _nextRevisionDateMultiplicatorMeta));
    } else if (isInserting) {
      context.missing(_nextRevisionDateMultiplicatorMeta);
    }
    if (data.containsKey('next_revision_date')) {
      context.handle(
          _nextRevisionDateMeta,
          nextRevisionDate.isAcceptableOrUnknown(
              data['next_revision_date']!, _nextRevisionDateMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    }
    if (data.containsKey('mnemotechnic_hint')) {
      context.handle(
          _mnemotechnicHintMeta,
          mnemotechnicHint.isAcceptableOrUnknown(
              data['mnemotechnic_hint']!, _mnemotechnicHintMeta));
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviseCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviseCard(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_id'])!,
      htmlContent: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}html_content'])!,
      displayerType: $ReviseCardsTable.$converterdisplayerType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}displayer_type'])!),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      nextRevisionDateMultiplicator: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}next_revision_date_multiplicator'])!,
      nextRevisionDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_revision_date']),
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path']),
      mnemotechnicHint: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}mnemotechnic_hint']),
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $ReviseCardsTable createAlias(String alias) {
    return $ReviseCardsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CardDisplayerType, int, int>
      $converterdisplayerType =
      const EnumIndexConverter<CardDisplayerType>(CardDisplayerType.values);
}

class ReviseCard extends DataClass implements Insertable<ReviseCard> {
  final int id;
  final String? sku;
  final int groupId;
  final int htmlContent;
  final CardDisplayerType displayerType;
  final String tags;
  final double nextRevisionDateMultiplicator;
  final DateTime? nextRevisionDate;
  final String? path;
  final String? mnemotechnicHint;
  final DateTime lastUpdated;
  const ReviseCard(
      {required this.id,
      this.sku,
      required this.groupId,
      required this.htmlContent,
      required this.displayerType,
      required this.tags,
      required this.nextRevisionDateMultiplicator,
      this.nextRevisionDate,
      this.path,
      this.mnemotechnicHint,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['group_id'] = Variable<int>(groupId);
    map['html_content'] = Variable<int>(htmlContent);
    {
      map['displayer_type'] = Variable<int>(
          $ReviseCardsTable.$converterdisplayerType.toSql(displayerType));
    }
    map['body'] = Variable<String>(tags);
    map['next_revision_date_multiplicator'] =
        Variable<double>(nextRevisionDateMultiplicator);
    if (!nullToAbsent || nextRevisionDate != null) {
      map['next_revision_date'] = Variable<DateTime>(nextRevisionDate);
    }
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    if (!nullToAbsent || mnemotechnicHint != null) {
      map['mnemotechnic_hint'] = Variable<String>(mnemotechnicHint);
    }
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  ReviseCardsCompanion toCompanion(bool nullToAbsent) {
    return ReviseCardsCompanion(
      id: Value(id),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      groupId: Value(groupId),
      htmlContent: Value(htmlContent),
      displayerType: Value(displayerType),
      tags: Value(tags),
      nextRevisionDateMultiplicator: Value(nextRevisionDateMultiplicator),
      nextRevisionDate: nextRevisionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextRevisionDate),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      mnemotechnicHint: mnemotechnicHint == null && nullToAbsent
          ? const Value.absent()
          : Value(mnemotechnicHint),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory ReviseCard.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviseCard(
      id: serializer.fromJson<int>(json['id']),
      sku: serializer.fromJson<String?>(json['sku']),
      groupId: serializer.fromJson<int>(json['groupId']),
      htmlContent: serializer.fromJson<int>(json['htmlContent']),
      displayerType: $ReviseCardsTable.$converterdisplayerType
          .fromJson(serializer.fromJson<int>(json['displayerType'])),
      tags: serializer.fromJson<String>(json['tags']),
      nextRevisionDateMultiplicator:
          serializer.fromJson<double>(json['nextRevisionDateMultiplicator']),
      nextRevisionDate:
          serializer.fromJson<DateTime?>(json['nextRevisionDate']),
      path: serializer.fromJson<String?>(json['path']),
      mnemotechnicHint: serializer.fromJson<String?>(json['mnemotechnicHint']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sku': serializer.toJson<String?>(sku),
      'groupId': serializer.toJson<int>(groupId),
      'htmlContent': serializer.toJson<int>(htmlContent),
      'displayerType': serializer.toJson<int>(
          $ReviseCardsTable.$converterdisplayerType.toJson(displayerType)),
      'tags': serializer.toJson<String>(tags),
      'nextRevisionDateMultiplicator':
          serializer.toJson<double>(nextRevisionDateMultiplicator),
      'nextRevisionDate': serializer.toJson<DateTime?>(nextRevisionDate),
      'path': serializer.toJson<String?>(path),
      'mnemotechnicHint': serializer.toJson<String?>(mnemotechnicHint),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  ReviseCard copyWith(
          {int? id,
          Value<String?> sku = const Value.absent(),
          int? groupId,
          int? htmlContent,
          CardDisplayerType? displayerType,
          String? tags,
          double? nextRevisionDateMultiplicator,
          Value<DateTime?> nextRevisionDate = const Value.absent(),
          Value<String?> path = const Value.absent(),
          Value<String?> mnemotechnicHint = const Value.absent(),
          DateTime? lastUpdated}) =>
      ReviseCard(
        id: id ?? this.id,
        sku: sku.present ? sku.value : this.sku,
        groupId: groupId ?? this.groupId,
        htmlContent: htmlContent ?? this.htmlContent,
        displayerType: displayerType ?? this.displayerType,
        tags: tags ?? this.tags,
        nextRevisionDateMultiplicator:
            nextRevisionDateMultiplicator ?? this.nextRevisionDateMultiplicator,
        nextRevisionDate: nextRevisionDate.present
            ? nextRevisionDate.value
            : this.nextRevisionDate,
        path: path.present ? path.value : this.path,
        mnemotechnicHint: mnemotechnicHint.present
            ? mnemotechnicHint.value
            : this.mnemotechnicHint,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('ReviseCard(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('groupId: $groupId, ')
          ..write('htmlContent: $htmlContent, ')
          ..write('displayerType: $displayerType, ')
          ..write('tags: $tags, ')
          ..write(
              'nextRevisionDateMultiplicator: $nextRevisionDateMultiplicator, ')
          ..write('nextRevisionDate: $nextRevisionDate, ')
          ..write('path: $path, ')
          ..write('mnemotechnicHint: $mnemotechnicHint, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      sku,
      groupId,
      htmlContent,
      displayerType,
      tags,
      nextRevisionDateMultiplicator,
      nextRevisionDate,
      path,
      mnemotechnicHint,
      lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviseCard &&
          other.id == this.id &&
          other.sku == this.sku &&
          other.groupId == this.groupId &&
          other.htmlContent == this.htmlContent &&
          other.displayerType == this.displayerType &&
          other.tags == this.tags &&
          other.nextRevisionDateMultiplicator ==
              this.nextRevisionDateMultiplicator &&
          other.nextRevisionDate == this.nextRevisionDate &&
          other.path == this.path &&
          other.mnemotechnicHint == this.mnemotechnicHint &&
          other.lastUpdated == this.lastUpdated);
}

class ReviseCardsCompanion extends UpdateCompanion<ReviseCard> {
  final Value<int> id;
  final Value<String?> sku;
  final Value<int> groupId;
  final Value<int> htmlContent;
  final Value<CardDisplayerType> displayerType;
  final Value<String> tags;
  final Value<double> nextRevisionDateMultiplicator;
  final Value<DateTime?> nextRevisionDate;
  final Value<String?> path;
  final Value<String?> mnemotechnicHint;
  final Value<DateTime> lastUpdated;
  const ReviseCardsCompanion({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    this.groupId = const Value.absent(),
    this.htmlContent = const Value.absent(),
    this.displayerType = const Value.absent(),
    this.tags = const Value.absent(),
    this.nextRevisionDateMultiplicator = const Value.absent(),
    this.nextRevisionDate = const Value.absent(),
    this.path = const Value.absent(),
    this.mnemotechnicHint = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  ReviseCardsCompanion.insert({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    required int groupId,
    required int htmlContent,
    required CardDisplayerType displayerType,
    required String tags,
    required double nextRevisionDateMultiplicator,
    this.nextRevisionDate = const Value.absent(),
    this.path = const Value.absent(),
    this.mnemotechnicHint = const Value.absent(),
    required DateTime lastUpdated,
  })  : groupId = Value(groupId),
        htmlContent = Value(htmlContent),
        displayerType = Value(displayerType),
        tags = Value(tags),
        nextRevisionDateMultiplicator = Value(nextRevisionDateMultiplicator),
        lastUpdated = Value(lastUpdated);
  static Insertable<ReviseCard> custom({
    Expression<int>? id,
    Expression<String>? sku,
    Expression<int>? groupId,
    Expression<int>? htmlContent,
    Expression<int>? displayerType,
    Expression<String>? tags,
    Expression<double>? nextRevisionDateMultiplicator,
    Expression<DateTime>? nextRevisionDate,
    Expression<String>? path,
    Expression<String>? mnemotechnicHint,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sku != null) 'sku': sku,
      if (groupId != null) 'group_id': groupId,
      if (htmlContent != null) 'html_content': htmlContent,
      if (displayerType != null) 'displayer_type': displayerType,
      if (tags != null) 'body': tags,
      if (nextRevisionDateMultiplicator != null)
        'next_revision_date_multiplicator': nextRevisionDateMultiplicator,
      if (nextRevisionDate != null) 'next_revision_date': nextRevisionDate,
      if (path != null) 'path': path,
      if (mnemotechnicHint != null) 'mnemotechnic_hint': mnemotechnicHint,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  ReviseCardsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? sku,
      Value<int>? groupId,
      Value<int>? htmlContent,
      Value<CardDisplayerType>? displayerType,
      Value<String>? tags,
      Value<double>? nextRevisionDateMultiplicator,
      Value<DateTime?>? nextRevisionDate,
      Value<String?>? path,
      Value<String?>? mnemotechnicHint,
      Value<DateTime>? lastUpdated}) {
    return ReviseCardsCompanion(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      groupId: groupId ?? this.groupId,
      htmlContent: htmlContent ?? this.htmlContent,
      displayerType: displayerType ?? this.displayerType,
      tags: tags ?? this.tags,
      nextRevisionDateMultiplicator:
          nextRevisionDateMultiplicator ?? this.nextRevisionDateMultiplicator,
      nextRevisionDate: nextRevisionDate ?? this.nextRevisionDate,
      path: path ?? this.path,
      mnemotechnicHint: mnemotechnicHint ?? this.mnemotechnicHint,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (htmlContent.present) {
      map['html_content'] = Variable<int>(htmlContent.value);
    }
    if (displayerType.present) {
      map['displayer_type'] = Variable<int>(
          $ReviseCardsTable.$converterdisplayerType.toSql(displayerType.value));
    }
    if (tags.present) {
      map['body'] = Variable<String>(tags.value);
    }
    if (nextRevisionDateMultiplicator.present) {
      map['next_revision_date_multiplicator'] =
          Variable<double>(nextRevisionDateMultiplicator.value);
    }
    if (nextRevisionDate.present) {
      map['next_revision_date'] = Variable<DateTime>(nextRevisionDate.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (mnemotechnicHint.present) {
      map['mnemotechnic_hint'] = Variable<String>(mnemotechnicHint.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviseCardsCompanion(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('groupId: $groupId, ')
          ..write('htmlContent: $htmlContent, ')
          ..write('displayerType: $displayerType, ')
          ..write('tags: $tags, ')
          ..write(
              'nextRevisionDateMultiplicator: $nextRevisionDateMultiplicator, ')
          ..write('nextRevisionDate: $nextRevisionDate, ')
          ..write('path: $path, ')
          ..write('mnemotechnicHint: $mnemotechnicHint, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $ImagesTable extends Images with TableInfo<$ImagesTable, Image> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 256),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, path];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'images';
  @override
  VerificationContext validateIntegrity(Insertable<Image> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Image map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Image(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
    );
  }

  @override
  $ImagesTable createAlias(String alias) {
    return $ImagesTable(attachedDatabase, alias);
  }
}

class Image extends DataClass implements Insertable<Image> {
  final int id;
  final String path;
  const Image({required this.id, required this.path});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['path'] = Variable<String>(path);
    return map;
  }

  ImagesCompanion toCompanion(bool nullToAbsent) {
    return ImagesCompanion(
      id: Value(id),
      path: Value(path),
    );
  }

  factory Image.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Image(
      id: serializer.fromJson<int>(json['id']),
      path: serializer.fromJson<String>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'path': serializer.toJson<String>(path),
    };
  }

  Image copyWith({int? id, String? path}) => Image(
        id: id ?? this.id,
        path: path ?? this.path,
      );
  @override
  String toString() {
    return (StringBuffer('Image(')
          ..write('id: $id, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, path);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Image && other.id == this.id && other.path == this.path);
}

class ImagesCompanion extends UpdateCompanion<Image> {
  final Value<int> id;
  final Value<String> path;
  const ImagesCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
  });
  ImagesCompanion.insert({
    this.id = const Value.absent(),
    required String path,
  }) : path = Value(path);
  static Insertable<Image> custom({
    Expression<int>? id,
    Expression<String>? path,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (path != null) 'path': path,
    });
  }

  ImagesCompanion copyWith({Value<int>? id, Value<String>? path}) {
    return ImagesCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImagesCompanion(')
          ..write('id: $id, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }
}

class $CoursesTable extends Courses with TableInfo<$CoursesTable, Course> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sku, imageUrl, title, description, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courses';
  @override
  VerificationContext validateIntegrity(Insertable<Course> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Course map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Course(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $CoursesTable createAlias(String alias) {
    return $CoursesTable(attachedDatabase, alias);
  }
}

class Course extends DataClass implements Insertable<Course> {
  final int id;
  final String? sku;
  final String imageUrl;
  final String title;
  final String description;
  final DateTime lastUpdated;
  const Course(
      {required this.id,
      this.sku,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['image_url'] = Variable<String>(imageUrl);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  CoursesCompanion toCompanion(bool nullToAbsent) {
    return CoursesCompanion(
      id: Value(id),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      imageUrl: Value(imageUrl),
      title: Value(title),
      description: Value(description),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory Course.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Course(
      id: serializer.fromJson<int>(json['id']),
      sku: serializer.fromJson<String?>(json['sku']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sku': serializer.toJson<String?>(sku),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  Course copyWith(
          {int? id,
          Value<String?> sku = const Value.absent(),
          String? imageUrl,
          String? title,
          String? description,
          DateTime? lastUpdated}) =>
      Course(
        id: id ?? this.id,
        sku: sku.present ? sku.value : this.sku,
        imageUrl: imageUrl ?? this.imageUrl,
        title: title ?? this.title,
        description: description ?? this.description,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('Course(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sku, imageUrl, title, description, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Course &&
          other.id == this.id &&
          other.sku == this.sku &&
          other.imageUrl == this.imageUrl &&
          other.title == this.title &&
          other.description == this.description &&
          other.lastUpdated == this.lastUpdated);
}

class CoursesCompanion extends UpdateCompanion<Course> {
  final Value<int> id;
  final Value<String?> sku;
  final Value<String> imageUrl;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> lastUpdated;
  const CoursesCompanion({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  CoursesCompanion.insert({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    required String imageUrl,
    required String title,
    required String description,
    required DateTime lastUpdated,
  })  : imageUrl = Value(imageUrl),
        title = Value(title),
        description = Value(description),
        lastUpdated = Value(lastUpdated);
  static Insertable<Course> custom({
    Expression<int>? id,
    Expression<String>? sku,
    Expression<String>? imageUrl,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sku != null) 'sku': sku,
      if (imageUrl != null) 'image_url': imageUrl,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  CoursesCompanion copyWith(
      {Value<int>? id,
      Value<String?>? sku,
      Value<String>? imageUrl,
      Value<String>? title,
      Value<String>? description,
      Value<DateTime>? lastUpdated}) {
    return CoursesCompanion(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCompanion(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $FileContentsTable extends FileContents
    with TableInfo<$FileContentsTable, FileContent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FileContentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
      'format', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<Uint8List> content = GeneratedColumn<Uint8List>(
      'content', aliasedName, false,
      type: DriftSqlType.blob, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sku, name, path, format, content, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'file_contents';
  @override
  VerificationContext validateIntegrity(Insertable<FileContent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    }
    if (data.containsKey('format')) {
      context.handle(_formatMeta,
          format.isAcceptableOrUnknown(data['format']!, _formatMeta));
    } else if (isInserting) {
      context.missing(_formatMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FileContent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FileContent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path']),
      format: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}format'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}content'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $FileContentsTable createAlias(String alias) {
    return $FileContentsTable(attachedDatabase, alias);
  }
}

class FileContent extends DataClass implements Insertable<FileContent> {
  final int id;
  final String? sku;
  final String name;
  final String? path;
  final String format;
  final Uint8List content;
  final DateTime lastUpdated;
  const FileContent(
      {required this.id,
      this.sku,
      required this.name,
      this.path,
      required this.format,
      required this.content,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    map['format'] = Variable<String>(format);
    map['content'] = Variable<Uint8List>(content);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  FileContentsCompanion toCompanion(bool nullToAbsent) {
    return FileContentsCompanion(
      id: Value(id),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      name: Value(name),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      format: Value(format),
      content: Value(content),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory FileContent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FileContent(
      id: serializer.fromJson<int>(json['id']),
      sku: serializer.fromJson<String?>(json['sku']),
      name: serializer.fromJson<String>(json['name']),
      path: serializer.fromJson<String?>(json['path']),
      format: serializer.fromJson<String>(json['format']),
      content: serializer.fromJson<Uint8List>(json['content']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sku': serializer.toJson<String?>(sku),
      'name': serializer.toJson<String>(name),
      'path': serializer.toJson<String?>(path),
      'format': serializer.toJson<String>(format),
      'content': serializer.toJson<Uint8List>(content),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  FileContent copyWith(
          {int? id,
          Value<String?> sku = const Value.absent(),
          String? name,
          Value<String?> path = const Value.absent(),
          String? format,
          Uint8List? content,
          DateTime? lastUpdated}) =>
      FileContent(
        id: id ?? this.id,
        sku: sku.present ? sku.value : this.sku,
        name: name ?? this.name,
        path: path.present ? path.value : this.path,
        format: format ?? this.format,
        content: content ?? this.content,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('FileContent(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('format: $format, ')
          ..write('content: $content, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sku, name, path, format,
      $driftBlobEquality.hash(content), lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FileContent &&
          other.id == this.id &&
          other.sku == this.sku &&
          other.name == this.name &&
          other.path == this.path &&
          other.format == this.format &&
          $driftBlobEquality.equals(other.content, this.content) &&
          other.lastUpdated == this.lastUpdated);
}

class FileContentsCompanion extends UpdateCompanion<FileContent> {
  final Value<int> id;
  final Value<String?> sku;
  final Value<String> name;
  final Value<String?> path;
  final Value<String> format;
  final Value<Uint8List> content;
  final Value<DateTime> lastUpdated;
  const FileContentsCompanion({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
    this.format = const Value.absent(),
    this.content = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  FileContentsCompanion.insert({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    required String name,
    this.path = const Value.absent(),
    required String format,
    required Uint8List content,
    required DateTime lastUpdated,
  })  : name = Value(name),
        format = Value(format),
        content = Value(content),
        lastUpdated = Value(lastUpdated);
  static Insertable<FileContent> custom({
    Expression<int>? id,
    Expression<String>? sku,
    Expression<String>? name,
    Expression<String>? path,
    Expression<String>? format,
    Expression<Uint8List>? content,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sku != null) 'sku': sku,
      if (name != null) 'name': name,
      if (path != null) 'path': path,
      if (format != null) 'format': format,
      if (content != null) 'content': content,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  FileContentsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? sku,
      Value<String>? name,
      Value<String?>? path,
      Value<String>? format,
      Value<Uint8List>? content,
      Value<DateTime>? lastUpdated}) {
    return FileContentsCompanion(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      name: name ?? this.name,
      path: path ?? this.path,
      format: format ?? this.format,
      content: content ?? this.content,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (content.present) {
      map['content'] = Variable<Uint8List>(content.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FileContentsCompanion(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('format: $format, ')
          ..write('content: $content, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $HTMLContentFilesTable extends HTMLContentFiles
    with TableInfo<$HTMLContentFilesTable, HTMLContentFile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HTMLContentFilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  @override
  late final GeneratedColumn<int> fileId = GeneratedColumn<int>(
      'file_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES file_contents (id)'));
  static const VerificationMeta _htmlContentParentIdMeta =
      const VerificationMeta('htmlContentParentId');
  @override
  late final GeneratedColumn<int> htmlContentParentId = GeneratedColumn<int>(
      'html_content_parent_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES h_t_m_l_contents (id)'));
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, fileId, htmlContentParentId, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'h_t_m_l_content_files';
  @override
  VerificationContext validateIntegrity(Insertable<HTMLContentFile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('file_id')) {
      context.handle(_fileIdMeta,
          fileId.isAcceptableOrUnknown(data['file_id']!, _fileIdMeta));
    } else if (isInserting) {
      context.missing(_fileIdMeta);
    }
    if (data.containsKey('html_content_parent_id')) {
      context.handle(
          _htmlContentParentIdMeta,
          htmlContentParentId.isAcceptableOrUnknown(
              data['html_content_parent_id']!, _htmlContentParentIdMeta));
    } else if (isInserting) {
      context.missing(_htmlContentParentIdMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HTMLContentFile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HTMLContentFile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fileId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}file_id'])!,
      htmlContentParentId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}html_content_parent_id'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $HTMLContentFilesTable createAlias(String alias) {
    return $HTMLContentFilesTable(attachedDatabase, alias);
  }
}

class HTMLContentFile extends DataClass implements Insertable<HTMLContentFile> {
  final int id;
  final int fileId;
  final int htmlContentParentId;
  final DateTime lastUpdated;
  const HTMLContentFile(
      {required this.id,
      required this.fileId,
      required this.htmlContentParentId,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['file_id'] = Variable<int>(fileId);
    map['html_content_parent_id'] = Variable<int>(htmlContentParentId);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  HTMLContentFilesCompanion toCompanion(bool nullToAbsent) {
    return HTMLContentFilesCompanion(
      id: Value(id),
      fileId: Value(fileId),
      htmlContentParentId: Value(htmlContentParentId),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory HTMLContentFile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HTMLContentFile(
      id: serializer.fromJson<int>(json['id']),
      fileId: serializer.fromJson<int>(json['fileId']),
      htmlContentParentId:
          serializer.fromJson<int>(json['htmlContentParentId']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fileId': serializer.toJson<int>(fileId),
      'htmlContentParentId': serializer.toJson<int>(htmlContentParentId),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  HTMLContentFile copyWith(
          {int? id,
          int? fileId,
          int? htmlContentParentId,
          DateTime? lastUpdated}) =>
      HTMLContentFile(
        id: id ?? this.id,
        fileId: fileId ?? this.fileId,
        htmlContentParentId: htmlContentParentId ?? this.htmlContentParentId,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('HTMLContentFile(')
          ..write('id: $id, ')
          ..write('fileId: $fileId, ')
          ..write('htmlContentParentId: $htmlContentParentId, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fileId, htmlContentParentId, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HTMLContentFile &&
          other.id == this.id &&
          other.fileId == this.fileId &&
          other.htmlContentParentId == this.htmlContentParentId &&
          other.lastUpdated == this.lastUpdated);
}

class HTMLContentFilesCompanion extends UpdateCompanion<HTMLContentFile> {
  final Value<int> id;
  final Value<int> fileId;
  final Value<int> htmlContentParentId;
  final Value<DateTime> lastUpdated;
  const HTMLContentFilesCompanion({
    this.id = const Value.absent(),
    this.fileId = const Value.absent(),
    this.htmlContentParentId = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  HTMLContentFilesCompanion.insert({
    this.id = const Value.absent(),
    required int fileId,
    required int htmlContentParentId,
    required DateTime lastUpdated,
  })  : fileId = Value(fileId),
        htmlContentParentId = Value(htmlContentParentId),
        lastUpdated = Value(lastUpdated);
  static Insertable<HTMLContentFile> custom({
    Expression<int>? id,
    Expression<int>? fileId,
    Expression<int>? htmlContentParentId,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileId != null) 'file_id': fileId,
      if (htmlContentParentId != null)
        'html_content_parent_id': htmlContentParentId,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  HTMLContentFilesCompanion copyWith(
      {Value<int>? id,
      Value<int>? fileId,
      Value<int>? htmlContentParentId,
      Value<DateTime>? lastUpdated}) {
    return HTMLContentFilesCompanion(
      id: id ?? this.id,
      fileId: fileId ?? this.fileId,
      htmlContentParentId: htmlContentParentId ?? this.htmlContentParentId,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fileId.present) {
      map['file_id'] = Variable<int>(fileId.value);
    }
    if (htmlContentParentId.present) {
      map['html_content_parent_id'] = Variable<int>(htmlContentParentId.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HTMLContentFilesCompanion(')
          ..write('id: $id, ')
          ..write('fileId: $fileId, ')
          ..write('htmlContentParentId: $htmlContentParentId, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $TopicsTable extends Topics with TableInfo<$TopicsTable, Topic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES topics (id)'));
  static const VerificationMeta _parentCourseIdMeta =
      const VerificationMeta('parentCourseId');
  @override
  late final GeneratedColumn<int> parentCourseId = GeneratedColumn<int>(
      'parent_course_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES courses (id)'));
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
      'group_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES "group" (id)'));
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  @override
  late final GeneratedColumn<int> fileId = GeneratedColumn<int>(
      'file_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES file_contents (id)'));
  static const VerificationMeta _htmlContentIdMeta =
      const VerificationMeta('htmlContentId');
  @override
  late final GeneratedColumn<int> htmlContentId = GeneratedColumn<int>(
      'html_content_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES h_t_m_l_contents (id)'));
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sku,
        path,
        title,
        parentId,
        parentCourseId,
        groupId,
        fileId,
        htmlContentId,
        lastUpdated
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topics';
  @override
  VerificationContext validateIntegrity(Insertable<Topic> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('parent_course_id')) {
      context.handle(
          _parentCourseIdMeta,
          parentCourseId.isAcceptableOrUnknown(
              data['parent_course_id']!, _parentCourseIdMeta));
    } else if (isInserting) {
      context.missing(_parentCourseIdMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    }
    if (data.containsKey('file_id')) {
      context.handle(_fileIdMeta,
          fileId.isAcceptableOrUnknown(data['file_id']!, _fileIdMeta));
    }
    if (data.containsKey('html_content_id')) {
      context.handle(
          _htmlContentIdMeta,
          htmlContentId.isAcceptableOrUnknown(
              data['html_content_id']!, _htmlContentIdMeta));
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Topic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Topic(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      parentCourseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_course_id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_id']),
      fileId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}file_id']),
      htmlContentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}html_content_id']),
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $TopicsTable createAlias(String alias) {
    return $TopicsTable(attachedDatabase, alias);
  }
}

class Topic extends DataClass implements Insertable<Topic> {
  final int id;
  final String? sku;
  final String? path;
  final String title;
  final int? parentId;
  final int parentCourseId;
  final int? groupId;
  final int? fileId;
  final int? htmlContentId;
  final DateTime lastUpdated;
  const Topic(
      {required this.id,
      this.sku,
      this.path,
      required this.title,
      this.parentId,
      required this.parentCourseId,
      this.groupId,
      this.fileId,
      this.htmlContentId,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['parent_course_id'] = Variable<int>(parentCourseId);
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<int>(groupId);
    }
    if (!nullToAbsent || fileId != null) {
      map['file_id'] = Variable<int>(fileId);
    }
    if (!nullToAbsent || htmlContentId != null) {
      map['html_content_id'] = Variable<int>(htmlContentId);
    }
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  TopicsCompanion toCompanion(bool nullToAbsent) {
    return TopicsCompanion(
      id: Value(id),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      title: Value(title),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      parentCourseId: Value(parentCourseId),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      fileId:
          fileId == null && nullToAbsent ? const Value.absent() : Value(fileId),
      htmlContentId: htmlContentId == null && nullToAbsent
          ? const Value.absent()
          : Value(htmlContentId),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory Topic.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Topic(
      id: serializer.fromJson<int>(json['id']),
      sku: serializer.fromJson<String?>(json['sku']),
      path: serializer.fromJson<String?>(json['path']),
      title: serializer.fromJson<String>(json['title']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      parentCourseId: serializer.fromJson<int>(json['parentCourseId']),
      groupId: serializer.fromJson<int?>(json['groupId']),
      fileId: serializer.fromJson<int?>(json['fileId']),
      htmlContentId: serializer.fromJson<int?>(json['htmlContentId']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sku': serializer.toJson<String?>(sku),
      'path': serializer.toJson<String?>(path),
      'title': serializer.toJson<String>(title),
      'parentId': serializer.toJson<int?>(parentId),
      'parentCourseId': serializer.toJson<int>(parentCourseId),
      'groupId': serializer.toJson<int?>(groupId),
      'fileId': serializer.toJson<int?>(fileId),
      'htmlContentId': serializer.toJson<int?>(htmlContentId),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  Topic copyWith(
          {int? id,
          Value<String?> sku = const Value.absent(),
          Value<String?> path = const Value.absent(),
          String? title,
          Value<int?> parentId = const Value.absent(),
          int? parentCourseId,
          Value<int?> groupId = const Value.absent(),
          Value<int?> fileId = const Value.absent(),
          Value<int?> htmlContentId = const Value.absent(),
          DateTime? lastUpdated}) =>
      Topic(
        id: id ?? this.id,
        sku: sku.present ? sku.value : this.sku,
        path: path.present ? path.value : this.path,
        title: title ?? this.title,
        parentId: parentId.present ? parentId.value : this.parentId,
        parentCourseId: parentCourseId ?? this.parentCourseId,
        groupId: groupId.present ? groupId.value : this.groupId,
        fileId: fileId.present ? fileId.value : this.fileId,
        htmlContentId:
            htmlContentId.present ? htmlContentId.value : this.htmlContentId,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('Topic(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('path: $path, ')
          ..write('title: $title, ')
          ..write('parentId: $parentId, ')
          ..write('parentCourseId: $parentCourseId, ')
          ..write('groupId: $groupId, ')
          ..write('fileId: $fileId, ')
          ..write('htmlContentId: $htmlContentId, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sku, path, title, parentId,
      parentCourseId, groupId, fileId, htmlContentId, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Topic &&
          other.id == this.id &&
          other.sku == this.sku &&
          other.path == this.path &&
          other.title == this.title &&
          other.parentId == this.parentId &&
          other.parentCourseId == this.parentCourseId &&
          other.groupId == this.groupId &&
          other.fileId == this.fileId &&
          other.htmlContentId == this.htmlContentId &&
          other.lastUpdated == this.lastUpdated);
}

class TopicsCompanion extends UpdateCompanion<Topic> {
  final Value<int> id;
  final Value<String?> sku;
  final Value<String?> path;
  final Value<String> title;
  final Value<int?> parentId;
  final Value<int> parentCourseId;
  final Value<int?> groupId;
  final Value<int?> fileId;
  final Value<int?> htmlContentId;
  final Value<DateTime> lastUpdated;
  const TopicsCompanion({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    this.path = const Value.absent(),
    this.title = const Value.absent(),
    this.parentId = const Value.absent(),
    this.parentCourseId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.fileId = const Value.absent(),
    this.htmlContentId = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  TopicsCompanion.insert({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    this.path = const Value.absent(),
    required String title,
    this.parentId = const Value.absent(),
    required int parentCourseId,
    this.groupId = const Value.absent(),
    this.fileId = const Value.absent(),
    this.htmlContentId = const Value.absent(),
    required DateTime lastUpdated,
  })  : title = Value(title),
        parentCourseId = Value(parentCourseId),
        lastUpdated = Value(lastUpdated);
  static Insertable<Topic> custom({
    Expression<int>? id,
    Expression<String>? sku,
    Expression<String>? path,
    Expression<String>? title,
    Expression<int>? parentId,
    Expression<int>? parentCourseId,
    Expression<int>? groupId,
    Expression<int>? fileId,
    Expression<int>? htmlContentId,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sku != null) 'sku': sku,
      if (path != null) 'path': path,
      if (title != null) 'title': title,
      if (parentId != null) 'parent_id': parentId,
      if (parentCourseId != null) 'parent_course_id': parentCourseId,
      if (groupId != null) 'group_id': groupId,
      if (fileId != null) 'file_id': fileId,
      if (htmlContentId != null) 'html_content_id': htmlContentId,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  TopicsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? sku,
      Value<String?>? path,
      Value<String>? title,
      Value<int?>? parentId,
      Value<int>? parentCourseId,
      Value<int?>? groupId,
      Value<int?>? fileId,
      Value<int?>? htmlContentId,
      Value<DateTime>? lastUpdated}) {
    return TopicsCompanion(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      path: path ?? this.path,
      title: title ?? this.title,
      parentId: parentId ?? this.parentId,
      parentCourseId: parentCourseId ?? this.parentCourseId,
      groupId: groupId ?? this.groupId,
      fileId: fileId ?? this.fileId,
      htmlContentId: htmlContentId ?? this.htmlContentId,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (parentCourseId.present) {
      map['parent_course_id'] = Variable<int>(parentCourseId.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (fileId.present) {
      map['file_id'] = Variable<int>(fileId.value);
    }
    if (htmlContentId.present) {
      map['html_content_id'] = Variable<int>(htmlContentId.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicsCompanion(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('path: $path, ')
          ..write('title: $title, ')
          ..write('parentId: $parentId, ')
          ..write('parentCourseId: $parentCourseId, ')
          ..write('groupId: $groupId, ')
          ..write('fileId: $fileId, ')
          ..write('htmlContentId: $htmlContentId, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $CardTemplateTable extends CardTemplate
    with TableInfo<$CardTemplateTable, CardTemplateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardTemplateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _templateMeta =
      const VerificationMeta('template');
  @override
  late final GeneratedColumn<String> template = GeneratedColumn<String>(
      'template', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, sku, path, template, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_template';
  @override
  VerificationContext validateIntegrity(Insertable<CardTemplateData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('template')) {
      context.handle(_templateMeta,
          template.isAcceptableOrUnknown(data['template']!, _templateMeta));
    } else if (isInserting) {
      context.missing(_templateMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardTemplateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardTemplateData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      template: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}template'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $CardTemplateTable createAlias(String alias) {
    return $CardTemplateTable(attachedDatabase, alias);
  }
}

class CardTemplateData extends DataClass
    implements Insertable<CardTemplateData> {
  final int id;
  final String? sku;
  final String path;
  final String template;
  final DateTime lastUpdated;
  const CardTemplateData(
      {required this.id,
      this.sku,
      required this.path,
      required this.template,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['path'] = Variable<String>(path);
    map['template'] = Variable<String>(template);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  CardTemplateCompanion toCompanion(bool nullToAbsent) {
    return CardTemplateCompanion(
      id: Value(id),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      path: Value(path),
      template: Value(template),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory CardTemplateData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardTemplateData(
      id: serializer.fromJson<int>(json['id']),
      sku: serializer.fromJson<String?>(json['sku']),
      path: serializer.fromJson<String>(json['path']),
      template: serializer.fromJson<String>(json['template']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sku': serializer.toJson<String?>(sku),
      'path': serializer.toJson<String>(path),
      'template': serializer.toJson<String>(template),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  CardTemplateData copyWith(
          {int? id,
          Value<String?> sku = const Value.absent(),
          String? path,
          String? template,
          DateTime? lastUpdated}) =>
      CardTemplateData(
        id: id ?? this.id,
        sku: sku.present ? sku.value : this.sku,
        path: path ?? this.path,
        template: template ?? this.template,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('CardTemplateData(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('path: $path, ')
          ..write('template: $template, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sku, path, template, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardTemplateData &&
          other.id == this.id &&
          other.sku == this.sku &&
          other.path == this.path &&
          other.template == this.template &&
          other.lastUpdated == this.lastUpdated);
}

class CardTemplateCompanion extends UpdateCompanion<CardTemplateData> {
  final Value<int> id;
  final Value<String?> sku;
  final Value<String> path;
  final Value<String> template;
  final Value<DateTime> lastUpdated;
  const CardTemplateCompanion({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    this.path = const Value.absent(),
    this.template = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  CardTemplateCompanion.insert({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    required String path,
    required String template,
    required DateTime lastUpdated,
  })  : path = Value(path),
        template = Value(template),
        lastUpdated = Value(lastUpdated);
  static Insertable<CardTemplateData> custom({
    Expression<int>? id,
    Expression<String>? sku,
    Expression<String>? path,
    Expression<String>? template,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sku != null) 'sku': sku,
      if (path != null) 'path': path,
      if (template != null) 'template': template,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  CardTemplateCompanion copyWith(
      {Value<int>? id,
      Value<String?>? sku,
      Value<String>? path,
      Value<String>? template,
      Value<DateTime>? lastUpdated}) {
    return CardTemplateCompanion(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      path: path ?? this.path,
      template: template ?? this.template,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (template.present) {
      map['template'] = Variable<String>(template.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardTemplateCompanion(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('path: $path, ')
          ..write('template: $template, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $AssemblyCategoryTable extends AssemblyCategory
    with TableInfo<$AssemblyCategoryTable, AssemblyCategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssemblyCategoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, sku, path, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assembly_category';
  @override
  VerificationContext validateIntegrity(
      Insertable<AssemblyCategoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssemblyCategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssemblyCategoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $AssemblyCategoryTable createAlias(String alias) {
    return $AssemblyCategoryTable(attachedDatabase, alias);
  }
}

class AssemblyCategoryData extends DataClass
    implements Insertable<AssemblyCategoryData> {
  final int id;
  final String? sku;
  final String path;
  final DateTime lastUpdated;
  const AssemblyCategoryData(
      {required this.id,
      this.sku,
      required this.path,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['path'] = Variable<String>(path);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  AssemblyCategoryCompanion toCompanion(bool nullToAbsent) {
    return AssemblyCategoryCompanion(
      id: Value(id),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      path: Value(path),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory AssemblyCategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssemblyCategoryData(
      id: serializer.fromJson<int>(json['id']),
      sku: serializer.fromJson<String?>(json['sku']),
      path: serializer.fromJson<String>(json['path']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sku': serializer.toJson<String?>(sku),
      'path': serializer.toJson<String>(path),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  AssemblyCategoryData copyWith(
          {int? id,
          Value<String?> sku = const Value.absent(),
          String? path,
          DateTime? lastUpdated}) =>
      AssemblyCategoryData(
        id: id ?? this.id,
        sku: sku.present ? sku.value : this.sku,
        path: path ?? this.path,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('AssemblyCategoryData(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('path: $path, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sku, path, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssemblyCategoryData &&
          other.id == this.id &&
          other.sku == this.sku &&
          other.path == this.path &&
          other.lastUpdated == this.lastUpdated);
}

class AssemblyCategoryCompanion extends UpdateCompanion<AssemblyCategoryData> {
  final Value<int> id;
  final Value<String?> sku;
  final Value<String> path;
  final Value<DateTime> lastUpdated;
  const AssemblyCategoryCompanion({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    this.path = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  AssemblyCategoryCompanion.insert({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    required String path,
    required DateTime lastUpdated,
  })  : path = Value(path),
        lastUpdated = Value(lastUpdated);
  static Insertable<AssemblyCategoryData> custom({
    Expression<int>? id,
    Expression<String>? sku,
    Expression<String>? path,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sku != null) 'sku': sku,
      if (path != null) 'path': path,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  AssemblyCategoryCompanion copyWith(
      {Value<int>? id,
      Value<String?>? sku,
      Value<String>? path,
      Value<DateTime>? lastUpdated}) {
    return AssemblyCategoryCompanion(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      path: path ?? this.path,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssemblyCategoryCompanion(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('path: $path, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $UserAppTable extends UserApp with TableInfo<$UserAppTable, UserAppData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserAppTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fbIdMeta = const VerificationMeta('fbId');
  @override
  late final GeneratedColumn<String> fbId = GeneratedColumn<String>(
      'fb_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, sku, fbId, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_app';
  @override
  VerificationContext validateIntegrity(Insertable<UserAppData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('fb_id')) {
      context.handle(
          _fbIdMeta, fbId.isAcceptableOrUnknown(data['fb_id']!, _fbIdMeta));
    } else if (isInserting) {
      context.missing(_fbIdMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserAppData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserAppData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      fbId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fb_id'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated']),
    );
  }

  @override
  $UserAppTable createAlias(String alias) {
    return $UserAppTable(attachedDatabase, alias);
  }
}

class UserAppData extends DataClass implements Insertable<UserAppData> {
  final int id;
  final String? sku;
  final String fbId;
  final DateTime? lastUpdated;
  const UserAppData(
      {required this.id, this.sku, required this.fbId, this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['fb_id'] = Variable<String>(fbId);
    if (!nullToAbsent || lastUpdated != null) {
      map['last_updated'] = Variable<DateTime>(lastUpdated);
    }
    return map;
  }

  UserAppCompanion toCompanion(bool nullToAbsent) {
    return UserAppCompanion(
      id: Value(id),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      fbId: Value(fbId),
      lastUpdated: lastUpdated == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdated),
    );
  }

  factory UserAppData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserAppData(
      id: serializer.fromJson<int>(json['id']),
      sku: serializer.fromJson<String?>(json['sku']),
      fbId: serializer.fromJson<String>(json['fbId']),
      lastUpdated: serializer.fromJson<DateTime?>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sku': serializer.toJson<String?>(sku),
      'fbId': serializer.toJson<String>(fbId),
      'lastUpdated': serializer.toJson<DateTime?>(lastUpdated),
    };
  }

  UserAppData copyWith(
          {int? id,
          Value<String?> sku = const Value.absent(),
          String? fbId,
          Value<DateTime?> lastUpdated = const Value.absent()}) =>
      UserAppData(
        id: id ?? this.id,
        sku: sku.present ? sku.value : this.sku,
        fbId: fbId ?? this.fbId,
        lastUpdated: lastUpdated.present ? lastUpdated.value : this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('UserAppData(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('fbId: $fbId, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sku, fbId, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAppData &&
          other.id == this.id &&
          other.sku == this.sku &&
          other.fbId == this.fbId &&
          other.lastUpdated == this.lastUpdated);
}

class UserAppCompanion extends UpdateCompanion<UserAppData> {
  final Value<int> id;
  final Value<String?> sku;
  final Value<String> fbId;
  final Value<DateTime?> lastUpdated;
  const UserAppCompanion({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    this.fbId = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  UserAppCompanion.insert({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    required String fbId,
    this.lastUpdated = const Value.absent(),
  }) : fbId = Value(fbId);
  static Insertable<UserAppData> custom({
    Expression<int>? id,
    Expression<String>? sku,
    Expression<String>? fbId,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sku != null) 'sku': sku,
      if (fbId != null) 'fb_id': fbId,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  UserAppCompanion copyWith(
      {Value<int>? id,
      Value<String?>? sku,
      Value<String>? fbId,
      Value<DateTime?>? lastUpdated}) {
    return UserAppCompanion(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      fbId: fbId ?? this.fbId,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (fbId.present) {
      map['fb_id'] = Variable<String>(fbId.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserAppCompanion(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('fbId: $fbId, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $AssemblyCategoryAssemblyTable extends AssemblyCategoryAssembly
    with
        TableInfo<$AssemblyCategoryAssemblyTable,
            AssemblyCategoryAssemblyData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssemblyCategoryAssemblyTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _assemblyIdMeta =
      const VerificationMeta('assemblyId');
  @override
  late final GeneratedColumn<int> assemblyId = GeneratedColumn<int>(
      'assembly_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES h_t_m_l_contents (id)'));
  static const VerificationMeta _assemblyCategoryIdMeta =
      const VerificationMeta('assemblyCategoryId');
  @override
  late final GeneratedColumn<int> assemblyCategoryId = GeneratedColumn<int>(
      'assembly_category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES assembly_category_assembly (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, assemblyId, assemblyCategoryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assembly_category_assembly';
  @override
  VerificationContext validateIntegrity(
      Insertable<AssemblyCategoryAssemblyData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('assembly_id')) {
      context.handle(
          _assemblyIdMeta,
          assemblyId.isAcceptableOrUnknown(
              data['assembly_id']!, _assemblyIdMeta));
    } else if (isInserting) {
      context.missing(_assemblyIdMeta);
    }
    if (data.containsKey('assembly_category_id')) {
      context.handle(
          _assemblyCategoryIdMeta,
          assemblyCategoryId.isAcceptableOrUnknown(
              data['assembly_category_id']!, _assemblyCategoryIdMeta));
    } else if (isInserting) {
      context.missing(_assemblyCategoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssemblyCategoryAssemblyData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssemblyCategoryAssemblyData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      assemblyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}assembly_id'])!,
      assemblyCategoryId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}assembly_category_id'])!,
    );
  }

  @override
  $AssemblyCategoryAssemblyTable createAlias(String alias) {
    return $AssemblyCategoryAssemblyTable(attachedDatabase, alias);
  }
}

class AssemblyCategoryAssemblyData extends DataClass
    implements Insertable<AssemblyCategoryAssemblyData> {
  final int id;
  final int assemblyId;
  final int assemblyCategoryId;
  const AssemblyCategoryAssemblyData(
      {required this.id,
      required this.assemblyId,
      required this.assemblyCategoryId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['assembly_id'] = Variable<int>(assemblyId);
    map['assembly_category_id'] = Variable<int>(assemblyCategoryId);
    return map;
  }

  AssemblyCategoryAssemblyCompanion toCompanion(bool nullToAbsent) {
    return AssemblyCategoryAssemblyCompanion(
      id: Value(id),
      assemblyId: Value(assemblyId),
      assemblyCategoryId: Value(assemblyCategoryId),
    );
  }

  factory AssemblyCategoryAssemblyData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssemblyCategoryAssemblyData(
      id: serializer.fromJson<int>(json['id']),
      assemblyId: serializer.fromJson<int>(json['assemblyId']),
      assemblyCategoryId: serializer.fromJson<int>(json['assemblyCategoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'assemblyId': serializer.toJson<int>(assemblyId),
      'assemblyCategoryId': serializer.toJson<int>(assemblyCategoryId),
    };
  }

  AssemblyCategoryAssemblyData copyWith(
          {int? id, int? assemblyId, int? assemblyCategoryId}) =>
      AssemblyCategoryAssemblyData(
        id: id ?? this.id,
        assemblyId: assemblyId ?? this.assemblyId,
        assemblyCategoryId: assemblyCategoryId ?? this.assemblyCategoryId,
      );
  @override
  String toString() {
    return (StringBuffer('AssemblyCategoryAssemblyData(')
          ..write('id: $id, ')
          ..write('assemblyId: $assemblyId, ')
          ..write('assemblyCategoryId: $assemblyCategoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, assemblyId, assemblyCategoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssemblyCategoryAssemblyData &&
          other.id == this.id &&
          other.assemblyId == this.assemblyId &&
          other.assemblyCategoryId == this.assemblyCategoryId);
}

class AssemblyCategoryAssemblyCompanion
    extends UpdateCompanion<AssemblyCategoryAssemblyData> {
  final Value<int> id;
  final Value<int> assemblyId;
  final Value<int> assemblyCategoryId;
  const AssemblyCategoryAssemblyCompanion({
    this.id = const Value.absent(),
    this.assemblyId = const Value.absent(),
    this.assemblyCategoryId = const Value.absent(),
  });
  AssemblyCategoryAssemblyCompanion.insert({
    this.id = const Value.absent(),
    required int assemblyId,
    required int assemblyCategoryId,
  })  : assemblyId = Value(assemblyId),
        assemblyCategoryId = Value(assemblyCategoryId);
  static Insertable<AssemblyCategoryAssemblyData> custom({
    Expression<int>? id,
    Expression<int>? assemblyId,
    Expression<int>? assemblyCategoryId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (assemblyId != null) 'assembly_id': assemblyId,
      if (assemblyCategoryId != null)
        'assembly_category_id': assemblyCategoryId,
    });
  }

  AssemblyCategoryAssemblyCompanion copyWith(
      {Value<int>? id,
      Value<int>? assemblyId,
      Value<int>? assemblyCategoryId}) {
    return AssemblyCategoryAssemblyCompanion(
      id: id ?? this.id,
      assemblyId: assemblyId ?? this.assemblyId,
      assemblyCategoryId: assemblyCategoryId ?? this.assemblyCategoryId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (assemblyId.present) {
      map['assembly_id'] = Variable<int>(assemblyId.value);
    }
    if (assemblyCategoryId.present) {
      map['assembly_category_id'] = Variable<int>(assemblyCategoryId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssemblyCategoryAssemblyCompanion(')
          ..write('id: $id, ')
          ..write('assemblyId: $assemblyId, ')
          ..write('assemblyCategoryId: $assemblyCategoryId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $GroupTable group = $GroupTable(this);
  late final $HTMLContentsTable hTMLContents = $HTMLContentsTable(this);
  late final $ReviseCardsTable reviseCards = $ReviseCardsTable(this);
  late final $ImagesTable images = $ImagesTable(this);
  late final $CoursesTable courses = $CoursesTable(this);
  late final $FileContentsTable fileContents = $FileContentsTable(this);
  late final $HTMLContentFilesTable hTMLContentFiles =
      $HTMLContentFilesTable(this);
  late final $TopicsTable topics = $TopicsTable(this);
  late final $CardTemplateTable cardTemplate = $CardTemplateTable(this);
  late final $AssemblyCategoryTable assemblyCategory =
      $AssemblyCategoryTable(this);
  late final $UserAppTable userApp = $UserAppTable(this);
  late final $AssemblyCategoryAssemblyTable assemblyCategoryAssembly =
      $AssemblyCategoryAssemblyTable(this);
  late final ImageDao imageDao = ImageDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        group,
        hTMLContents,
        reviseCards,
        images,
        courses,
        fileContents,
        hTMLContentFiles,
        topics,
        cardTemplate,
        assemblyCategory,
        userApp,
        assemblyCategoryAssembly
      ];
}
