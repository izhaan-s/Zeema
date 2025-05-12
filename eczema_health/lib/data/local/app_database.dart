import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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
  IntColumn get itchIntensity => integer()();
  TextColumn get notes => text().nullable()(); // JSON string
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

class Treatments extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()
      .customConstraint('NOT NULL REFERENCES profiles(id) ON DELETE CASCADE')();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

class SymptomTreatmentLinks extends Table {
  TextColumn get id => text()();
  TextColumn get symptomId => text().customConstraint(
      'NOT NULL REFERENCES symptom_entries(id) ON DELETE CASCADE')();
  TextColumn get treatmentId => text().customConstraint(
      'NOT NULL REFERENCES treatments(id) ON DELETE CASCADE')();
  TextColumn get userId => text()
      .customConstraint('NOT NULL REFERENCES profiles(id) ON DELETE CASCADE')();
  DateTimeColumn get createdAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
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
    Treatments,
    SymptomTreatmentLinks,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.sqlite'));
    return NativeDatabase(file);
  });
}
