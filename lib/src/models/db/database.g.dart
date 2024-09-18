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
  @override
  List<GeneratedColumn> get $columns => [id, title, path, tags, parentId];
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
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
    );
  }

  @override
  $GroupTable createAlias(String alias) {
    return $GroupTable(attachedDatabase, alias);
  }
}

class GroupData extends DataClass implements Insertable<GroupData> {
  final int id;
  final String title;
  final String? path;
  final String tags;
  final int? parentId;
  const GroupData(
      {required this.id,
      required this.title,
      this.path,
      required this.tags,
      this.parentId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    map['body'] = Variable<String>(tags);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    return map;
  }

  GroupCompanion toCompanion(bool nullToAbsent) {
    return GroupCompanion(
      id: Value(id),
      title: Value(title),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      tags: Value(tags),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
    );
  }

  factory GroupData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      path: serializer.fromJson<String?>(json['path']),
      tags: serializer.fromJson<String>(json['tags']),
      parentId: serializer.fromJson<int?>(json['parentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'path': serializer.toJson<String?>(path),
      'tags': serializer.toJson<String>(tags),
      'parentId': serializer.toJson<int?>(parentId),
    };
  }

  GroupData copyWith(
          {int? id,
          String? title,
          Value<String?> path = const Value.absent(),
          String? tags,
          Value<int?> parentId = const Value.absent()}) =>
      GroupData(
        id: id ?? this.id,
        title: title ?? this.title,
        path: path.present ? path.value : this.path,
        tags: tags ?? this.tags,
        parentId: parentId.present ? parentId.value : this.parentId,
      );
  @override
  String toString() {
    return (StringBuffer('GroupData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('path: $path, ')
          ..write('tags: $tags, ')
          ..write('parentId: $parentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, path, tags, parentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupData &&
          other.id == this.id &&
          other.title == this.title &&
          other.path == this.path &&
          other.tags == this.tags &&
          other.parentId == this.parentId);
}

class GroupCompanion extends UpdateCompanion<GroupData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> path;
  final Value<String> tags;
  final Value<int?> parentId;
  const GroupCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.path = const Value.absent(),
    this.tags = const Value.absent(),
    this.parentId = const Value.absent(),
  });
  GroupCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.path = const Value.absent(),
    required String tags,
    this.parentId = const Value.absent(),
  })  : title = Value(title),
        tags = Value(tags);
  static Insertable<GroupData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? path,
    Expression<String>? tags,
    Expression<int>? parentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (path != null) 'path': path,
      if (tags != null) 'body': tags,
      if (parentId != null) 'parent_id': parentId,
    });
  }

  GroupCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? path,
      Value<String>? tags,
      Value<int?>? parentId}) {
    return GroupCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      path: path ?? this.path,
      tags: tags ?? this.tags,
      parentId: parentId ?? this.parentId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('path: $path, ')
          ..write('tags: $tags, ')
          ..write('parentId: $parentId')
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
  @override
  List<GeneratedColumn> get $columns =>
      [id, recto, verso, isTemplated, cardTemplatedJson, isAssembly];
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
    );
  }

  @override
  $HTMLContentsTable createAlias(String alias) {
    return $HTMLContentsTable(attachedDatabase, alias);
  }
}

