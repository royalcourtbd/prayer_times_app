// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_database.dart';

// ignore_for_file: type=lint
class $PrayerTrackerTableTable extends PrayerTrackerTable
    with TableInfo<$PrayerTrackerTableTable, PrayerTrackerTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrayerTrackerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isSelectableMeta =
      const VerificationMeta('isSelectable');
  @override
  late final GeneratedColumn<bool> isSelectable = GeneratedColumn<bool>(
      'is_selectable', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_selectable" IN (0, 1))'),
      defaultValue: const Constant(false));
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
      [id, type, status, isSelectable, createdAt, updatedAt];
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('is_selectable')) {
      context.handle(
          _isSelectableMeta,
          isSelectable.isAcceptableOrUnknown(
              data['is_selectable']!, _isSelectableMeta));
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrayerTrackerTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrayerTrackerTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      isSelectable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_selectable'])!,
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
  final int id;
  final String type;
  final String status;
  final bool isSelectable;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PrayerTrackerTableData(
      {required this.id,
      required this.type,
      required this.status,
      required this.isSelectable,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['status'] = Variable<String>(status);
    map['is_selectable'] = Variable<bool>(isSelectable);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PrayerTrackerTableCompanion toCompanion(bool nullToAbsent) {
    return PrayerTrackerTableCompanion(
      id: Value(id),
      type: Value(type),
      status: Value(status),
      isSelectable: Value(isSelectable),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PrayerTrackerTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrayerTrackerTableData(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      status: serializer.fromJson<String>(json['status']),
      isSelectable: serializer.fromJson<bool>(json['isSelectable']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'status': serializer.toJson<String>(status),
      'isSelectable': serializer.toJson<bool>(isSelectable),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PrayerTrackerTableData copyWith(
          {int? id,
          String? type,
          String? status,
          bool? isSelectable,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PrayerTrackerTableData(
        id: id ?? this.id,
        type: type ?? this.type,
        status: status ?? this.status,
        isSelectable: isSelectable ?? this.isSelectable,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PrayerTrackerTableData copyWithCompanion(PrayerTrackerTableCompanion data) {
    return PrayerTrackerTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
      isSelectable: data.isSelectable.present
          ? data.isSelectable.value
          : this.isSelectable,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrayerTrackerTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('isSelectable: $isSelectable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, status, isSelectable, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrayerTrackerTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.status == this.status &&
          other.isSelectable == this.isSelectable &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PrayerTrackerTableCompanion
    extends UpdateCompanion<PrayerTrackerTableData> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> status;
  final Value<bool> isSelectable;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PrayerTrackerTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.isSelectable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PrayerTrackerTableCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required String status,
    this.isSelectable = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : type = Value(type),
        status = Value(status),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<PrayerTrackerTableData> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? status,
    Expression<bool>? isSelectable,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (isSelectable != null) 'is_selectable': isSelectable,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PrayerTrackerTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? type,
      Value<String>? status,
      Value<bool>? isSelectable,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return PrayerTrackerTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      status: status ?? this.status,
      isSelectable: isSelectable ?? this.isSelectable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isSelectable.present) {
      map['is_selectable'] = Variable<bool>(isSelectable.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrayerTrackerTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('isSelectable: $isSelectable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$PrayerDatabase extends GeneratedDatabase {
  _$PrayerDatabase(QueryExecutor e) : super(e);
  $PrayerDatabaseManager get managers => $PrayerDatabaseManager(this);
  late final $PrayerTrackerTableTable prayerTrackerTable =
      $PrayerTrackerTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [prayerTrackerTable];
}

typedef $$PrayerTrackerTableTableCreateCompanionBuilder
    = PrayerTrackerTableCompanion Function({
  Value<int> id,
  required String type,
  required String status,
  Value<bool> isSelectable,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$PrayerTrackerTableTableUpdateCompanionBuilder
    = PrayerTrackerTableCompanion Function({
  Value<int> id,
  Value<String> type,
  Value<String> status,
  Value<bool> isSelectable,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
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
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSelectable => $composableBuilder(
      column: $table.isSelectable, builder: (column) => ColumnFilters(column));

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
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSelectable => $composableBuilder(
      column: $table.isSelectable,
      builder: (column) => ColumnOrderings(column));

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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isSelectable => $composableBuilder(
      column: $table.isSelectable, builder: (column) => column);

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
            Value<int> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> isSelectable = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PrayerTrackerTableCompanion(
            id: id,
            type: type,
            status: status,
            isSelectable: isSelectable,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String type,
            required String status,
            Value<bool> isSelectable = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              PrayerTrackerTableCompanion.insert(
            id: id,
            type: type,
            status: status,
            isSelectable: isSelectable,
            createdAt: createdAt,
            updatedAt: updatedAt,
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
  $$PrayerTrackerTableTableTableManager get prayerTrackerTable =>
      $$PrayerTrackerTableTableTableManager(_db, _db.prayerTrackerTable);
}
