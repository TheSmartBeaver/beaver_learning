// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _generatedTextMeta =
      const VerificationMeta('generatedText');
  @override
  late final GeneratedColumn<String> generatedText = GeneratedColumn<String>(
      'generated_text', aliasedName, true,
      generatedAs: GeneratedAs(
          title + const Constant(' (') + content + const Constant(')'), false),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, tags, generatedText];
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
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('body')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['body']!, _tagsMeta));
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    if (data.containsKey('generated_text')) {
      context.handle(
          _generatedTextMeta,
          generatedText.isAcceptableOrUnknown(
              data['generated_text']!, _generatedTextMeta));
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
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      generatedText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}generated_text']),
    );
  }

  @override
  $ReviseCardsTable createAlias(String alias) {
    return $ReviseCardsTable(attachedDatabase, alias);
  }
}

class ReviseCard extends DataClass implements Insertable<ReviseCard> {
  final int id;
  final String title;
  final String? content;
  final String tags;
  final String? generatedText;
  const ReviseCard(
      {required this.id,
      required this.title,
      this.content,
      required this.tags,
      this.generatedText});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    map['body'] = Variable<String>(tags);
    return map;
  }

  ReviseCardsCompanion toCompanion(bool nullToAbsent) {
    return ReviseCardsCompanion(
      id: Value(id),
      title: Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      tags: Value(tags),
    );
  }

  factory ReviseCard.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviseCard(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String?>(json['content']),
      tags: serializer.fromJson<String>(json['tags']),
      generatedText: serializer.fromJson<String?>(json['generatedText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String?>(content),
      'tags': serializer.toJson<String>(tags),
      'generatedText': serializer.toJson<String?>(generatedText),
    };
  }

  ReviseCard copyWith(
          {int? id,
          String? title,
          Value<String?> content = const Value.absent(),
          String? tags,
          Value<String?> generatedText = const Value.absent()}) =>
      ReviseCard(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content.present ? content.value : this.content,
        tags: tags ?? this.tags,
        generatedText:
            generatedText.present ? generatedText.value : this.generatedText,
      );
  @override
  String toString() {
    return (StringBuffer('ReviseCard(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('tags: $tags, ')
          ..write('generatedText: $generatedText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, content, tags, generatedText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviseCard &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.tags == this.tags &&
          other.generatedText == this.generatedText);
}

class ReviseCardsCompanion extends UpdateCompanion<ReviseCard> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> content;
  final Value<String> tags;
  const ReviseCardsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.tags = const Value.absent(),
  });
  ReviseCardsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.content = const Value.absent(),
    required String tags,
  })  : title = Value(title),
        tags = Value(tags);
  static Insertable<ReviseCard> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? tags,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (tags != null) 'body': tags,
    });
  }

  ReviseCardsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? content,
      Value<String>? tags}) {
    return ReviseCardsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      tags: tags ?? this.tags,
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
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (tags.present) {
      map['body'] = Variable<String>(tags.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviseCardsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $ReviseCardsTable reviseCards = $ReviseCardsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [reviseCards];
}