class HTMLContent extends DataClass implements Insertable<HTMLContent> {
  final int id;
  final String recto;
  final String verso;
  final bool isTemplated;
  final String cardTemplatedJson;
  final bool isAssembly;
  const HTMLContent(
      {required this.id,
      required this.recto,
      required this.verso,
      required this.isTemplated,
      required this.cardTemplatedJson,
      required this.isAssembly});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recto'] = Variable<String>(recto);
    map['verso'] = Variable<String>(verso);
    map['is_templated'] = Variable<bool>(isTemplated);
    map['card_templated_json'] = Variable<String>(cardTemplatedJson);
    map['is_assembly'] = Variable<bool>(isAssembly);
    return map;
  }

  HTMLContentsCompanion toCompanion(bool nullToAbsent) {
    return HTMLContentsCompanion(
      id: Value(id),
      recto: Value(recto),
      verso: Value(verso),
      isTemplated: Value(isTemplated),
      cardTemplatedJson: Value(cardTemplatedJson),
      isAssembly: Value(isAssembly),
    );
  }

  factory HTMLContent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HTMLContent(
      id: serializer.fromJson<int>(json['id']),
      recto: serializer.fromJson<String>(json['recto']),
      verso: serializer.fromJson<String>(json['verso']),
      isTemplated: serializer.fromJson<bool>(json['isTemplated']),
      cardTemplatedJson: serializer.fromJson<String>(json['cardTemplatedJson']),
      isAssembly: serializer.fromJson<bool>(json['isAssembly']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recto': serializer.toJson<String>(recto),
      'verso': serializer.toJson<String>(verso),
      'isTemplated': serializer.toJson<bool>(isTemplated),
      'cardTemplatedJson': serializer.toJson<String>(cardTemplatedJson),
      'isAssembly': serializer.toJson<bool>(isAssembly),
    };
  }

  HTMLContent copyWith(
          {int? id,
          String? recto,
          String? verso,
          bool? isTemplated,
          String? cardTemplatedJson,
          bool? isAssembly}) =>
      HTMLContent(
        id: id ?? this.id,
        recto: recto ?? this.recto,
        verso: verso ?? this.verso,
        isTemplated: isTemplated ?? this.isTemplated,
        cardTemplatedJson: cardTemplatedJson ?? this.cardTemplatedJson,
        isAssembly: isAssembly ?? this.isAssembly,
      );
  @override
  String toString() {
    return (StringBuffer('HTMLContent(')
          ..write('id: $id, ')
          ..write('recto: $recto, ')
          ..write('verso: $verso, ')
          ..write('isTemplated: $isTemplated, ')
          ..write('cardTemplatedJson: $cardTemplatedJson, ')
          ..write('isAssembly: $isAssembly')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, recto, verso, isTemplated, cardTemplatedJson, isAssembly);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HTMLContent &&
          other.id == this.id &&
          other.recto == this.recto &&
          other.verso == this.verso &&
          other.isTemplated == this.isTemplated &&
          other.cardTemplatedJson == this.cardTemplatedJson &&
          other.isAssembly == this.isAssembly);
}

