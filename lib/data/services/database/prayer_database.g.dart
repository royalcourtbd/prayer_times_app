// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_database.dart';

// ignore_for_file: type=lint
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

class $PrayerTrackerTableTable extends PrayerTrackerTable
    with TableInfo<$PrayerTrackerTableTable, PrayerTrackerTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrayerTrackerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _trackerDataMeta =
      const VerificationMeta('trackerData');
  @override
  late final GeneratedColumn<String> trackerData = GeneratedColumn<String>(
      'tracker_data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [date, trackerData, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prayer_tracker_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PrayerTrackerTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('tracker_data')) {
      context.handle(
          _trackerDataMeta,
          trackerData.isAcceptableOrUnknown(
              data['tracker_data']!, _trackerDataMeta));
    } else if (isInserting) {
      context.missing(_trackerDataMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
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
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  PrayerTrackerTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrayerTrackerTableData(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      trackerData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tracker_data'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PrayerTrackerTableTable createAlias(String alias) {
    return $PrayerTrackerTableTable(attachedDatabase, alias);
  }
}

class PrayerTrackerTableData extends DataClass
    implements Insertable<PrayerTrackerTableData> {
  final DateTime date;
  final String trackerData;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PrayerTrackerTableData(
      {required this.date,
      required this.trackerData,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['tracker_data'] = Variable<String>(trackerData);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PrayerTrackerTableCompanion toCompanion(bool nullToAbsent) {
    return PrayerTrackerTableCompanion(
      date: Value(date),
      trackerData: Value(trackerData),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PrayerTrackerTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrayerTrackerTableData(
      date: serializer.fromJson<DateTime>(json['date']),
      trackerData: serializer.fromJson<String>(json['trackerData']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'trackerData': serializer.toJson<String>(trackerData),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PrayerTrackerTableData copyWith(
          {DateTime? date,
          String? trackerData,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PrayerTrackerTableData(
        date: date ?? this.date,
        trackerData: trackerData ?? this.trackerData,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PrayerTrackerTableData copyWithCompanion(PrayerTrackerTableCompanion data) {
    return PrayerTrackerTableData(
      date: data.date.present ? data.date.value : this.date,
      trackerData:
          data.trackerData.present ? data.trackerData.value : this.trackerData,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrayerTrackerTableData(')
          ..write('date: $date, ')
          ..write('trackerData: $trackerData, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, trackerData, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrayerTrackerTableData &&
          other.date == this.date &&
          other.trackerData == this.trackerData &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PrayerTrackerTableCompanion
    extends UpdateCompanion<PrayerTrackerTableData> {
  final Value<DateTime> date;
  final Value<String> trackerData;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PrayerTrackerTableCompanion({
    this.date = const Value.absent(),
    this.trackerData = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrayerTrackerTableCompanion.insert({
    required DateTime date,
    required String trackerData,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        trackerData = Value(trackerData),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<PrayerTrackerTableData> custom({
    Expression<DateTime>? date,
    Expression<String>? trackerData,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (trackerData != null) 'tracker_data': trackerData,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrayerTrackerTableCompanion copyWith(
      {Value<DateTime>? date,
      Value<String>? trackerData,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return PrayerTrackerTableCompanion(
      date: date ?? this.date,
      trackerData: trackerData ?? this.trackerData,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (trackerData.present) {
      map['tracker_data'] = Variable<String>(trackerData.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
    return (StringBuffer('PrayerTrackerTableCompanion(')
          ..write('date: $date, ')
          ..write('trackerData: $trackerData, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$PrayerDatabase extends GeneratedDatabase {
  _$PrayerDatabase(QueryExecutor e) : super(e);
  $PrayerDatabaseManager get managers => $PrayerDatabaseManager(this);
  late final $JuristicMethodTableTable juristicMethodTable =
      $JuristicMethodTableTable(this);
  late final $PrayerTrackerTableTable prayerTrackerTable =
      $PrayerTrackerTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [juristicMethodTable, prayerTrackerTable];
}

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
typedef $$PrayerTrackerTableTableCreateCompanionBuilder
    = PrayerTrackerTableCompanion Function({
  required DateTime date,
  required String trackerData,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$PrayerTrackerTableTableUpdateCompanionBuilder
    = PrayerTrackerTableCompanion Function({
  Value<DateTime> date,
  Value<String> trackerData,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$PrayerTrackerTableTableFilterComposer
    extends Composer<_$PrayerDatabase, $PrayerTrackerTableTable> {
  $$PrayerTrackerTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get trackerData => $composableBuilder(
      column: $table.trackerData, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$PrayerTrackerTableTableOrderingComposer
    extends Composer<_$PrayerDatabase, $PrayerTrackerTableTable> {
  $$PrayerTrackerTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get trackerData => $composableBuilder(
      column: $table.trackerData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PrayerTrackerTableTableAnnotationComposer
    extends Composer<_$PrayerDatabase, $PrayerTrackerTableTable> {
  $$PrayerTrackerTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get trackerData => $composableBuilder(
      column: $table.trackerData, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PrayerTrackerTableTableTableManager extends RootTableManager<
    _$PrayerDatabase,
    $PrayerTrackerTableTable,
    PrayerTrackerTableData,
    $$PrayerTrackerTableTableFilterComposer,
    $$PrayerTrackerTableTableOrderingComposer,
    $$PrayerTrackerTableTableAnnotationComposer,
    $$PrayerTrackerTableTableCreateCompanionBuilder,
    $$PrayerTrackerTableTableUpdateCompanionBuilder,
    (
      PrayerTrackerTableData,
      BaseReferences<_$PrayerDatabase, $PrayerTrackerTableTable,
          PrayerTrackerTableData>
    ),
    PrayerTrackerTableData,
    PrefetchHooks Function()> {
  $$PrayerTrackerTableTableTableManager(
      _$PrayerDatabase db, $PrayerTrackerTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrayerTrackerTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrayerTrackerTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrayerTrackerTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> date = const Value.absent(),
            Value<String> trackerData = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PrayerTrackerTableCompanion(
            date: date,
            trackerData: trackerData,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime date,
            required String trackerData,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PrayerTrackerTableCompanion.insert(
            date: date,
            trackerData: trackerData,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PrayerTrackerTableTableProcessedTableManager = ProcessedTableManager<
    _$PrayerDatabase,
    $PrayerTrackerTableTable,
    PrayerTrackerTableData,
    $$PrayerTrackerTableTableFilterComposer,
    $$PrayerTrackerTableTableOrderingComposer,
    $$PrayerTrackerTableTableAnnotationComposer,
    $$PrayerTrackerTableTableCreateCompanionBuilder,
    $$PrayerTrackerTableTableUpdateCompanionBuilder,
    (
      PrayerTrackerTableData,
      BaseReferences<_$PrayerDatabase, $PrayerTrackerTableTable,
          PrayerTrackerTableData>
    ),
    PrayerTrackerTableData,
    PrefetchHooks Function()>;

class $PrayerDatabaseManager {
  final _$PrayerDatabase _db;
  $PrayerDatabaseManager(this._db);
  $$JuristicMethodTableTableTableManager get juristicMethodTable =>
      $$JuristicMethodTableTableTableManager(_db, _db.juristicMethodTable);
  $$PrayerTrackerTableTableTableManager get prayerTrackerTable =>
      $$PrayerTrackerTableTableTableManager(_db, _db.prayerTrackerTable);
}
