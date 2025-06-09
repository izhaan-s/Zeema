import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

part 'app_database.g.dart';

// ---------------- TABLES ----------------

class Reminders extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()
      .customConstraint('NOT NULL REFERENCES profiles(id) ON DELETE CASCADE')();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get reminderType => text().nullable()();
  DateTimeColumn get time => dateTime()();
  TextColumn get repeatDays => text()(); // JSON string
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

class Medications extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()
      .customConstraint('NOT NULL REFERENCES profiles(id) ON DELETE CASCADE')();
  TextColumn get name => text()();
  TextColumn get dosage => text()();
  TextColumn get frequency => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  IntColumn get effectiveness => integer().nullable()();
  TextColumn get sideEffects => text().nullable()(); // JSON string
  TextColumn get notes => text().nullable()(); // JSON string
  BoolColumn get isPreloaded => boolean().withDefault(const Constant(false))();
  BoolColumn get isSteroid => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

class Photos extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()
      .customConstraint('NOT NULL REFERENCES profiles(id) ON DELETE CASCADE')();
  TextColumn get imageUrl => text()();
  TextColumn get bodyPart => text()();
  IntColumn get itchIntensity => integer().nullable()();
  TextColumn get notes => text().nullable()(); // JSON string
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

class Profiles extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get displayName => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get avatarUrl => text().nullable()();
  DateTimeColumn get dateOfBirth => dateTime()();
  TextColumn get knownAllergies => text()(); // JSON string
  TextColumn get medicalNotes => text()(); // JSON string
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

class LifestyleEntries extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()
      .customConstraint('NOT NULL REFERENCES profiles(id) ON DELETE CASCADE')();
  DateTimeColumn get date => dateTime()();
  TextColumn get foodsConsumed => text()(); // JSON string
  TextColumn get potentialTriggerFoods => text()(); // JSON string
  IntColumn get sleepHours => integer()();
  IntColumn get sleepQuality => integer()();
  IntColumn get stressLevel => integer()();
  RealColumn get waterIntakeLiters => real()();
  IntColumn get exerciseMinutes => integer()();
  TextColumn get notes => text().nullable()(); // JSON string
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

class SymptomEntries extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()
      .customConstraint('NOT NULL REFERENCES profiles(id) ON DELETE CASCADE')();
  DateTimeColumn get date => dateTime()();
  BoolColumn get isFlareup => boolean()();
  TextColumn get severity => text()();
  TextColumn get affectedAreas => text()(); // JSON string
  TextColumn get symptoms => text().nullable()(); // JSON string
  TextColumn get notes => text().nullable()(); // JSON string
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

class SymptomMedicationLinks extends Table {
  TextColumn get id => text()();
  TextColumn get symptomId => text().customConstraint(
      'NOT NULL REFERENCES symptom_entries(id) ON DELETE CASCADE')();
  TextColumn get medicationId => text().customConstraint(
      'NOT NULL REFERENCES medications(id) ON DELETE CASCADE')();
  TextColumn get userId => text()
      .customConstraint('NOT NULL REFERENCES profiles(id) ON DELETE CASCADE')();
  DateTimeColumn get createdAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

class DashboardCache extends Table {
  TextColumn get userId => text()
      .customConstraint('NOT NULL REFERENCES profiles(id) ON DELETE CASCADE')();
  TextColumn get severityData => text()(); // JSON string of severity data
  TextColumn get flares => text()(); // JSON string of flare clusters
  TextColumn get symptomMatrix => text()(); // JSON string of symptom matrix
  DateTimeColumn get lastUpdated => dateTime()();
  IntColumn get lastSymptomCount => integer()();
  @override
  Set<Column> get primaryKey => {userId};
}

// Syncing status table
class SyncState extends Table {
  TextColumn get userId => text()
      .customConstraint('NOT NULL REFERENCES profiles(id) ON DELETE CASCADE')();
  TextColumn get targetTable => text()(); // table to sync
  TextColumn get rowId => text()(); // row id in the table
  // crud operation
  TextColumn get operation => text().customConstraint(
      "NOT NULL CHECK (operation IN ('insert', 'update', 'delete'))")();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdatedAt =>
      dateTime()(); // last updated time in the table
  DateTimeColumn get lastSynced => dateTime().nullable()(); // last synced time
  IntColumn get retryCount =>
      integer().withDefault(const Constant(0))(); // retry count
  TextColumn get error => text().nullable()(); // error message

  @override
  Set<Column> get primaryKey => {userId, targetTable, rowId};

  @override
  List<String> get customConstraints =>
      ['FOREIGN KEY(userId) REFERENCES profiles(id) ON DELETE CASCADE'];

  @override
  List<String> get indexes => [
        'CREATE INDEX idx_sync_state_unsynced ON sync_state(is_synced)',
        'CREATE INDEX idx_sync_state_last_updated ON sync_state(last_updated_at)'
      ];
}

// ------------- DATABASE CLASS -------------

@DriftDatabase(
  tables: [
    Reminders,
    Medications,
    Photos,
    Profiles,
    LifestyleEntries,
    SymptomEntries,
    SymptomMedicationLinks,
    DashboardCache,
    SyncState,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase({bool useInMemory = false})
      : super(useInMemory
            ? LazyDatabase(() async => NativeDatabase.memory())
            : LazyDatabase(() async {
                // Force recreate database file if needed
                await _handleDatabaseRecreation();

                final dbFolder = await getApplicationDocumentsDirectory();
                final file = File(p.join(dbFolder.path, 'db.sqlite'));
                return NativeDatabase(file);
              }));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) => m.createAll(),
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            // For schema version 2, we'll handle it by recreating the database
            // This is already handled by _handleDatabaseRecreation above

            // Add explicit Photos table creation with the date column
            await m.createTable(photos);
          }
        },
        beforeOpen: (details) async {
          // Table info tracking
          if (details.wasCreated) {
            // Database created with schema version ${details.versionNow}
          } else {
            // Database opened with schema version ${details.versionNow}
          }

          // Validate Photos table schema
          try {
            await customStatement('PRAGMA table_info(photos)');
            // Photos table exists
          } catch (e) {
            // Error checking Photos table
          }
        },
      );
}

// Handle database recreation on first run with the new schema
Future<void> _handleDatabaseRecreation() async {
  final prefs = await SharedPreferences.getInstance();
  final currentDbVersion = prefs.getInt('db_version') ?? 1;

  if (currentDbVersion < 2) {
    // Need to recreate database
    try {
      final dbFolder = await getApplicationDocumentsDirectory();
      final dbFile = File(p.join(dbFolder.path, 'db.sqlite'));
      if (await dbFile.exists()) {
        await dbFile.delete();
        // Database file deleted for schema upgrade
      }

      // Save the new version
      await prefs.setInt('db_version', 2);
    } catch (e) {
      // Error during database recreation
    }
  }
}

// DBProvider singleton removed - using dependency injection via Provider package instead
