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
          // Print table info for debugging
          if (details.wasCreated) {
            print(
                'Database was created with schema version ${details.versionNow}');
          } else {
            print(
                'Database was opened with schema version ${details.versionNow}');
          }

          // Validate Photos table schema
          try {
            await customStatement('PRAGMA table_info(photos)');
            print('Photos table exists');
          } catch (e) {
            print('Error checking Photos table: $e');
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
        print('Database file deleted for schema upgrade');
      }

      // Save the new version
      await prefs.setInt('db_version', 2);
    } catch (e) {
      print('Error during database recreation: $e');
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.sqlite'));
    return NativeDatabase(file);
  });
}

// Add this singleton pattern
class DBProvider {
  // Private constructor
  DBProvider._();

  // Singleton instance
  static final DBProvider instance = DBProvider._();

  // Database instance
  AppDatabase? _database;

  // Get database, create if it doesn't exist
  Future<AppDatabase> get database async {
    if (_database != null) return _database!;
    _database = AppDatabase();
    return _database!;
  }
}
