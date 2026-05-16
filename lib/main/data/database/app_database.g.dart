// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ChatMessagesTable extends ChatMessages
    with TableInfo<$ChatMessagesTable, ChatMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta =
      const VerificationMeta('localId');
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
      'local_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _jsonDataMeta =
      const VerificationMeta('jsonData');
  @override
  late final GeneratedColumn<String> jsonData = GeneratedColumn<String>(
      'json_data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<String> timestamp = GeneratedColumn<String>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [localId, jsonData, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_messages';
  @override
  VerificationContext validateIntegrity(Insertable<ChatMessage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    }
    if (data.containsKey('json_data')) {
      context.handle(_jsonDataMeta,
          jsonData.isAcceptableOrUnknown(data['json_data']!, _jsonDataMeta));
    } else if (isInserting) {
      context.missing(_jsonDataMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  ChatMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessage(
      localId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}local_id'])!,
      jsonData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}json_data'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $ChatMessagesTable createAlias(String alias) {
    return $ChatMessagesTable(attachedDatabase, alias);
  }
}

class ChatMessage extends DataClass implements Insertable<ChatMessage> {
  final int localId;
  final String jsonData;
  final String timestamp;
  const ChatMessage(
      {required this.localId, required this.jsonData, required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['json_data'] = Variable<String>(jsonData);
    map['timestamp'] = Variable<String>(timestamp);
    return map;
  }

  ChatMessagesCompanion toCompanion(bool nullToAbsent) {
    return ChatMessagesCompanion(
      localId: Value(localId),
      jsonData: Value(jsonData),
      timestamp: Value(timestamp),
    );
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessage(
      localId: serializer.fromJson<int>(json['localId']),
      jsonData: serializer.fromJson<String>(json['jsonData']),
      timestamp: serializer.fromJson<String>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'jsonData': serializer.toJson<String>(jsonData),
      'timestamp': serializer.toJson<String>(timestamp),
    };
  }

  ChatMessage copyWith({int? localId, String? jsonData, String? timestamp}) =>
      ChatMessage(
        localId: localId ?? this.localId,
        jsonData: jsonData ?? this.jsonData,
        timestamp: timestamp ?? this.timestamp,
      );
  ChatMessage copyWithCompanion(ChatMessagesCompanion data) {
    return ChatMessage(
      localId: data.localId.present ? data.localId.value : this.localId,
      jsonData: data.jsonData.present ? data.jsonData.value : this.jsonData,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessage(')
          ..write('localId: $localId, ')
          ..write('jsonData: $jsonData, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(localId, jsonData, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessage &&
          other.localId == this.localId &&
          other.jsonData == this.jsonData &&
          other.timestamp == this.timestamp);
}

class ChatMessagesCompanion extends UpdateCompanion<ChatMessage> {
  final Value<int> localId;
  final Value<String> jsonData;
  final Value<String> timestamp;
  const ChatMessagesCompanion({
    this.localId = const Value.absent(),
    this.jsonData = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  ChatMessagesCompanion.insert({
    this.localId = const Value.absent(),
    required String jsonData,
    required String timestamp,
  })  : jsonData = Value(jsonData),
        timestamp = Value(timestamp);
  static Insertable<ChatMessage> custom({
    Expression<int>? localId,
    Expression<String>? jsonData,
    Expression<String>? timestamp,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (jsonData != null) 'json_data': jsonData,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  ChatMessagesCompanion copyWith(
      {Value<int>? localId,
      Value<String>? jsonData,
      Value<String>? timestamp}) {
    return ChatMessagesCompanion(
      localId: localId ?? this.localId,
      jsonData: jsonData ?? this.jsonData,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (jsonData.present) {
      map['json_data'] = Variable<String>(jsonData.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<String>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesCompanion(')
          ..write('localId: $localId, ')
          ..write('jsonData: $jsonData, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $PetTableTable extends PetTable
    with TableInfo<$PetTableTable, PetTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _jsonDataMeta =
      const VerificationMeta('jsonData');
  @override
  late final GeneratedColumn<String> jsonData = GeneratedColumn<String>(
      'json_data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, jsonData];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pet_table';
  @override
  VerificationContext validateIntegrity(Insertable<PetTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('json_data')) {
      context.handle(_jsonDataMeta,
          jsonData.isAcceptableOrUnknown(data['json_data']!, _jsonDataMeta));
    } else if (isInserting) {
      context.missing(_jsonDataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PetTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PetTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      jsonData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}json_data'])!,
    );
  }

  @override
  $PetTableTable createAlias(String alias) {
    return $PetTableTable(attachedDatabase, alias);
  }
}

class PetTableData extends DataClass implements Insertable<PetTableData> {
  final String id;
  final String jsonData;
  const PetTableData({required this.id, required this.jsonData});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['json_data'] = Variable<String>(jsonData);
    return map;
  }

  PetTableCompanion toCompanion(bool nullToAbsent) {
    return PetTableCompanion(
      id: Value(id),
      jsonData: Value(jsonData),
    );
  }

  factory PetTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PetTableData(
      id: serializer.fromJson<String>(json['id']),
      jsonData: serializer.fromJson<String>(json['jsonData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'jsonData': serializer.toJson<String>(jsonData),
    };
  }

  PetTableData copyWith({String? id, String? jsonData}) => PetTableData(
        id: id ?? this.id,
        jsonData: jsonData ?? this.jsonData,
      );
  PetTableData copyWithCompanion(PetTableCompanion data) {
    return PetTableData(
      id: data.id.present ? data.id.value : this.id,
      jsonData: data.jsonData.present ? data.jsonData.value : this.jsonData,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PetTableData(')
          ..write('id: $id, ')
          ..write('jsonData: $jsonData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonData);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PetTableData &&
          other.id == this.id &&
          other.jsonData == this.jsonData);
}

class PetTableCompanion extends UpdateCompanion<PetTableData> {
  final Value<String> id;
  final Value<String> jsonData;
  final Value<int> rowid;
  const PetTableCompanion({
    this.id = const Value.absent(),
    this.jsonData = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PetTableCompanion.insert({
    required String id,
    required String jsonData,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        jsonData = Value(jsonData);
  static Insertable<PetTableData> custom({
    Expression<String>? id,
    Expression<String>? jsonData,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonData != null) 'json_data': jsonData,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PetTableCompanion copyWith(
      {Value<String>? id, Value<String>? jsonData, Value<int>? rowid}) {
    return PetTableCompanion(
      id: id ?? this.id,
      jsonData: jsonData ?? this.jsonData,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (jsonData.present) {
      map['json_data'] = Variable<String>(jsonData.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetTableCompanion(')
          ..write('id: $id, ')
          ..write('jsonData: $jsonData, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivityTableTable extends ActivityTable
    with TableInfo<$ActivityTableTable, ActivityTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<String> petId = GeneratedColumn<String>(
      'pet_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _jsonDataMeta =
      const VerificationMeta('jsonData');
  @override
  late final GeneratedColumn<String> jsonData = GeneratedColumn<String>(
      'json_data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, petId, jsonData];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_table';
  @override
  VerificationContext validateIntegrity(Insertable<ActivityTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pet_id')) {
      context.handle(
          _petIdMeta, petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta));
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('json_data')) {
      context.handle(_jsonDataMeta,
          jsonData.isAcceptableOrUnknown(data['json_data']!, _jsonDataMeta));
    } else if (isInserting) {
      context.missing(_jsonDataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      petId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pet_id'])!,
      jsonData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}json_data'])!,
    );
  }

  @override
  $ActivityTableTable createAlias(String alias) {
    return $ActivityTableTable(attachedDatabase, alias);
  }
}

class ActivityTableData extends DataClass
    implements Insertable<ActivityTableData> {
  final String id;
  final String petId;
  final String jsonData;
  const ActivityTableData(
      {required this.id, required this.petId, required this.jsonData});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pet_id'] = Variable<String>(petId);
    map['json_data'] = Variable<String>(jsonData);
    return map;
  }

  ActivityTableCompanion toCompanion(bool nullToAbsent) {
    return ActivityTableCompanion(
      id: Value(id),
      petId: Value(petId),
      jsonData: Value(jsonData),
    );
  }

  factory ActivityTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityTableData(
      id: serializer.fromJson<String>(json['id']),
      petId: serializer.fromJson<String>(json['petId']),
      jsonData: serializer.fromJson<String>(json['jsonData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'petId': serializer.toJson<String>(petId),
      'jsonData': serializer.toJson<String>(jsonData),
    };
  }

  ActivityTableData copyWith({String? id, String? petId, String? jsonData}) =>
      ActivityTableData(
        id: id ?? this.id,
        petId: petId ?? this.petId,
        jsonData: jsonData ?? this.jsonData,
      );
  ActivityTableData copyWithCompanion(ActivityTableCompanion data) {
    return ActivityTableData(
      id: data.id.present ? data.id.value : this.id,
      petId: data.petId.present ? data.petId.value : this.petId,
      jsonData: data.jsonData.present ? data.jsonData.value : this.jsonData,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityTableData(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('jsonData: $jsonData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, petId, jsonData);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityTableData &&
          other.id == this.id &&
          other.petId == this.petId &&
          other.jsonData == this.jsonData);
}

class ActivityTableCompanion extends UpdateCompanion<ActivityTableData> {
  final Value<String> id;
  final Value<String> petId;
  final Value<String> jsonData;
  final Value<int> rowid;
  const ActivityTableCompanion({
    this.id = const Value.absent(),
    this.petId = const Value.absent(),
    this.jsonData = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityTableCompanion.insert({
    required String id,
    required String petId,
    required String jsonData,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        petId = Value(petId),
        jsonData = Value(jsonData);
  static Insertable<ActivityTableData> custom({
    Expression<String>? id,
    Expression<String>? petId,
    Expression<String>? jsonData,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (petId != null) 'pet_id': petId,
      if (jsonData != null) 'json_data': jsonData,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? petId,
      Value<String>? jsonData,
      Value<int>? rowid}) {
    return ActivityTableCompanion(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      jsonData: jsonData ?? this.jsonData,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (petId.present) {
      map['pet_id'] = Variable<String>(petId.value);
    }
    if (jsonData.present) {
      map['json_data'] = Variable<String>(jsonData.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityTableCompanion(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('jsonData: $jsonData, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhotoTableTable extends PhotoTable
    with TableInfo<$PhotoTableTable, PhotoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<String> petId = GeneratedColumn<String>(
      'pet_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _jsonDataMeta =
      const VerificationMeta('jsonData');
  @override
  late final GeneratedColumn<String> jsonData = GeneratedColumn<String>(
      'json_data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, petId, jsonData];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photo_table';
  @override
  VerificationContext validateIntegrity(Insertable<PhotoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pet_id')) {
      context.handle(
          _petIdMeta, petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta));
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('json_data')) {
      context.handle(_jsonDataMeta,
          jsonData.isAcceptableOrUnknown(data['json_data']!, _jsonDataMeta));
    } else if (isInserting) {
      context.missing(_jsonDataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhotoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhotoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      petId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pet_id'])!,
      jsonData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}json_data'])!,
    );
  }

  @override
  $PhotoTableTable createAlias(String alias) {
    return $PhotoTableTable(attachedDatabase, alias);
  }
}

class PhotoTableData extends DataClass implements Insertable<PhotoTableData> {
  final String id;
  final String petId;
  final String jsonData;
  const PhotoTableData(
      {required this.id, required this.petId, required this.jsonData});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pet_id'] = Variable<String>(petId);
    map['json_data'] = Variable<String>(jsonData);
    return map;
  }

  PhotoTableCompanion toCompanion(bool nullToAbsent) {
    return PhotoTableCompanion(
      id: Value(id),
      petId: Value(petId),
      jsonData: Value(jsonData),
    );
  }

  factory PhotoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotoTableData(
      id: serializer.fromJson<String>(json['id']),
      petId: serializer.fromJson<String>(json['petId']),
      jsonData: serializer.fromJson<String>(json['jsonData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'petId': serializer.toJson<String>(petId),
      'jsonData': serializer.toJson<String>(jsonData),
    };
  }

  PhotoTableData copyWith({String? id, String? petId, String? jsonData}) =>
      PhotoTableData(
        id: id ?? this.id,
        petId: petId ?? this.petId,
        jsonData: jsonData ?? this.jsonData,
      );
  PhotoTableData copyWithCompanion(PhotoTableCompanion data) {
    return PhotoTableData(
      id: data.id.present ? data.id.value : this.id,
      petId: data.petId.present ? data.petId.value : this.petId,
      jsonData: data.jsonData.present ? data.jsonData.value : this.jsonData,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhotoTableData(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('jsonData: $jsonData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, petId, jsonData);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoTableData &&
          other.id == this.id &&
          other.petId == this.petId &&
          other.jsonData == this.jsonData);
}

class PhotoTableCompanion extends UpdateCompanion<PhotoTableData> {
  final Value<String> id;
  final Value<String> petId;
  final Value<String> jsonData;
  final Value<int> rowid;
  const PhotoTableCompanion({
    this.id = const Value.absent(),
    this.petId = const Value.absent(),
    this.jsonData = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotoTableCompanion.insert({
    required String id,
    required String petId,
    required String jsonData,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        petId = Value(petId),
        jsonData = Value(jsonData);
  static Insertable<PhotoTableData> custom({
    Expression<String>? id,
    Expression<String>? petId,
    Expression<String>? jsonData,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (petId != null) 'pet_id': petId,
      if (jsonData != null) 'json_data': jsonData,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotoTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? petId,
      Value<String>? jsonData,
      Value<int>? rowid}) {
    return PhotoTableCompanion(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      jsonData: jsonData ?? this.jsonData,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (petId.present) {
      map['pet_id'] = Variable<String>(petId.value);
    }
    if (jsonData.present) {
      map['json_data'] = Variable<String>(jsonData.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotoTableCompanion(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('jsonData: $jsonData, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ChatMessagesTable chatMessages = $ChatMessagesTable(this);
  late final $PetTableTable petTable = $PetTableTable(this);
  late final $ActivityTableTable activityTable = $ActivityTableTable(this);
  late final $PhotoTableTable photoTable = $PhotoTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [chatMessages, petTable, activityTable, photoTable];
}

typedef $$ChatMessagesTableCreateCompanionBuilder = ChatMessagesCompanion
    Function({
  Value<int> localId,
  required String jsonData,
  required String timestamp,
});
typedef $$ChatMessagesTableUpdateCompanionBuilder = ChatMessagesCompanion
    Function({
  Value<int> localId,
  Value<String> jsonData,
  Value<String> timestamp,
});

class $$ChatMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get jsonData => $composableBuilder(
      column: $table.jsonData, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$ChatMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get jsonData => $composableBuilder(
      column: $table.jsonData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$ChatMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get jsonData =>
      $composableBuilder(column: $table.jsonData, builder: (column) => column);

  GeneratedColumn<String> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$ChatMessagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatMessagesTable,
    ChatMessage,
    $$ChatMessagesTableFilterComposer,
    $$ChatMessagesTableOrderingComposer,
    $$ChatMessagesTableAnnotationComposer,
    $$ChatMessagesTableCreateCompanionBuilder,
    $$ChatMessagesTableUpdateCompanionBuilder,
    (
      ChatMessage,
      BaseReferences<_$AppDatabase, $ChatMessagesTable, ChatMessage>
    ),
    ChatMessage,
    PrefetchHooks Function()> {
  $$ChatMessagesTableTableManager(_$AppDatabase db, $ChatMessagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> localId = const Value.absent(),
            Value<String> jsonData = const Value.absent(),
            Value<String> timestamp = const Value.absent(),
          }) =>
              ChatMessagesCompanion(
            localId: localId,
            jsonData: jsonData,
            timestamp: timestamp,
          ),
          createCompanionCallback: ({
            Value<int> localId = const Value.absent(),
            required String jsonData,
            required String timestamp,
          }) =>
              ChatMessagesCompanion.insert(
            localId: localId,
            jsonData: jsonData,
            timestamp: timestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChatMessagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatMessagesTable,
    ChatMessage,
    $$ChatMessagesTableFilterComposer,
    $$ChatMessagesTableOrderingComposer,
    $$ChatMessagesTableAnnotationComposer,
    $$ChatMessagesTableCreateCompanionBuilder,
    $$ChatMessagesTableUpdateCompanionBuilder,
    (
      ChatMessage,
      BaseReferences<_$AppDatabase, $ChatMessagesTable, ChatMessage>
    ),
    ChatMessage,
    PrefetchHooks Function()>;
typedef $$PetTableTableCreateCompanionBuilder = PetTableCompanion Function({
  required String id,
  required String jsonData,
  Value<int> rowid,
});
typedef $$PetTableTableUpdateCompanionBuilder = PetTableCompanion Function({
  Value<String> id,
  Value<String> jsonData,
  Value<int> rowid,
});

class $$PetTableTableFilterComposer
    extends Composer<_$AppDatabase, $PetTableTable> {
  $$PetTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get jsonData => $composableBuilder(
      column: $table.jsonData, builder: (column) => ColumnFilters(column));
}

class $$PetTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PetTableTable> {
  $$PetTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get jsonData => $composableBuilder(
      column: $table.jsonData, builder: (column) => ColumnOrderings(column));
}

class $$PetTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PetTableTable> {
  $$PetTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get jsonData =>
      $composableBuilder(column: $table.jsonData, builder: (column) => column);
}

class $$PetTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PetTableTable,
    PetTableData,
    $$PetTableTableFilterComposer,
    $$PetTableTableOrderingComposer,
    $$PetTableTableAnnotationComposer,
    $$PetTableTableCreateCompanionBuilder,
    $$PetTableTableUpdateCompanionBuilder,
    (PetTableData, BaseReferences<_$AppDatabase, $PetTableTable, PetTableData>),
    PetTableData,
    PrefetchHooks Function()> {
  $$PetTableTableTableManager(_$AppDatabase db, $PetTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PetTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PetTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PetTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> jsonData = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PetTableCompanion(
            id: id,
            jsonData: jsonData,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String jsonData,
            Value<int> rowid = const Value.absent(),
          }) =>
              PetTableCompanion.insert(
            id: id,
            jsonData: jsonData,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PetTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PetTableTable,
    PetTableData,
    $$PetTableTableFilterComposer,
    $$PetTableTableOrderingComposer,
    $$PetTableTableAnnotationComposer,
    $$PetTableTableCreateCompanionBuilder,
    $$PetTableTableUpdateCompanionBuilder,
    (PetTableData, BaseReferences<_$AppDatabase, $PetTableTable, PetTableData>),
    PetTableData,
    PrefetchHooks Function()>;
typedef $$ActivityTableTableCreateCompanionBuilder = ActivityTableCompanion
    Function({
  required String id,
  required String petId,
  required String jsonData,
  Value<int> rowid,
});
typedef $$ActivityTableTableUpdateCompanionBuilder = ActivityTableCompanion
    Function({
  Value<String> id,
  Value<String> petId,
  Value<String> jsonData,
  Value<int> rowid,
});

class $$ActivityTableTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityTableTable> {
  $$ActivityTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get petId => $composableBuilder(
      column: $table.petId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get jsonData => $composableBuilder(
      column: $table.jsonData, builder: (column) => ColumnFilters(column));
}

class $$ActivityTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityTableTable> {
  $$ActivityTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get petId => $composableBuilder(
      column: $table.petId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get jsonData => $composableBuilder(
      column: $table.jsonData, builder: (column) => ColumnOrderings(column));
}

class $$ActivityTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityTableTable> {
  $$ActivityTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get petId =>
      $composableBuilder(column: $table.petId, builder: (column) => column);

  GeneratedColumn<String> get jsonData =>
      $composableBuilder(column: $table.jsonData, builder: (column) => column);
}

class $$ActivityTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ActivityTableTable,
    ActivityTableData,
    $$ActivityTableTableFilterComposer,
    $$ActivityTableTableOrderingComposer,
    $$ActivityTableTableAnnotationComposer,
    $$ActivityTableTableCreateCompanionBuilder,
    $$ActivityTableTableUpdateCompanionBuilder,
    (
      ActivityTableData,
      BaseReferences<_$AppDatabase, $ActivityTableTable, ActivityTableData>
    ),
    ActivityTableData,
    PrefetchHooks Function()> {
  $$ActivityTableTableTableManager(_$AppDatabase db, $ActivityTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> petId = const Value.absent(),
            Value<String> jsonData = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ActivityTableCompanion(
            id: id,
            petId: petId,
            jsonData: jsonData,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String petId,
            required String jsonData,
            Value<int> rowid = const Value.absent(),
          }) =>
              ActivityTableCompanion.insert(
            id: id,
            petId: petId,
            jsonData: jsonData,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ActivityTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ActivityTableTable,
    ActivityTableData,
    $$ActivityTableTableFilterComposer,
    $$ActivityTableTableOrderingComposer,
    $$ActivityTableTableAnnotationComposer,
    $$ActivityTableTableCreateCompanionBuilder,
    $$ActivityTableTableUpdateCompanionBuilder,
    (
      ActivityTableData,
      BaseReferences<_$AppDatabase, $ActivityTableTable, ActivityTableData>
    ),
    ActivityTableData,
    PrefetchHooks Function()>;
typedef $$PhotoTableTableCreateCompanionBuilder = PhotoTableCompanion Function({
  required String id,
  required String petId,
  required String jsonData,
  Value<int> rowid,
});
typedef $$PhotoTableTableUpdateCompanionBuilder = PhotoTableCompanion Function({
  Value<String> id,
  Value<String> petId,
  Value<String> jsonData,
  Value<int> rowid,
});

class $$PhotoTableTableFilterComposer
    extends Composer<_$AppDatabase, $PhotoTableTable> {
  $$PhotoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get petId => $composableBuilder(
      column: $table.petId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get jsonData => $composableBuilder(
      column: $table.jsonData, builder: (column) => ColumnFilters(column));
}

class $$PhotoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotoTableTable> {
  $$PhotoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get petId => $composableBuilder(
      column: $table.petId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get jsonData => $composableBuilder(
      column: $table.jsonData, builder: (column) => ColumnOrderings(column));
}

class $$PhotoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotoTableTable> {
  $$PhotoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get petId =>
      $composableBuilder(column: $table.petId, builder: (column) => column);

  GeneratedColumn<String> get jsonData =>
      $composableBuilder(column: $table.jsonData, builder: (column) => column);
}

class $$PhotoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PhotoTableTable,
    PhotoTableData,
    $$PhotoTableTableFilterComposer,
    $$PhotoTableTableOrderingComposer,
    $$PhotoTableTableAnnotationComposer,
    $$PhotoTableTableCreateCompanionBuilder,
    $$PhotoTableTableUpdateCompanionBuilder,
    (
      PhotoTableData,
      BaseReferences<_$AppDatabase, $PhotoTableTable, PhotoTableData>
    ),
    PhotoTableData,
    PrefetchHooks Function()> {
  $$PhotoTableTableTableManager(_$AppDatabase db, $PhotoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhotoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhotoTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhotoTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> petId = const Value.absent(),
            Value<String> jsonData = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PhotoTableCompanion(
            id: id,
            petId: petId,
            jsonData: jsonData,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String petId,
            required String jsonData,
            Value<int> rowid = const Value.absent(),
          }) =>
              PhotoTableCompanion.insert(
            id: id,
            petId: petId,
            jsonData: jsonData,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PhotoTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PhotoTableTable,
    PhotoTableData,
    $$PhotoTableTableFilterComposer,
    $$PhotoTableTableOrderingComposer,
    $$PhotoTableTableAnnotationComposer,
    $$PhotoTableTableCreateCompanionBuilder,
    $$PhotoTableTableUpdateCompanionBuilder,
    (
      PhotoTableData,
      BaseReferences<_$AppDatabase, $PhotoTableTable, PhotoTableData>
    ),
    PhotoTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ChatMessagesTableTableManager get chatMessages =>
      $$ChatMessagesTableTableManager(_db, _db.chatMessages);
  $$PetTableTableTableManager get petTable =>
      $$PetTableTableTableManager(_db, _db.petTable);
  $$ActivityTableTableTableManager get activityTable =>
      $$ActivityTableTableTableManager(_db, _db.activityTable);
  $$PhotoTableTableTableManager get photoTable =>
      $$PhotoTableTableTableManager(_db, _db.photoTable);
}