class HTMLContentsCompanion extends UpdateCompanion<HTMLContent> {
  final Value<int> id;
  final Value<String> recto;
  final Value<String> verso;
  final Value<bool> isTemplated;
  final Value<String> cardTemplatedJson;
  final Value<bool> isAssembly;
  const HTMLContentsCompanion({
    this.id = const Value.absent(),
    this.recto = const Value.absent(),
    this.verso = const Value.absent(),
    this.isTemplated = const Value.absent(),
    this.cardTemplatedJson = const Value.absent(),
    this.isAssembly = const Value.absent(),
  });
  HTMLContentsCompanion.insert({
    this.id = const Value.absent(),
    this.recto = const Value.absent(),
    this.verso = const Value.absent(),
    this.isTemplated = const Value.absent(),
    this.cardTemplatedJson = const Value.absent(),
    this.isAssembly = const Value.absent(),
  });
  static Insertable<HTMLContent> custom({
    Expression<int>? id,
    Expression<String>? recto,
    Expression<String>? verso,
    Expression<bool>? isTemplated,
    Expression<String>? cardTemplatedJson,
    Expression<bool>? isAssembly,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recto != null) 'recto': recto,
      if (verso != null) 'verso': verso,
      if (isTemplated != null) 'is_templated': isTemplated,
      if (cardTemplatedJson != null) 'card_templated_json': cardTemplatedJson,
      if (isAssembly != null) 'is_assembly': isAssembly,
    });
  }

  HTMLContentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? recto,
      Value<String>? verso,
      Value<bool>? isTemplated,
      Value<String>? cardTemplatedJson,
      Value<bool>? isAssembly}) {
    return HTMLContentsCompanion(
      id: id ?? this.id,
      recto: recto ?? this.recto,
      verso: verso ?? this.verso,
      isTemplated: isTemplated ?? this.isTemplated,
      cardTemplatedJson: cardTemplatedJson ?? this.cardTemplatedJson,
      isAssembly: isAssembly ?? this.isAssembly,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HTMLContentsCompanion(')
          ..write('id: $id, ')
          ..write('recto: $recto, ')
          ..write('verso: $verso, ')
          ..write('isTemplated: $isTemplated, ')
          ..write('cardTemplatedJson: $cardTemplatedJson, ')
          ..write('isAssembly: $isAssembly')
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
  @override
  List<GeneratedColumn> get $columns => [
        id,
        groupId,
        htmlContent,
        displayerType,
        tags,
        nextRevisionDateMultiplicator,
        nextRevisionDate,
        path,
        mnemotechnicHint
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
  final int groupId;
  final int htmlContent;
  final CardDisplayerType displayerType;
  final String tags;
  final double nextRevisionDateMultiplicator;
  final DateTime? nextRevisionDate;
  final String? path;
  final String? mnemotechnicHint;
  const ReviseCard(
      {required this.id,
      required this.groupId,
      required this.htmlContent,
      required this.displayerType,
      required this.tags,
      required this.nextRevisionDateMultiplicator,
      this.nextRevisionDate,
      this.path,
      this.mnemotechnicHint});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
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
    return map;
  }

  ReviseCardsCompanion toCompanion(bool nullToAbsent) {
    return ReviseCardsCompanion(
      id: Value(id),
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
    );
  }

  factory ReviseCard.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviseCard(
      id: serializer.fromJson<int>(json['id']),
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
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
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
    };
  }

  ReviseCard copyWith(
          {int? id,
          int? groupId,
          int? htmlContent,
          CardDisplayerType? displayerType,
          String? tags,
          double? nextRevisionDateMultiplicator,
          Value<DateTime?> nextRevisionDate = const Value.absent(),
          Value<String?> path = const Value.absent(),
          Value<String?> mnemotechnicHint = const Value.absent()}) =>
      ReviseCard(
        id: id ?? this.id,
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
      );
  @override
  String toString() {
    return (StringBuffer('ReviseCard(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('htmlContent: $htmlContent, ')
          ..write('displayerType: $displayerType, ')
          ..write('tags: $tags, ')
          ..write(
              'nextRevisionDateMultiplicator: $nextRevisionDateMultiplicator, ')
          ..write('nextRevisionDate: $nextRevisionDate, ')
          ..write('path: $path, ')
          ..write('mnemotechnicHint: $mnemotechnicHint')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, htmlContent, displayerType, tags,
      nextRevisionDateMultiplicator, nextRevisionDate, path, mnemotechnicHint);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviseCard &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.htmlContent == this.htmlContent &&
          other.displayerType == this.displayerType &&
          other.tags == this.tags &&
          other.nextRevisionDateMultiplicator ==
              this.nextRevisionDateMultiplicator &&
          other.nextRevisionDate == this.nextRevisionDate &&
          other.path == this.path &&
          other.mnemotechnicHint == this.mnemotechnicHint);
}

class ReviseCardsCompanion extends UpdateCompanion<ReviseCard> {
  final Value<int> id;
  final Value<int> groupId;
  final Value<int> htmlContent;
  final Value<CardDisplayerType> displayerType;
  final Value<String> tags;
  final Value<double> nextRevisionDateMultiplicator;
  final Value<DateTime?> nextRevisionDate;
  final Value<String?> path;
  final Value<String?> mnemotechnicHint;
  const ReviseCardsCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.htmlContent = const Value.absent(),
    this.displayerType = const Value.absent(),
    this.tags = const Value.absent(),
    this.nextRevisionDateMultiplicator = const Value.absent(),
    this.nextRevisionDate = const Value.absent(),
    this.path = const Value.absent(),
    this.mnemotechnicHint = const Value.absent(),
  });
  ReviseCardsCompanion.insert({
    this.id = const Value.absent(),
    required int groupId,
    required int htmlContent,
    required CardDisplayerType displayerType,
    required String tags,
    required double nextRevisionDateMultiplicator,
    this.nextRevisionDate = const Value.absent(),
    this.path = const Value.absent(),
    this.mnemotechnicHint = const Value.absent(),
  })  : groupId = Value(groupId),
        htmlContent = Value(htmlContent),
        displayerType = Value(displayerType),
        tags = Value(tags),
        nextRevisionDateMultiplicator = Value(nextRevisionDateMultiplicator);
  static Insertable<ReviseCard> custom({
    Expression<int>? id,
    Expression<int>? groupId,
    Expression<int>? htmlContent,
    Expression<int>? displayerType,
    Expression<String>? tags,
    Expression<double>? nextRevisionDateMultiplicator,
    Expression<DateTime>? nextRevisionDate,
    Expression<String>? path,
    Expression<String>? mnemotechnicHint,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (htmlContent != null) 'html_content': htmlContent,
      if (displayerType != null) 'displayer_type': displayerType,
      if (tags != null) 'body': tags,
      if (nextRevisionDateMultiplicator != null)
        'next_revision_date_multiplicator': nextRevisionDateMultiplicator,
      if (nextRevisionDate != null) 'next_revision_date': nextRevisionDate,
      if (path != null) 'path': path,
      if (mnemotechnicHint != null) 'mnemotechnic_hint': mnemotechnicHint,
    });
  }

  ReviseCardsCompanion copyWith(
      {Value<int>? id,
      Value<int>? groupId,
      Value<int>? htmlContent,
      Value<CardDisplayerType>? displayerType,
      Value<String>? tags,
      Value<double>? nextRevisionDateMultiplicator,
      Value<DateTime?>? nextRevisionDate,
      Value<String?>? path,
      Value<String?>? mnemotechnicHint}) {
    return ReviseCardsCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      htmlContent: htmlContent ?? this.htmlContent,
      displayerType: displayerType ?? this.displayerType,
      tags: tags ?? this.tags,
      nextRevisionDateMultiplicator:
          nextRevisionDateMultiplicator ?? this.nextRevisionDateMultiplicator,
      nextRevisionDate: nextRevisionDate ?? this.nextRevisionDate,
      path: path ?? this.path,
      mnemotechnicHint: mnemotechnicHint ?? this.mnemotechnicHint,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviseCardsCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('htmlContent: $htmlContent, ')
          ..write('displayerType: $displayerType, ')
          ..write('tags: $tags, ')
          ..write(
              'nextRevisionDateMultiplicator: $nextRevisionDateMultiplicator, ')
          ..write('nextRevisionDate: $nextRevisionDate, ')
          ..write('path: $path, ')
          ..write('mnemotechnicHint: $mnemotechnicHint')
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
      'sku', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  @override
  List<GeneratedColumn> get $columns => [id, sku, imageUrl, title, description];
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
    } else if (isInserting) {
      context.missing(_skuMeta);
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
          .read(DriftSqlType.string, data['${effectivePrefix}sku'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $CoursesTable createAlias(String alias) {
    return $CoursesTable(attachedDatabase, alias);
  }
}

class Course extends DataClass implements Insertable<Course> {
  final int id;
  final String sku;
  final String imageUrl;
  final String title;
  final String description;
  const Course(
      {required this.id,
      required this.sku,
      required this.imageUrl,
      required this.title,
      required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sku'] = Variable<String>(sku);
    map['image_url'] = Variable<String>(imageUrl);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    return map;
  }

  CoursesCompanion toCompanion(bool nullToAbsent) {
    return CoursesCompanion(
      id: Value(id),
      sku: Value(sku),
      imageUrl: Value(imageUrl),
      title: Value(title),
      description: Value(description),
    );
  }

  factory Course.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Course(
      id: serializer.fromJson<int>(json['id']),
      sku: serializer.fromJson<String>(json['sku']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sku': serializer.toJson<String>(sku),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
    };
  }

  Course copyWith(
          {int? id,
          String? sku,
          String? imageUrl,
          String? title,
          String? description}) =>
      Course(
        id: id ?? this.id,
        sku: sku ?? this.sku,
        imageUrl: imageUrl ?? this.imageUrl,
        title: title ?? this.title,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('Course(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('title: $title, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sku, imageUrl, title, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Course &&
          other.id == this.id &&
          other.sku == this.sku &&
          other.imageUrl == this.imageUrl &&
          other.title == this.title &&
          other.description == this.description);
}

class CoursesCompanion extends UpdateCompanion<Course> {
  final Value<int> id;
  final Value<String> sku;
  final Value<String> imageUrl;
  final Value<String> title;
  final Value<String> description;
  const CoursesCompanion({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
  });
  CoursesCompanion.insert({
    this.id = const Value.absent(),
    required String sku,
    required String imageUrl,
    required String title,
    required String description,
  })  : sku = Value(sku),
        imageUrl = Value(imageUrl),
        title = Value(title),
        description = Value(description);
  static Insertable<Course> custom({
    Expression<int>? id,
    Expression<String>? sku,
    Expression<String>? imageUrl,
    Expression<String>? title,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sku != null) 'sku': sku,
      if (imageUrl != null) 'image_url': imageUrl,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
    });
  }

  CoursesCompanion copyWith(
      {Value<int>? id,
      Value<String>? sku,
      Value<String>? imageUrl,
      Value<String>? title,
      Value<String>? description}) {
    return CoursesCompanion(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCompanion(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('title: $title, ')
          ..write('description: $description')
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  @override
  List<GeneratedColumn> get $columns => [id, name, format, content];
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
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
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
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      format: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}format'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}content'])!,
    );
  }

  @override
  $FileContentsTable createAlias(String alias) {
    return $FileContentsTable(attachedDatabase, alias);
  }
}

