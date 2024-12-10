// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_database.dart';

// ignore_for_file: type=lint
class $NotificationSettingsTableTable extends NotificationSettingsTable
    with
        TableInfo<$NotificationSettingsTableTable,
            NotificationSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _isEnabledMeta =
      const VerificationMeta('isEnabled');
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
      'is_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, isEnabled, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_settings_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<NotificationSettingsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationSettingsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationSettingsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $NotificationSettingsTableTable createAlias(String alias) {
    return $NotificationSettingsTableTable(attachedDatabase, alias);
  }
}

class NotificationSettingsTableData extends DataClass
    implements Insertable<NotificationSettingsTableData> {
  final int id;
  final bool isEnabled;
  final DateTime updatedAt;
  const NotificationSettingsTableData(
      {required this.id, required this.isEnabled, required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NotificationSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationSettingsTableCompanion(
      id: Value(id),
      isEnabled: Value(isEnabled),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotificationSettingsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationSettingsTableData(
      id: serializer.fromJson<int>(json['id']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NotificationSettingsTableData copyWith(
          {int? id, bool? isEnabled, DateTime? updatedAt}) =>
      NotificationSettingsTableData(
        id: id ?? this.id,
        isEnabled: isEnabled ?? this.isEnabled,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  NotificationSettingsTableData copyWithCompanion(
      NotificationSettingsTableCompanion data) {
    return NotificationSettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationSettingsTableData(')
          ..write('id: $id, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, isEnabled, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationSettingsTableData &&
          other.id == this.id &&
          other.isEnabled == this.isEnabled &&
          other.updatedAt == this.updatedAt);
}

class NotificationSettingsTableCompanion
    extends UpdateCompanion<NotificationSettingsTableData> {
  final Value<int> id;
  final Value<bool> isEnabled;
  final Value<DateTime> updatedAt;
  const NotificationSettingsTableCompanion({
    this.id = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NotificationSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.isEnabled = const Value.absent(),
    required DateTime updatedAt,
  }) : updatedAt = Value(updatedAt);
  static Insertable<NotificationSettingsTableData> custom({
    Expression<int>? id,
    Expression<bool>? isEnabled,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NotificationSettingsTableCompanion copyWith(
      {Value<int>? id, Value<bool>? isEnabled, Value<DateTime>? updatedAt}) {
    return NotificationSettingsTableCompanion(
      id: id ?? this.id,
      isEnabled: isEnabled ?? this.isEnabled,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $JuristicMethodTableTable extends JuristicMethodTable
    with TableInfo<$JuristicMethodTableTable, JuristicMethodTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JuristicMethodTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
      'method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [method, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'juristic_method_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<JuristicMethodTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('method')) {
      context.handle(_methodMeta,
          method.isAcceptableOrUnknown(data['method']!, _methodMeta));
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  JuristicMethodTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JuristicMethodTableData(
      method: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}method'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $JuristicMethodTableTable createAlias(String alias) {
    return $JuristicMethodTableTable(attachedDatabase, alias);
  }
}

class JuristicMethodTableData extends DataClass
    implements Insertable<JuristicMethodTableData> {
  final String method;
  final DateTime updatedAt;
  const JuristicMethodTableData(
      {required this.method, required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['method'] = Variable<String>(method);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  JuristicMethodTableCompanion toCompanion(bool nullToAbsent) {
    return JuristicMethodTableCompanion(
      method: Value(method),
      updatedAt: Value(updatedAt),
    );
  }

  factory JuristicMethodTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JuristicMethodTableData(
      method: serializer.fromJson<String>(json['method']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'method': serializer.toJson<String>(method),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  JuristicMethodTableData copyWith({String? method, DateTime? updatedAt}) =>
      JuristicMethodTableData(
        method: method ?? this.method,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  JuristicMethodTableData copyWithCompanion(JuristicMethodTableCompanion data) {
    return JuristicMethodTableData(
      method: data.method.present ? data.method.value : this.method,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JuristicMethodTableData(')
          ..write('method: $method, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(method, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JuristicMethodTableData &&
          other.method == this.method &&
          other.updatedAt == this.updatedAt);
}

class JuristicMethodTableCompanion
    extends UpdateCompanion<JuristicMethodTableData> {
  final Value<String> method;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const JuristicMethodTableCompanion({
    this.method = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JuristicMethodTableCompanion.insert({
    required String method,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : method = Value(method),
        updatedAt = Value(updatedAt);
  static Insertable<JuristicMethodTableData> custom({
    Expression<String>? method,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (method != null) 'method': method,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JuristicMethodTableCompanion copyWith(
      {Value<String>? method, Value<DateTime>? updatedAt, Value<int>? rowid}) {
    return JuristicMethodTableCompanion(
      method: method ?? this.method,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JuristicMethodTableCompanion(')
          ..write('method: $method, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$PrayerDatabase extends GeneratedDatabase {
  _$PrayerDatabase(QueryExecutor e) : super(e);
  $PrayerDatabaseManager get managers => $PrayerDatabaseManager(this);
  late final $NotificationSettingsTableTable notificationSettingsTable =
      $NotificationSettingsTableTable(this);
  late final $JuristicMethodTableTable juristicMethodTable =
      $JuristicMethodTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [notificationSettingsTable, juristicMethodTable];
}

typedef $$NotificationSettingsTableTableCreateCompanionBuilder
    = NotificationSettingsTableCompanion Function({
  Value<int> id,
  Value<bool> isEnabled,
  required DateTime updatedAt,
});
typedef $$NotificationSettingsTableTableUpdateCompanionBuilder
    = NotificationSettingsTableCompanion Function({
  Value<int> id,
  Value<bool> isEnabled,
  Value<DateTime> updatedAt,
});

class $$NotificationSettingsTableTableFilterComposer
    extends Composer<_$PrayerDatabase, $NotificationSettingsTableTable> {
  $$NotificationSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$NotificationSettingsTableTableOrderingComposer
    extends Composer<_$PrayerDatabase, $NotificationSettingsTableTable> {
  $$NotificationSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$NotificationSettingsTableTableAnnotationComposer
    extends Composer<_$PrayerDatabase, $NotificationSettingsTableTable> {
  $$NotificationSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotificationSettingsTableTableTableManager extends RootTableManager<
    _$PrayerDatabase,
    $NotificationSettingsTableTable,
    NotificationSettingsTableData,
    $$NotificationSettingsTableTableFilterComposer,
    $$NotificationSettingsTableTableOrderingComposer,
    $$NotificationSettingsTableTableAnnotationComposer,
    $$NotificationSettingsTableTableCreateCompanionBuilder,
    $$NotificationSettingsTableTableUpdateCompanionBuilder,
    (
      NotificationSettingsTableData,
      BaseReferences<_$PrayerDatabase, $NotificationSettingsTableTable,
          NotificationSettingsTableData>
    ),
    NotificationSettingsTableData,
    PrefetchHooks Function()> {
  $$NotificationSettingsTableTableTableManager(
      _$PrayerDatabase db, $NotificationSettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationSettingsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationSettingsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationSettingsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              NotificationSettingsTableCompanion(
            id: id,
            isEnabled: isEnabled,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
            required DateTime updatedAt,
          }) =>
              NotificationSettingsTableCompanion.insert(
            id: id,
            isEnabled: isEnabled,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotificationSettingsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$PrayerDatabase,
        $NotificationSettingsTableTable,
        NotificationSettingsTableData,
        $$NotificationSettingsTableTableFilterComposer,
        $$NotificationSettingsTableTableOrderingComposer,
        $$NotificationSettingsTableTableAnnotationComposer,
        $$NotificationSettingsTableTableCreateCompanionBuilder,
        $$NotificationSettingsTableTableUpdateCompanionBuilder,
        (
          NotificationSettingsTableData,
          BaseReferences<_$PrayerDatabase, $NotificationSettingsTableTable,
              NotificationSettingsTableData>
        ),
        NotificationSettingsTableData,
        PrefetchHooks Function()>;
typedef $$JuristicMethodTableTableCreateCompanionBuilder
    = JuristicMethodTableCompanion Function({
  required String method,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$JuristicMethodTableTableUpdateCompanionBuilder
    = JuristicMethodTableCompanion Function({
  Value<String> method,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$JuristicMethodTableTableFilterComposer
    extends Composer<_$PrayerDatabase, $JuristicMethodTableTable> {
  $$JuristicMethodTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$JuristicMethodTableTableOrderingComposer
    extends Composer<_$PrayerDatabase, $JuristicMethodTableTable> {
  $$JuristicMethodTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$JuristicMethodTableTableAnnotationComposer
    extends Composer<_$PrayerDatabase, $JuristicMethodTableTable> {
  $$JuristicMethodTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$JuristicMethodTableTableTableManager extends RootTableManager<
    _$PrayerDatabase,
    $JuristicMethodTableTable,
    JuristicMethodTableData,
    $$JuristicMethodTableTableFilterComposer,
    $$JuristicMethodTableTableOrderingComposer,
    $$JuristicMethodTableTableAnnotationComposer,
    $$JuristicMethodTableTableCreateCompanionBuilder,
    $$JuristicMethodTableTableUpdateCompanionBuilder,
    (
      JuristicMethodTableData,
      BaseReferences<_$PrayerDatabase, $JuristicMethodTableTable,
          JuristicMethodTableData>
    ),
    JuristicMethodTableData,
    PrefetchHooks Function()> {
  $$JuristicMethodTableTableTableManager(
      _$PrayerDatabase db, $JuristicMethodTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JuristicMethodTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JuristicMethodTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JuristicMethodTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> method = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              JuristicMethodTableCompanion(
            method: method,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String method,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              JuristicMethodTableCompanion.insert(
            method: method,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$JuristicMethodTableTableProcessedTableManager = ProcessedTableManager<
    _$PrayerDatabase,
    $JuristicMethodTableTable,
    JuristicMethodTableData,
    $$JuristicMethodTableTableFilterComposer,
    $$JuristicMethodTableTableOrderingComposer,
    $$JuristicMethodTableTableAnnotationComposer,
    $$JuristicMethodTableTableCreateCompanionBuilder,
    $$JuristicMethodTableTableUpdateCompanionBuilder,
    (
      JuristicMethodTableData,
      BaseReferences<_$PrayerDatabase, $JuristicMethodTableTable,
          JuristicMethodTableData>
    ),
    JuristicMethodTableData,
    PrefetchHooks Function()>;

class $PrayerDatabaseManager {
  final _$PrayerDatabase _db;
  $PrayerDatabaseManager(this._db);
  $$NotificationSettingsTableTableTableManager get notificationSettingsTable =>
      $$NotificationSettingsTableTableTableManager(
          _db, _db.notificationSettingsTable);
  $$JuristicMethodTableTableTableManager get juristicMethodTable =>
      $$JuristicMethodTableTableTableManager(_db, _db.juristicMethodTable);
}