class FileContent extends DataClass implements Insertable<FileContent> {
  final int id;
  final String name;
  final String format;
  final Uint8List content;
  const FileContent(
      {required this.id,
      required this.name,
      required this.format,
      required this.content});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['format'] = Variable<String>(format);
    map['content'] = Variable<Uint8List>(content);
    return map;
  }

  FileContentsCompanion toCompanion(bool nullToAbsent) {
    return FileContentsCompanion(
      id: Value(id),
      name: Value(name),
      format: Value(format),
      content: Value(content),
    );
  }

  factory FileContent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FileContent(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      format: serializer.fromJson<String>(json['format']),
      content: serializer.fromJson<Uint8List>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'format': serializer.toJson<String>(format),
      'content': serializer.toJson<Uint8List>(content),
    };
  }

  FileContent copyWith(
          {int? id, String? name, String? format, Uint8List? content}) =>
      FileContent(
        id: id ?? this.id,
        name: name ?? this.name,
        format: format ?? this.format,
        content: content ?? this.content,
      );
  @override
  String toString() {
    return (StringBuffer('FileContent(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('format: $format, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, format, $driftBlobEquality.hash(content));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FileContent &&
          other.id == this.id &&
          other.name == this.name &&
          other.format == this.format &&
          $driftBlobEquality.equals(other.content, this.content));
}

class FileContentsCompanion extends UpdateCompanion<FileContent> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> format;
  final Value<Uint8List> content;
  const FileContentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.format = const Value.absent(),
    this.content = const Value.absent(),
  });
  FileContentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String format,
    required Uint8List content,
  })  : name = Value(name),
        format = Value(format),
        content = Value(content);
  static Insertable<FileContent> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? format,
    Expression<Uint8List>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (format != null) 'format': format,
      if (content != null) 'content': content,
    });
  }

  FileContentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? format,
      Value<Uint8List>? content}) {
    return FileContentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      format: format ?? this.format,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (content.present) {
      map['content'] = Variable<Uint8List>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FileContentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('format: $format, ')
          ..write('content: $content')
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
  @override
  List<GeneratedColumn> get $columns => [id, fileId, htmlContentParentId];
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
  const HTMLContentFile(
      {required this.id,
      required this.fileId,
      required this.htmlContentParentId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['file_id'] = Variable<int>(fileId);
    map['html_content_parent_id'] = Variable<int>(htmlContentParentId);
    return map;
  }

  HTMLContentFilesCompanion toCompanion(bool nullToAbsent) {
    return HTMLContentFilesCompanion(
      id: Value(id),
      fileId: Value(fileId),
      htmlContentParentId: Value(htmlContentParentId),
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
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fileId': serializer.toJson<int>(fileId),
      'htmlContentParentId': serializer.toJson<int>(htmlContentParentId),
    };
  }

  HTMLContentFile copyWith({int? id, int? fileId, int? htmlContentParentId}) =>
      HTMLContentFile(
        id: id ?? this.id,
        fileId: fileId ?? this.fileId,
        htmlContentParentId: htmlContentParentId ?? this.htmlContentParentId,
      );
  @override
  String toString() {
    return (StringBuffer('HTMLContentFile(')
          ..write('id: $id, ')
          ..write('fileId: $fileId, ')
          ..write('htmlContentParentId: $htmlContentParentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fileId, htmlContentParentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HTMLContentFile &&
          other.id == this.id &&
          other.fileId == this.fileId &&
          other.htmlContentParentId == this.htmlContentParentId);
}

class HTMLContentFilesCompanion extends UpdateCompanion<HTMLContentFile> {
  final Value<int> id;
  final Value<int> fileId;
  final Value<int> htmlContentParentId;
  const HTMLContentFilesCompanion({
    this.id = const Value.absent(),
    this.fileId = const Value.absent(),
    this.htmlContentParentId = const Value.absent(),
  });
  HTMLContentFilesCompanion.insert({
    this.id = const Value.absent(),
    required int fileId,
    required int htmlContentParentId,
  })  : fileId = Value(fileId),
        htmlContentParentId = Value(htmlContentParentId);
  static Insertable<HTMLContentFile> custom({
    Expression<int>? id,
    Expression<int>? fileId,
    Expression<int>? htmlContentParentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileId != null) 'file_id': fileId,
      if (htmlContentParentId != null)
        'html_content_parent_id': htmlContentParentId,
    });
  }

  HTMLContentFilesCompanion copyWith(
      {Value<int>? id, Value<int>? fileId, Value<int>? htmlContentParentId}) {
    return HTMLContentFilesCompanion(
      id: id ?? this.id,
      fileId: fileId ?? this.fileId,
      htmlContentParentId: htmlContentParentId ?? this.htmlContentParentId,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HTMLContentFilesCompanion(')
          ..write('id: $id, ')
          ..write('fileId: $fileId, ')
          ..write('htmlContentParentId: $htmlContentParentId')
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
  @override
  List<GeneratedColumn> get $columns => [
        id,
        path,
        title,
        parentId,
        parentCourseId,
        groupId,
        fileId,
        htmlContentId
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
    );
  }

  @override
  $TopicsTable createAlias(String alias) {
    return $TopicsTable(attachedDatabase, alias);
  }
}

class Topic extends DataClass implements Insertable<Topic> {
  final int id;
  final String? path;
  final String title;
  final int? parentId;
  final int parentCourseId;
  final int? groupId;
  final int? fileId;
  final int? htmlContentId;
  const Topic(
      {required this.id,
      this.path,
      required this.title,
      this.parentId,
      required this.parentCourseId,
      this.groupId,
      this.fileId,
      this.htmlContentId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
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
    return map;
  }

  TopicsCompanion toCompanion(bool nullToAbsent) {
    return TopicsCompanion(
      id: Value(id),
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
    );
  }

  factory Topic.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Topic(
      id: serializer.fromJson<int>(json['id']),
      path: serializer.fromJson<String?>(json['path']),
      title: serializer.fromJson<String>(json['title']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      parentCourseId: serializer.fromJson<int>(json['parentCourseId']),
      groupId: serializer.fromJson<int?>(json['groupId']),
      fileId: serializer.fromJson<int?>(json['fileId']),
      htmlContentId: serializer.fromJson<int?>(json['htmlContentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'path': serializer.toJson<String?>(path),
      'title': serializer.toJson<String>(title),
      'parentId': serializer.toJson<int?>(parentId),
      'parentCourseId': serializer.toJson<int>(parentCourseId),
      'groupId': serializer.toJson<int?>(groupId),
      'fileId': serializer.toJson<int?>(fileId),
      'htmlContentId': serializer.toJson<int?>(htmlContentId),
    };
  }

  Topic copyWith(
          {int? id,
          Value<String?> path = const Value.absent(),
          String? title,
          Value<int?> parentId = const Value.absent(),
          int? parentCourseId,
          Value<int?> groupId = const Value.absent(),
          Value<int?> fileId = const Value.absent(),
          Value<int?> htmlContentId = const Value.absent()}) =>
      Topic(
        id: id ?? this.id,
        path: path.present ? path.value : this.path,
        title: title ?? this.title,
        parentId: parentId.present ? parentId.value : this.parentId,
        parentCourseId: parentCourseId ?? this.parentCourseId,
        groupId: groupId.present ? groupId.value : this.groupId,
        fileId: fileId.present ? fileId.value : this.fileId,
        htmlContentId:
            htmlContentId.present ? htmlContentId.value : this.htmlContentId,
      );
  @override
  String toString() {
    return (StringBuffer('Topic(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('title: $title, ')
          ..write('parentId: $parentId, ')
          ..write('parentCourseId: $parentCourseId, ')
          ..write('groupId: $groupId, ')
          ..write('fileId: $fileId, ')
          ..write('htmlContentId: $htmlContentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, path, title, parentId, parentCourseId,
      groupId, fileId, htmlContentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Topic &&
          other.id == this.id &&
          other.path == this.path &&
          other.title == this.title &&
          other.parentId == this.parentId &&
          other.parentCourseId == this.parentCourseId &&
          other.groupId == this.groupId &&
          other.fileId == this.fileId &&
          other.htmlContentId == this.htmlContentId);
}

class TopicsCompanion extends UpdateCompanion<Topic> {
  final Value<int> id;
  final Value<String?> path;
  final Value<String> title;
  final Value<int?> parentId;
  final Value<int> parentCourseId;
  final Value<int?> groupId;
  final Value<int?> fileId;
  final Value<int?> htmlContentId;
  const TopicsCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.title = const Value.absent(),
    this.parentId = const Value.absent(),
    this.parentCourseId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.fileId = const Value.absent(),
    this.htmlContentId = const Value.absent(),
  });
  TopicsCompanion.insert({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    required String title,
    this.parentId = const Value.absent(),
    required int parentCourseId,
    this.groupId = const Value.absent(),
    this.fileId = const Value.absent(),
    this.htmlContentId = const Value.absent(),
  })  : title = Value(title),
        parentCourseId = Value(parentCourseId);
  static Insertable<Topic> custom({
    Expression<int>? id,
    Expression<String>? path,
    Expression<String>? title,
    Expression<int>? parentId,
    Expression<int>? parentCourseId,
    Expression<int>? groupId,
    Expression<int>? fileId,
    Expression<int>? htmlContentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (path != null) 'path': path,
      if (title != null) 'title': title,
      if (parentId != null) 'parent_id': parentId,
      if (parentCourseId != null) 'parent_course_id': parentCourseId,
      if (groupId != null) 'group_id': groupId,
      if (fileId != null) 'file_id': fileId,
      if (htmlContentId != null) 'html_content_id': htmlContentId,
    });
  }

  TopicsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? path,
      Value<String>? title,
      Value<int?>? parentId,
      Value<int>? parentCourseId,
      Value<int?>? groupId,
      Value<int?>? fileId,
      Value<int?>? htmlContentId}) {
    return TopicsCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
      title: title ?? this.title,
      parentId: parentId ?? this.parentId,
      parentCourseId: parentCourseId ?? this.parentCourseId,
      groupId: groupId ?? this.groupId,
      fileId: fileId ?? this.fileId,
      htmlContentId: htmlContentId ?? this.htmlContentId,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicsCompanion(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('title: $title, ')
          ..write('parentId: $parentId, ')
          ..write('parentCourseId: $parentCourseId, ')
          ..write('groupId: $groupId, ')
          ..write('fileId: $fileId, ')
          ..write('htmlContentId: $htmlContentId')
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
      'sku', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  @override
  List<GeneratedColumn> get $columns => [id, sku, path, template];
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
    } else if (isInserting) {
      context.missing(_skuMeta);
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
          .read(DriftSqlType.string, data['${effectivePrefix}sku'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      template: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}template'])!,
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
  final String sku;
  final String path;
  final String template;
  const CardTemplateData(
      {required this.id,
      required this.sku,
      required this.path,
      required this.template});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sku'] = Variable<String>(sku);
    map['path'] = Variable<String>(path);
    map['template'] = Variable<String>(template);
    return map;
  }

  CardTemplateCompanion toCompanion(bool nullToAbsent) {
    return CardTemplateCompanion(
      id: Value(id),
      sku: Value(sku),
      path: Value(path),
      template: Value(template),
    );
  }

  factory CardTemplateData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardTemplateData(
      id: serializer.fromJson<int>(json['id']),
      sku: serializer.fromJson<String>(json['sku']),
      path: serializer.fromJson<String>(json['path']),
      template: serializer.fromJson<String>(json['template']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sku': serializer.toJson<String>(sku),
      'path': serializer.toJson<String>(path),
      'template': serializer.toJson<String>(template),
    };
  }

  CardTemplateData copyWith(
          {int? id, String? sku, String? path, String? template}) =>
      CardTemplateData(
        id: id ?? this.id,
        sku: sku ?? this.sku,
        path: path ?? this.path,
        template: template ?? this.template,
      );
  @override
  String toString() {
    return (StringBuffer('CardTemplateData(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('path: $path, ')
          ..write('template: $template')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sku, path, template);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardTemplateData &&
          other.id == this.id &&
          other.sku == this.sku &&
          other.path == this.path &&
          other.template == this.template);
}

class CardTemplateCompanion extends UpdateCompanion<CardTemplateData> {
  final Value<int> id;
  final Value<String> sku;
  final Value<String> path;
  final Value<String> template;
  const CardTemplateCompanion({
    this.id = const Value.absent(),
    this.sku = const Value.absent(),
    this.path = const Value.absent(),
    this.template = const Value.absent(),
  });
  CardTemplateCompanion.insert({
    this.id = const Value.absent(),
    required String sku,
    required String path,
    required String template,
  })  : sku = Value(sku),
        path = Value(path),
        template = Value(template);
  static Insertable<CardTemplateData> custom({
    Expression<int>? id,
    Expression<String>? sku,
    Expression<String>? path,
    Expression<String>? template,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sku != null) 'sku': sku,
      if (path != null) 'path': path,
      if (template != null) 'template': template,
    });
  }

  CardTemplateCompanion copyWith(
      {Value<int>? id,
      Value<String>? sku,
      Value<String>? path,
      Value<String>? template}) {
    return CardTemplateCompanion(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      path: path ?? this.path,
      template: template ?? this.template,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardTemplateCompanion(')
          ..write('id: $id, ')
          ..write('sku: $sku, ')
          ..write('path: $path, ')
          ..write('template: $template')
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
  static const VerificationMeta _categoryNameMeta =
      const VerificationMeta('categoryName');
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
      'category_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _templateIdMeta =
      const VerificationMeta('templateId');
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
      'template_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES card_template (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, categoryName, templateId];
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
    if (data.containsKey('category_name')) {
      context.handle(
          _categoryNameMeta,
          categoryName.isAcceptableOrUnknown(
              data['category_name']!, _categoryNameMeta));
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
          _templateIdMeta,
          templateId.isAcceptableOrUnknown(
              data['template_id']!, _templateIdMeta));
    } else if (isInserting) {
      context.missing(_templateIdMeta);
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
      categoryName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_name'])!,
      templateId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}template_id'])!,
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
  final String categoryName;
  final int templateId;
  const AssemblyCategoryData(
      {required this.id, required this.categoryName, required this.templateId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_name'] = Variable<String>(categoryName);
    map['template_id'] = Variable<int>(templateId);
    return map;
  }

  AssemblyCategoryCompanion toCompanion(bool nullToAbsent) {
    return AssemblyCategoryCompanion(
      id: Value(id),
      categoryName: Value(categoryName),
      templateId: Value(templateId),
    );
  }

  factory AssemblyCategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssemblyCategoryData(
      id: serializer.fromJson<int>(json['id']),
      categoryName: serializer.fromJson<String>(json['categoryName']),
      templateId: serializer.fromJson<int>(json['templateId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryName': serializer.toJson<String>(categoryName),
      'templateId': serializer.toJson<int>(templateId),
    };
  }

  AssemblyCategoryData copyWith(
          {int? id, String? categoryName, int? templateId}) =>
      AssemblyCategoryData(
        id: id ?? this.id,
        categoryName: categoryName ?? this.categoryName,
        templateId: templateId ?? this.templateId,
      );
  @override
  String toString() {
    return (StringBuffer('AssemblyCategoryData(')
          ..write('id: $id, ')
          ..write('categoryName: $categoryName, ')
          ..write('templateId: $templateId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, categoryName, templateId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssemblyCategoryData &&
          other.id == this.id &&
          other.categoryName == this.categoryName &&
          other.templateId == this.templateId);
}

class AssemblyCategoryCompanion extends UpdateCompanion<AssemblyCategoryData> {
  final Value<int> id;
  final Value<String> categoryName;
  final Value<int> templateId;
  const AssemblyCategoryCompanion({
    this.id = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.templateId = const Value.absent(),
  });
  AssemblyCategoryCompanion.insert({
    this.id = const Value.absent(),
    required String categoryName,
    required int templateId,
  })  : categoryName = Value(categoryName),
        templateId = Value(templateId);
  static Insertable<AssemblyCategoryData> custom({
    Expression<int>? id,
    Expression<String>? categoryName,
    Expression<int>? templateId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryName != null) 'category_name': categoryName,
      if (templateId != null) 'template_id': templateId,
    });
  }

  AssemblyCategoryCompanion copyWith(
      {Value<int>? id, Value<String>? categoryName, Value<int>? templateId}) {
    return AssemblyCategoryCompanion(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      templateId: templateId ?? this.templateId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssemblyCategoryCompanion(')
          ..write('id: $id, ')
          ..write('categoryName: $categoryName, ')
          ..write('templateId: $templateId')
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
        assemblyCategory
      ];
}
