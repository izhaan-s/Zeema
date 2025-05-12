// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _avatarUrlMeta =
      const VerificationMeta('avatarUrl');
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
      'avatar_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
      'date_of_birth', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _knownAllergiesMeta =
      const VerificationMeta('knownAllergies');
  @override
  late final GeneratedColumn<String> knownAllergies = GeneratedColumn<String>(
      'known_allergies', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _medicalNotesMeta =
      const VerificationMeta('medicalNotes');
  @override
  late final GeneratedColumn<String> medicalNotes = GeneratedColumn<String>(
      'medical_notes', aliasedName, false,
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
  List<GeneratedColumn> get $columns => [
        id,
        email,
        displayName,
        firstName,
        lastName,
        avatarUrl,
        dateOfBirth,
        knownAllergies,
        medicalNotes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(Insertable<Profile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('avatar_url')) {
      context.handle(_avatarUrlMeta,
          avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta));
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    } else if (isInserting) {
      context.missing(_dateOfBirthMeta);
    }
    if (data.containsKey('known_allergies')) {
      context.handle(
          _knownAllergiesMeta,
          knownAllergies.isAcceptableOrUnknown(
              data['known_allergies']!, _knownAllergiesMeta));
    } else if (isInserting) {
      context.missing(_knownAllergiesMeta);
    }
    if (data.containsKey('medical_notes')) {
      context.handle(
          _medicalNotesMeta,
          medicalNotes.isAcceptableOrUnknown(
              data['medical_notes']!, _medicalNotesMeta));
    } else if (isInserting) {
      context.missing(_medicalNotesMeta);
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
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      avatarUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_url']),
      dateOfBirth: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_of_birth'])!,
      knownAllergies: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}known_allergies'])!,
      medicalNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medical_notes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final String id;
  final String email;
  final String displayName;
  final String firstName;
  final String lastName;
  final String? avatarUrl;
  final DateTime dateOfBirth;
  final String knownAllergies;
  final String medicalNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Profile(
      {required this.id,
      required this.email,
      required this.displayName,
      required this.firstName,
      required this.lastName,
      this.avatarUrl,
      required this.dateOfBirth,
      required this.knownAllergies,
      required this.medicalNotes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['email'] = Variable<String>(email);
    map['display_name'] = Variable<String>(displayName);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    map['known_allergies'] = Variable<String>(knownAllergies);
    map['medical_notes'] = Variable<String>(medicalNotes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      email: Value(email),
      displayName: Value(displayName),
      firstName: Value(firstName),
      lastName: Value(lastName),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      dateOfBirth: Value(dateOfBirth),
      knownAllergies: Value(knownAllergies),
      medicalNotes: Value(medicalNotes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      displayName: serializer.fromJson<String>(json['displayName']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      dateOfBirth: serializer.fromJson<DateTime>(json['dateOfBirth']),
      knownAllergies: serializer.fromJson<String>(json['knownAllergies']),
      medicalNotes: serializer.fromJson<String>(json['medicalNotes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String>(email),
      'displayName': serializer.toJson<String>(displayName),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'dateOfBirth': serializer.toJson<DateTime>(dateOfBirth),
      'knownAllergies': serializer.toJson<String>(knownAllergies),
      'medicalNotes': serializer.toJson<String>(medicalNotes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Profile copyWith(
          {String? id,
          String? email,
          String? displayName,
          String? firstName,
          String? lastName,
          Value<String?> avatarUrl = const Value.absent(),
          DateTime? dateOfBirth,
          String? knownAllergies,
          String? medicalNotes,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Profile(
        id: id ?? this.id,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        knownAllergies: knownAllergies ?? this.knownAllergies,
        medicalNotes: medicalNotes ?? this.medicalNotes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
      knownAllergies: data.knownAllergies.present
          ? data.knownAllergies.value
          : this.knownAllergies,
      medicalNotes: data.medicalNotes.present
          ? data.medicalNotes.value
          : this.medicalNotes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('knownAllergies: $knownAllergies, ')
          ..write('medicalNotes: $medicalNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      email,
      displayName,
      firstName,
      lastName,
      avatarUrl,
      dateOfBirth,
      knownAllergies,
      medicalNotes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.email == this.email &&
          other.displayName == this.displayName &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.avatarUrl == this.avatarUrl &&
          other.dateOfBirth == this.dateOfBirth &&
          other.knownAllergies == this.knownAllergies &&
          other.medicalNotes == this.medicalNotes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<String> id;
  final Value<String> email;
  final Value<String> displayName;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String?> avatarUrl;
  final Value<DateTime> dateOfBirth;
  final Value<String> knownAllergies;
  final Value<String> medicalNotes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.displayName = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.knownAllergies = const Value.absent(),
    this.medicalNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesCompanion.insert({
    required String id,
    required String email,
    required String displayName,
    required String firstName,
    required String lastName,
    this.avatarUrl = const Value.absent(),
    required DateTime dateOfBirth,
    required String knownAllergies,
    required String medicalNotes,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        email = Value(email),
        displayName = Value(displayName),
        firstName = Value(firstName),
        lastName = Value(lastName),
        dateOfBirth = Value(dateOfBirth),
        knownAllergies = Value(knownAllergies),
        medicalNotes = Value(medicalNotes),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Profile> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? displayName,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? avatarUrl,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? knownAllergies,
    Expression<String>? medicalNotes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (displayName != null) 'display_name': displayName,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (knownAllergies != null) 'known_allergies': knownAllergies,
      if (medicalNotes != null) 'medical_notes': medicalNotes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? email,
      Value<String>? displayName,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String?>? avatarUrl,
      Value<DateTime>? dateOfBirth,
      Value<String>? knownAllergies,
      Value<String>? medicalNotes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ProfilesCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      knownAllergies: knownAllergies ?? this.knownAllergies,
      medicalNotes: medicalNotes ?? this.medicalNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (knownAllergies.present) {
      map['known_allergies'] = Variable<String>(knownAllergies.value);
    }
    if (medicalNotes.present) {
      map['medical_notes'] = Variable<String>(medicalNotes.value);
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
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('knownAllergies: $knownAllergies, ')
          ..write('medicalNotes: $medicalNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES profiles(id) ON DELETE CASCADE');
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reminderTypeMeta =
      const VerificationMeta('reminderType');
  @override
  late final GeneratedColumn<String> reminderType = GeneratedColumn<String>(
      'reminder_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _repeatDaysMeta =
      const VerificationMeta('repeatDays');
  @override
  late final GeneratedColumn<String> repeatDays = GeneratedColumn<String>(
      'repeat_days', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
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
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        title,
        description,
        reminderType,
        time,
        repeatDays,
        isActive,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(Insertable<Reminder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
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
    }
    if (data.containsKey('reminder_type')) {
      context.handle(
          _reminderTypeMeta,
          reminderType.isAcceptableOrUnknown(
              data['reminder_type']!, _reminderTypeMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('repeat_days')) {
      context.handle(
          _repeatDaysMeta,
          repeatDays.isAcceptableOrUnknown(
              data['repeat_days']!, _repeatDaysMeta));
    } else if (isInserting) {
      context.missing(_repeatDaysMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
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
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      reminderType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reminder_type']),
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      repeatDays: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}repeat_days'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final String? reminderType;
  final DateTime time;
  final String repeatDays;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Reminder(
      {required this.id,
      required this.userId,
      required this.title,
      this.description,
      this.reminderType,
      required this.time,
      required this.repeatDays,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || reminderType != null) {
      map['reminder_type'] = Variable<String>(reminderType);
    }
    map['time'] = Variable<DateTime>(time);
    map['repeat_days'] = Variable<String>(repeatDays);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      reminderType: reminderType == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderType),
      time: Value(time),
      repeatDays: Value(repeatDays),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Reminder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      reminderType: serializer.fromJson<String?>(json['reminderType']),
      time: serializer.fromJson<DateTime>(json['time']),
      repeatDays: serializer.fromJson<String>(json['repeatDays']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'reminderType': serializer.toJson<String?>(reminderType),
      'time': serializer.toJson<DateTime>(time),
      'repeatDays': serializer.toJson<String>(repeatDays),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Reminder copyWith(
          {String? id,
          String? userId,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<String?> reminderType = const Value.absent(),
          DateTime? time,
          String? repeatDays,
          bool? isActive,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Reminder(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        reminderType:
            reminderType.present ? reminderType.value : this.reminderType,
        time: time ?? this.time,
        repeatDays: repeatDays ?? this.repeatDays,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      reminderType: data.reminderType.present
          ? data.reminderType.value
          : this.reminderType,
      time: data.time.present ? data.time.value : this.time,
      repeatDays:
          data.repeatDays.present ? data.repeatDays.value : this.repeatDays,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('reminderType: $reminderType, ')
          ..write('time: $time, ')
          ..write('repeatDays: $repeatDays, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, title, description, reminderType,
      time, repeatDays, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.description == this.description &&
          other.reminderType == this.reminderType &&
          other.time == this.time &&
          other.repeatDays == this.repeatDays &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> reminderType;
  final Value<DateTime> time;
  final Value<String> repeatDays;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.reminderType = const Value.absent(),
    this.time = const Value.absent(),
    this.repeatDays = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    required String id,
    required String userId,
    required String title,
    this.description = const Value.absent(),
    this.reminderType = const Value.absent(),
    required DateTime time,
    required String repeatDays,
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        title = Value(title),
        time = Value(time),
        repeatDays = Value(repeatDays),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Reminder> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? reminderType,
    Expression<DateTime>? time,
    Expression<String>? repeatDays,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (reminderType != null) 'reminder_type': reminderType,
      if (time != null) 'time': time,
      if (repeatDays != null) 'repeat_days': repeatDays,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? title,
      Value<String?>? description,
      Value<String?>? reminderType,
      Value<DateTime>? time,
      Value<String>? repeatDays,
      Value<bool>? isActive,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return RemindersCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      reminderType: reminderType ?? this.reminderType,
      time: time ?? this.time,
      repeatDays: repeatDays ?? this.repeatDays,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (reminderType.present) {
      map['reminder_type'] = Variable<String>(reminderType.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (repeatDays.present) {
      map['repeat_days'] = Variable<String>(repeatDays.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
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
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('reminderType: $reminderType, ')
          ..write('time: $time, ')
          ..write('repeatDays: $repeatDays, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MedicationsTable extends Medications
    with TableInfo<$MedicationsTable, Medication> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES profiles(id) ON DELETE CASCADE');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dosageMeta = const VerificationMeta('dosage');
  @override
  late final GeneratedColumn<String> dosage = GeneratedColumn<String>(
      'dosage', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
      'frequency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _effectivenessMeta =
      const VerificationMeta('effectiveness');
  @override
  late final GeneratedColumn<int> effectiveness = GeneratedColumn<int>(
      'effectiveness', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sideEffectsMeta =
      const VerificationMeta('sideEffects');
  @override
  late final GeneratedColumn<String> sideEffects = GeneratedColumn<String>(
      'side_effects', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        name,
        dosage,
        frequency,
        startDate,
        endDate,
        effectiveness,
        sideEffects,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medications';
  @override
  VerificationContext validateIntegrity(Insertable<Medication> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('dosage')) {
      context.handle(_dosageMeta,
          dosage.isAcceptableOrUnknown(data['dosage']!, _dosageMeta));
    } else if (isInserting) {
      context.missing(_dosageMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('effectiveness')) {
      context.handle(
          _effectivenessMeta,
          effectiveness.isAcceptableOrUnknown(
              data['effectiveness']!, _effectivenessMeta));
    }
    if (data.containsKey('side_effects')) {
      context.handle(
          _sideEffectsMeta,
          sideEffects.isAcceptableOrUnknown(
              data['side_effects']!, _sideEffectsMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
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
  Medication map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Medication(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      dosage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosage'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      effectiveness: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}effectiveness']),
      sideEffects: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}side_effects']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MedicationsTable createAlias(String alias) {
    return $MedicationsTable(attachedDatabase, alias);
  }
}

class Medication extends DataClass implements Insertable<Medication> {
  final String id;
  final String userId;
  final String name;
  final String dosage;
  final String frequency;
  final DateTime startDate;
  final DateTime? endDate;
  final int? effectiveness;
  final String? sideEffects;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Medication(
      {required this.id,
      required this.userId,
      required this.name,
      required this.dosage,
      required this.frequency,
      required this.startDate,
      this.endDate,
      this.effectiveness,
      this.sideEffects,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['dosage'] = Variable<String>(dosage);
    map['frequency'] = Variable<String>(frequency);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || effectiveness != null) {
      map['effectiveness'] = Variable<int>(effectiveness);
    }
    if (!nullToAbsent || sideEffects != null) {
      map['side_effects'] = Variable<String>(sideEffects);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MedicationsCompanion toCompanion(bool nullToAbsent) {
    return MedicationsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      dosage: Value(dosage),
      frequency: Value(frequency),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      effectiveness: effectiveness == null && nullToAbsent
          ? const Value.absent()
          : Value(effectiveness),
      sideEffects: sideEffects == null && nullToAbsent
          ? const Value.absent()
          : Value(sideEffects),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Medication.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Medication(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      dosage: serializer.fromJson<String>(json['dosage']),
      frequency: serializer.fromJson<String>(json['frequency']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      effectiveness: serializer.fromJson<int?>(json['effectiveness']),
      sideEffects: serializer.fromJson<String?>(json['sideEffects']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'dosage': serializer.toJson<String>(dosage),
      'frequency': serializer.toJson<String>(frequency),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'effectiveness': serializer.toJson<int?>(effectiveness),
      'sideEffects': serializer.toJson<String?>(sideEffects),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Medication copyWith(
          {String? id,
          String? userId,
          String? name,
          String? dosage,
          String? frequency,
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          Value<int?> effectiveness = const Value.absent(),
          Value<String?> sideEffects = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Medication(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        dosage: dosage ?? this.dosage,
        frequency: frequency ?? this.frequency,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        effectiveness:
            effectiveness.present ? effectiveness.value : this.effectiveness,
        sideEffects: sideEffects.present ? sideEffects.value : this.sideEffects,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Medication copyWithCompanion(MedicationsCompanion data) {
    return Medication(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      dosage: data.dosage.present ? data.dosage.value : this.dosage,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      effectiveness: data.effectiveness.present
          ? data.effectiveness.value
          : this.effectiveness,
      sideEffects:
          data.sideEffects.present ? data.sideEffects.value : this.sideEffects,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Medication(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('effectiveness: $effectiveness, ')
          ..write('sideEffects: $sideEffects, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      name,
      dosage,
      frequency,
      startDate,
      endDate,
      effectiveness,
      sideEffects,
      notes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Medication &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.dosage == this.dosage &&
          other.frequency == this.frequency &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.effectiveness == this.effectiveness &&
          other.sideEffects == this.sideEffects &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MedicationsCompanion extends UpdateCompanion<Medication> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String> dosage;
  final Value<String> frequency;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<int?> effectiveness;
  final Value<String?> sideEffects;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MedicationsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.dosage = const Value.absent(),
    this.frequency = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.effectiveness = const Value.absent(),
    this.sideEffects = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicationsCompanion.insert({
    required String id,
    required String userId,
    required String name,
    required String dosage,
    required String frequency,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.effectiveness = const Value.absent(),
    this.sideEffects = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        name = Value(name),
        dosage = Value(dosage),
        frequency = Value(frequency),
        startDate = Value(startDate),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Medication> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? dosage,
    Expression<String>? frequency,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? effectiveness,
    Expression<String>? sideEffects,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (dosage != null) 'dosage': dosage,
      if (frequency != null) 'frequency': frequency,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (effectiveness != null) 'effectiveness': effectiveness,
      if (sideEffects != null) 'side_effects': sideEffects,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? name,
      Value<String>? dosage,
      Value<String>? frequency,
      Value<DateTime>? startDate,
      Value<DateTime?>? endDate,
      Value<int?>? effectiveness,
      Value<String?>? sideEffects,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return MedicationsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      effectiveness: effectiveness ?? this.effectiveness,
      sideEffects: sideEffects ?? this.sideEffects,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dosage.present) {
      map['dosage'] = Variable<String>(dosage.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (effectiveness.present) {
      map['effectiveness'] = Variable<int>(effectiveness.value);
    }
    if (sideEffects.present) {
      map['side_effects'] = Variable<String>(sideEffects.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('MedicationsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('effectiveness: $effectiveness, ')
          ..write('sideEffects: $sideEffects, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhotosTable extends Photos with TableInfo<$PhotosTable, Photo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES profiles(id) ON DELETE CASCADE');
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyPartMeta =
      const VerificationMeta('bodyPart');
  @override
  late final GeneratedColumn<String> bodyPart = GeneratedColumn<String>(
      'body_part', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itchIntensityMeta =
      const VerificationMeta('itchIntensity');
  @override
  late final GeneratedColumn<int> itchIntensity = GeneratedColumn<int>(
      'itch_intensity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        imageUrl,
        bodyPart,
        itchIntensity,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photos';
  @override
  VerificationContext validateIntegrity(Insertable<Photo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('body_part')) {
      context.handle(_bodyPartMeta,
          bodyPart.isAcceptableOrUnknown(data['body_part']!, _bodyPartMeta));
    } else if (isInserting) {
      context.missing(_bodyPartMeta);
    }
    if (data.containsKey('itch_intensity')) {
      context.handle(
          _itchIntensityMeta,
          itchIntensity.isAcceptableOrUnknown(
              data['itch_intensity']!, _itchIntensityMeta));
    } else if (isInserting) {
      context.missing(_itchIntensityMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
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
  Photo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Photo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      bodyPart: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body_part'])!,
      itchIntensity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}itch_intensity'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PhotosTable createAlias(String alias) {
    return $PhotosTable(attachedDatabase, alias);
  }
}

class Photo extends DataClass implements Insertable<Photo> {
  final String id;
  final String userId;
  final String imageUrl;
  final String bodyPart;
  final int itchIntensity;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Photo(
      {required this.id,
      required this.userId,
      required this.imageUrl,
      required this.bodyPart,
      required this.itchIntensity,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['image_url'] = Variable<String>(imageUrl);
    map['body_part'] = Variable<String>(bodyPart);
    map['itch_intensity'] = Variable<int>(itchIntensity);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PhotosCompanion toCompanion(bool nullToAbsent) {
    return PhotosCompanion(
      id: Value(id),
      userId: Value(userId),
      imageUrl: Value(imageUrl),
      bodyPart: Value(bodyPart),
      itchIntensity: Value(itchIntensity),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Photo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Photo(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      bodyPart: serializer.fromJson<String>(json['bodyPart']),
      itchIntensity: serializer.fromJson<int>(json['itchIntensity']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'bodyPart': serializer.toJson<String>(bodyPart),
      'itchIntensity': serializer.toJson<int>(itchIntensity),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Photo copyWith(
          {String? id,
          String? userId,
          String? imageUrl,
          String? bodyPart,
          int? itchIntensity,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Photo(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        imageUrl: imageUrl ?? this.imageUrl,
        bodyPart: bodyPart ?? this.bodyPart,
        itchIntensity: itchIntensity ?? this.itchIntensity,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Photo copyWithCompanion(PhotosCompanion data) {
    return Photo(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      bodyPart: data.bodyPart.present ? data.bodyPart.value : this.bodyPart,
      itchIntensity: data.itchIntensity.present
          ? data.itchIntensity.value
          : this.itchIntensity,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Photo(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('bodyPart: $bodyPart, ')
          ..write('itchIntensity: $itchIntensity, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, imageUrl, bodyPart, itchIntensity,
      notes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Photo &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.imageUrl == this.imageUrl &&
          other.bodyPart == this.bodyPart &&
          other.itchIntensity == this.itchIntensity &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PhotosCompanion extends UpdateCompanion<Photo> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> imageUrl;
  final Value<String> bodyPart;
  final Value<int> itchIntensity;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PhotosCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.bodyPart = const Value.absent(),
    this.itchIntensity = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotosCompanion.insert({
    required String id,
    required String userId,
    required String imageUrl,
    required String bodyPart,
    required int itchIntensity,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        imageUrl = Value(imageUrl),
        bodyPart = Value(bodyPart),
        itchIntensity = Value(itchIntensity),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Photo> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? imageUrl,
    Expression<String>? bodyPart,
    Expression<int>? itchIntensity,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (imageUrl != null) 'image_url': imageUrl,
      if (bodyPart != null) 'body_part': bodyPart,
      if (itchIntensity != null) 'itch_intensity': itchIntensity,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotosCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? imageUrl,
      Value<String>? bodyPart,
      Value<int>? itchIntensity,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return PhotosCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      bodyPart: bodyPart ?? this.bodyPart,
      itchIntensity: itchIntensity ?? this.itchIntensity,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (bodyPart.present) {
      map['body_part'] = Variable<String>(bodyPart.value);
    }
    if (itchIntensity.present) {
      map['itch_intensity'] = Variable<int>(itchIntensity.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('PhotosCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('bodyPart: $bodyPart, ')
          ..write('itchIntensity: $itchIntensity, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LifestyleEntriesTable extends LifestyleEntries
    with TableInfo<$LifestyleEntriesTable, LifestyleEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LifestyleEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES profiles(id) ON DELETE CASCADE');
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _foodsConsumedMeta =
      const VerificationMeta('foodsConsumed');
  @override
  late final GeneratedColumn<String> foodsConsumed = GeneratedColumn<String>(
      'foods_consumed', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _potentialTriggerFoodsMeta =
      const VerificationMeta('potentialTriggerFoods');
  @override
  late final GeneratedColumn<String> potentialTriggerFoods =
      GeneratedColumn<String>('potential_trigger_foods', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sleepHoursMeta =
      const VerificationMeta('sleepHours');
  @override
  late final GeneratedColumn<int> sleepHours = GeneratedColumn<int>(
      'sleep_hours', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sleepQualityMeta =
      const VerificationMeta('sleepQuality');
  @override
  late final GeneratedColumn<int> sleepQuality = GeneratedColumn<int>(
      'sleep_quality', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _stressLevelMeta =
      const VerificationMeta('stressLevel');
  @override
  late final GeneratedColumn<int> stressLevel = GeneratedColumn<int>(
      'stress_level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _waterIntakeLitersMeta =
      const VerificationMeta('waterIntakeLiters');
  @override
  late final GeneratedColumn<double> waterIntakeLiters =
      GeneratedColumn<double>('water_intake_liters', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _exerciseMinutesMeta =
      const VerificationMeta('exerciseMinutes');
  @override
  late final GeneratedColumn<int> exerciseMinutes = GeneratedColumn<int>(
      'exercise_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        date,
        foodsConsumed,
        potentialTriggerFoods,
        sleepHours,
        sleepQuality,
        stressLevel,
        waterIntakeLiters,
        exerciseMinutes,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lifestyle_entries';
  @override
  VerificationContext validateIntegrity(Insertable<LifestyleEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('foods_consumed')) {
      context.handle(
          _foodsConsumedMeta,
          foodsConsumed.isAcceptableOrUnknown(
              data['foods_consumed']!, _foodsConsumedMeta));
    } else if (isInserting) {
      context.missing(_foodsConsumedMeta);
    }
    if (data.containsKey('potential_trigger_foods')) {
      context.handle(
          _potentialTriggerFoodsMeta,
          potentialTriggerFoods.isAcceptableOrUnknown(
              data['potential_trigger_foods']!, _potentialTriggerFoodsMeta));
    } else if (isInserting) {
      context.missing(_potentialTriggerFoodsMeta);
    }
    if (data.containsKey('sleep_hours')) {
      context.handle(
          _sleepHoursMeta,
          sleepHours.isAcceptableOrUnknown(
              data['sleep_hours']!, _sleepHoursMeta));
    } else if (isInserting) {
      context.missing(_sleepHoursMeta);
    }
    if (data.containsKey('sleep_quality')) {
      context.handle(
          _sleepQualityMeta,
          sleepQuality.isAcceptableOrUnknown(
              data['sleep_quality']!, _sleepQualityMeta));
    } else if (isInserting) {
      context.missing(_sleepQualityMeta);
    }
    if (data.containsKey('stress_level')) {
      context.handle(
          _stressLevelMeta,
          stressLevel.isAcceptableOrUnknown(
              data['stress_level']!, _stressLevelMeta));
    } else if (isInserting) {
      context.missing(_stressLevelMeta);
    }
    if (data.containsKey('water_intake_liters')) {
      context.handle(
          _waterIntakeLitersMeta,
          waterIntakeLiters.isAcceptableOrUnknown(
              data['water_intake_liters']!, _waterIntakeLitersMeta));
    } else if (isInserting) {
      context.missing(_waterIntakeLitersMeta);
    }
    if (data.containsKey('exercise_minutes')) {
      context.handle(
          _exerciseMinutesMeta,
          exerciseMinutes.isAcceptableOrUnknown(
              data['exercise_minutes']!, _exerciseMinutesMeta));
    } else if (isInserting) {
      context.missing(_exerciseMinutesMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
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
  LifestyleEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LifestyleEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      foodsConsumed: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}foods_consumed'])!,
      potentialTriggerFoods: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}potential_trigger_foods'])!,
      sleepHours: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sleep_hours'])!,
      sleepQuality: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sleep_quality'])!,
      stressLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stress_level'])!,
      waterIntakeLiters: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}water_intake_liters'])!,
      exerciseMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_minutes'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LifestyleEntriesTable createAlias(String alias) {
    return $LifestyleEntriesTable(attachedDatabase, alias);
  }
}

class LifestyleEntry extends DataClass implements Insertable<LifestyleEntry> {
  final String id;
  final String userId;
  final DateTime date;
  final String foodsConsumed;
  final String potentialTriggerFoods;
  final int sleepHours;
  final int sleepQuality;
  final int stressLevel;
  final double waterIntakeLiters;
  final int exerciseMinutes;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LifestyleEntry(
      {required this.id,
      required this.userId,
      required this.date,
      required this.foodsConsumed,
      required this.potentialTriggerFoods,
      required this.sleepHours,
      required this.sleepQuality,
      required this.stressLevel,
      required this.waterIntakeLiters,
      required this.exerciseMinutes,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['date'] = Variable<DateTime>(date);
    map['foods_consumed'] = Variable<String>(foodsConsumed);
    map['potential_trigger_foods'] = Variable<String>(potentialTriggerFoods);
    map['sleep_hours'] = Variable<int>(sleepHours);
    map['sleep_quality'] = Variable<int>(sleepQuality);
    map['stress_level'] = Variable<int>(stressLevel);
    map['water_intake_liters'] = Variable<double>(waterIntakeLiters);
    map['exercise_minutes'] = Variable<int>(exerciseMinutes);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LifestyleEntriesCompanion toCompanion(bool nullToAbsent) {
    return LifestyleEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      date: Value(date),
      foodsConsumed: Value(foodsConsumed),
      potentialTriggerFoods: Value(potentialTriggerFoods),
      sleepHours: Value(sleepHours),
      sleepQuality: Value(sleepQuality),
      stressLevel: Value(stressLevel),
      waterIntakeLiters: Value(waterIntakeLiters),
      exerciseMinutes: Value(exerciseMinutes),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LifestyleEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LifestyleEntry(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<DateTime>(json['date']),
      foodsConsumed: serializer.fromJson<String>(json['foodsConsumed']),
      potentialTriggerFoods:
          serializer.fromJson<String>(json['potentialTriggerFoods']),
      sleepHours: serializer.fromJson<int>(json['sleepHours']),
      sleepQuality: serializer.fromJson<int>(json['sleepQuality']),
      stressLevel: serializer.fromJson<int>(json['stressLevel']),
      waterIntakeLiters: serializer.fromJson<double>(json['waterIntakeLiters']),
      exerciseMinutes: serializer.fromJson<int>(json['exerciseMinutes']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<DateTime>(date),
      'foodsConsumed': serializer.toJson<String>(foodsConsumed),
      'potentialTriggerFoods': serializer.toJson<String>(potentialTriggerFoods),
      'sleepHours': serializer.toJson<int>(sleepHours),
      'sleepQuality': serializer.toJson<int>(sleepQuality),
      'stressLevel': serializer.toJson<int>(stressLevel),
      'waterIntakeLiters': serializer.toJson<double>(waterIntakeLiters),
      'exerciseMinutes': serializer.toJson<int>(exerciseMinutes),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LifestyleEntry copyWith(
          {String? id,
          String? userId,
          DateTime? date,
          String? foodsConsumed,
          String? potentialTriggerFoods,
          int? sleepHours,
          int? sleepQuality,
          int? stressLevel,
          double? waterIntakeLiters,
          int? exerciseMinutes,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LifestyleEntry(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        date: date ?? this.date,
        foodsConsumed: foodsConsumed ?? this.foodsConsumed,
        potentialTriggerFoods:
            potentialTriggerFoods ?? this.potentialTriggerFoods,
        sleepHours: sleepHours ?? this.sleepHours,
        sleepQuality: sleepQuality ?? this.sleepQuality,
        stressLevel: stressLevel ?? this.stressLevel,
        waterIntakeLiters: waterIntakeLiters ?? this.waterIntakeLiters,
        exerciseMinutes: exerciseMinutes ?? this.exerciseMinutes,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LifestyleEntry copyWithCompanion(LifestyleEntriesCompanion data) {
    return LifestyleEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      foodsConsumed: data.foodsConsumed.present
          ? data.foodsConsumed.value
          : this.foodsConsumed,
      potentialTriggerFoods: data.potentialTriggerFoods.present
          ? data.potentialTriggerFoods.value
          : this.potentialTriggerFoods,
      sleepHours:
          data.sleepHours.present ? data.sleepHours.value : this.sleepHours,
      sleepQuality: data.sleepQuality.present
          ? data.sleepQuality.value
          : this.sleepQuality,
      stressLevel:
          data.stressLevel.present ? data.stressLevel.value : this.stressLevel,
      waterIntakeLiters: data.waterIntakeLiters.present
          ? data.waterIntakeLiters.value
          : this.waterIntakeLiters,
      exerciseMinutes: data.exerciseMinutes.present
          ? data.exerciseMinutes.value
          : this.exerciseMinutes,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LifestyleEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('foodsConsumed: $foodsConsumed, ')
          ..write('potentialTriggerFoods: $potentialTriggerFoods, ')
          ..write('sleepHours: $sleepHours, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('stressLevel: $stressLevel, ')
          ..write('waterIntakeLiters: $waterIntakeLiters, ')
          ..write('exerciseMinutes: $exerciseMinutes, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      date,
      foodsConsumed,
      potentialTriggerFoods,
      sleepHours,
      sleepQuality,
      stressLevel,
      waterIntakeLiters,
      exerciseMinutes,
      notes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LifestyleEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.foodsConsumed == this.foodsConsumed &&
          other.potentialTriggerFoods == this.potentialTriggerFoods &&
          other.sleepHours == this.sleepHours &&
          other.sleepQuality == this.sleepQuality &&
          other.stressLevel == this.stressLevel &&
          other.waterIntakeLiters == this.waterIntakeLiters &&
          other.exerciseMinutes == this.exerciseMinutes &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LifestyleEntriesCompanion extends UpdateCompanion<LifestyleEntry> {
  final Value<String> id;
  final Value<String> userId;
  final Value<DateTime> date;
  final Value<String> foodsConsumed;
  final Value<String> potentialTriggerFoods;
  final Value<int> sleepHours;
  final Value<int> sleepQuality;
  final Value<int> stressLevel;
  final Value<double> waterIntakeLiters;
  final Value<int> exerciseMinutes;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LifestyleEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.foodsConsumed = const Value.absent(),
    this.potentialTriggerFoods = const Value.absent(),
    this.sleepHours = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.stressLevel = const Value.absent(),
    this.waterIntakeLiters = const Value.absent(),
    this.exerciseMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LifestyleEntriesCompanion.insert({
    required String id,
    required String userId,
    required DateTime date,
    required String foodsConsumed,
    required String potentialTriggerFoods,
    required int sleepHours,
    required int sleepQuality,
    required int stressLevel,
    required double waterIntakeLiters,
    required int exerciseMinutes,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        date = Value(date),
        foodsConsumed = Value(foodsConsumed),
        potentialTriggerFoods = Value(potentialTriggerFoods),
        sleepHours = Value(sleepHours),
        sleepQuality = Value(sleepQuality),
        stressLevel = Value(stressLevel),
        waterIntakeLiters = Value(waterIntakeLiters),
        exerciseMinutes = Value(exerciseMinutes),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<LifestyleEntry> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? date,
    Expression<String>? foodsConsumed,
    Expression<String>? potentialTriggerFoods,
    Expression<int>? sleepHours,
    Expression<int>? sleepQuality,
    Expression<int>? stressLevel,
    Expression<double>? waterIntakeLiters,
    Expression<int>? exerciseMinutes,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (foodsConsumed != null) 'foods_consumed': foodsConsumed,
      if (potentialTriggerFoods != null)
        'potential_trigger_foods': potentialTriggerFoods,
      if (sleepHours != null) 'sleep_hours': sleepHours,
      if (sleepQuality != null) 'sleep_quality': sleepQuality,
      if (stressLevel != null) 'stress_level': stressLevel,
      if (waterIntakeLiters != null) 'water_intake_liters': waterIntakeLiters,
      if (exerciseMinutes != null) 'exercise_minutes': exerciseMinutes,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LifestyleEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<DateTime>? date,
      Value<String>? foodsConsumed,
      Value<String>? potentialTriggerFoods,
      Value<int>? sleepHours,
      Value<int>? sleepQuality,
      Value<int>? stressLevel,
      Value<double>? waterIntakeLiters,
      Value<int>? exerciseMinutes,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LifestyleEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      foodsConsumed: foodsConsumed ?? this.foodsConsumed,
      potentialTriggerFoods:
          potentialTriggerFoods ?? this.potentialTriggerFoods,
      sleepHours: sleepHours ?? this.sleepHours,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      stressLevel: stressLevel ?? this.stressLevel,
      waterIntakeLiters: waterIntakeLiters ?? this.waterIntakeLiters,
      exerciseMinutes: exerciseMinutes ?? this.exerciseMinutes,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (foodsConsumed.present) {
      map['foods_consumed'] = Variable<String>(foodsConsumed.value);
    }
    if (potentialTriggerFoods.present) {
      map['potential_trigger_foods'] =
          Variable<String>(potentialTriggerFoods.value);
    }
    if (sleepHours.present) {
      map['sleep_hours'] = Variable<int>(sleepHours.value);
    }
    if (sleepQuality.present) {
      map['sleep_quality'] = Variable<int>(sleepQuality.value);
    }
    if (stressLevel.present) {
      map['stress_level'] = Variable<int>(stressLevel.value);
    }
    if (waterIntakeLiters.present) {
      map['water_intake_liters'] = Variable<double>(waterIntakeLiters.value);
    }
    if (exerciseMinutes.present) {
      map['exercise_minutes'] = Variable<int>(exerciseMinutes.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('LifestyleEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('foodsConsumed: $foodsConsumed, ')
          ..write('potentialTriggerFoods: $potentialTriggerFoods, ')
          ..write('sleepHours: $sleepHours, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('stressLevel: $stressLevel, ')
          ..write('waterIntakeLiters: $waterIntakeLiters, ')
          ..write('exerciseMinutes: $exerciseMinutes, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SymptomEntriesTable extends SymptomEntries
    with TableInfo<$SymptomEntriesTable, SymptomEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES profiles(id) ON DELETE CASCADE');
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isFlareupMeta =
      const VerificationMeta('isFlareup');
  @override
  late final GeneratedColumn<bool> isFlareup = GeneratedColumn<bool>(
      'is_flareup', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_flareup" IN (0, 1))'));
  static const VerificationMeta _severityMeta =
      const VerificationMeta('severity');
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
      'severity', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _affectedAreasMeta =
      const VerificationMeta('affectedAreas');
  @override
  late final GeneratedColumn<String> affectedAreas = GeneratedColumn<String>(
      'affected_areas', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _symptomsMeta =
      const VerificationMeta('symptoms');
  @override
  late final GeneratedColumn<String> symptoms = GeneratedColumn<String>(
      'symptoms', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        date,
        isFlareup,
        severity,
        affectedAreas,
        symptoms,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptom_entries';
  @override
  VerificationContext validateIntegrity(Insertable<SymptomEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('is_flareup')) {
      context.handle(_isFlareupMeta,
          isFlareup.isAcceptableOrUnknown(data['is_flareup']!, _isFlareupMeta));
    } else if (isInserting) {
      context.missing(_isFlareupMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(_severityMeta,
          severity.isAcceptableOrUnknown(data['severity']!, _severityMeta));
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('affected_areas')) {
      context.handle(
          _affectedAreasMeta,
          affectedAreas.isAcceptableOrUnknown(
              data['affected_areas']!, _affectedAreasMeta));
    } else if (isInserting) {
      context.missing(_affectedAreasMeta);
    }
    if (data.containsKey('symptoms')) {
      context.handle(_symptomsMeta,
          symptoms.isAcceptableOrUnknown(data['symptoms']!, _symptomsMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
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
  SymptomEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SymptomEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      isFlareup: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_flareup'])!,
      severity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}severity'])!,
      affectedAreas: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}affected_areas'])!,
      symptoms: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symptoms']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SymptomEntriesTable createAlias(String alias) {
    return $SymptomEntriesTable(attachedDatabase, alias);
  }
}

class SymptomEntry extends DataClass implements Insertable<SymptomEntry> {
  final String id;
  final String userId;
  final DateTime date;
  final bool isFlareup;
  final String severity;
  final String affectedAreas;
  final String? symptoms;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SymptomEntry(
      {required this.id,
      required this.userId,
      required this.date,
      required this.isFlareup,
      required this.severity,
      required this.affectedAreas,
      this.symptoms,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['date'] = Variable<DateTime>(date);
    map['is_flareup'] = Variable<bool>(isFlareup);
    map['severity'] = Variable<String>(severity);
    map['affected_areas'] = Variable<String>(affectedAreas);
    if (!nullToAbsent || symptoms != null) {
      map['symptoms'] = Variable<String>(symptoms);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SymptomEntriesCompanion toCompanion(bool nullToAbsent) {
    return SymptomEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      date: Value(date),
      isFlareup: Value(isFlareup),
      severity: Value(severity),
      affectedAreas: Value(affectedAreas),
      symptoms: symptoms == null && nullToAbsent
          ? const Value.absent()
          : Value(symptoms),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SymptomEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SymptomEntry(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<DateTime>(json['date']),
      isFlareup: serializer.fromJson<bool>(json['isFlareup']),
      severity: serializer.fromJson<String>(json['severity']),
      affectedAreas: serializer.fromJson<String>(json['affectedAreas']),
      symptoms: serializer.fromJson<String?>(json['symptoms']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<DateTime>(date),
      'isFlareup': serializer.toJson<bool>(isFlareup),
      'severity': serializer.toJson<String>(severity),
      'affectedAreas': serializer.toJson<String>(affectedAreas),
      'symptoms': serializer.toJson<String?>(symptoms),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SymptomEntry copyWith(
          {String? id,
          String? userId,
          DateTime? date,
          bool? isFlareup,
          String? severity,
          String? affectedAreas,
          Value<String?> symptoms = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      SymptomEntry(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        date: date ?? this.date,
        isFlareup: isFlareup ?? this.isFlareup,
        severity: severity ?? this.severity,
        affectedAreas: affectedAreas ?? this.affectedAreas,
        symptoms: symptoms.present ? symptoms.value : this.symptoms,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SymptomEntry copyWithCompanion(SymptomEntriesCompanion data) {
    return SymptomEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      isFlareup: data.isFlareup.present ? data.isFlareup.value : this.isFlareup,
      severity: data.severity.present ? data.severity.value : this.severity,
      affectedAreas: data.affectedAreas.present
          ? data.affectedAreas.value
          : this.affectedAreas,
      symptoms: data.symptoms.present ? data.symptoms.value : this.symptoms,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SymptomEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('isFlareup: $isFlareup, ')
          ..write('severity: $severity, ')
          ..write('affectedAreas: $affectedAreas, ')
          ..write('symptoms: $symptoms, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, date, isFlareup, severity,
      affectedAreas, symptoms, notes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.isFlareup == this.isFlareup &&
          other.severity == this.severity &&
          other.affectedAreas == this.affectedAreas &&
          other.symptoms == this.symptoms &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SymptomEntriesCompanion extends UpdateCompanion<SymptomEntry> {
  final Value<String> id;
  final Value<String> userId;
  final Value<DateTime> date;
  final Value<bool> isFlareup;
  final Value<String> severity;
  final Value<String> affectedAreas;
  final Value<String?> symptoms;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SymptomEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.isFlareup = const Value.absent(),
    this.severity = const Value.absent(),
    this.affectedAreas = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SymptomEntriesCompanion.insert({
    required String id,
    required String userId,
    required DateTime date,
    required bool isFlareup,
    required String severity,
    required String affectedAreas,
    this.symptoms = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        date = Value(date),
        isFlareup = Value(isFlareup),
        severity = Value(severity),
        affectedAreas = Value(affectedAreas),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<SymptomEntry> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? date,
    Expression<bool>? isFlareup,
    Expression<String>? severity,
    Expression<String>? affectedAreas,
    Expression<String>? symptoms,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (isFlareup != null) 'is_flareup': isFlareup,
      if (severity != null) 'severity': severity,
      if (affectedAreas != null) 'affected_areas': affectedAreas,
      if (symptoms != null) 'symptoms': symptoms,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SymptomEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<DateTime>? date,
      Value<bool>? isFlareup,
      Value<String>? severity,
      Value<String>? affectedAreas,
      Value<String?>? symptoms,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return SymptomEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      isFlareup: isFlareup ?? this.isFlareup,
      severity: severity ?? this.severity,
      affectedAreas: affectedAreas ?? this.affectedAreas,
      symptoms: symptoms ?? this.symptoms,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (isFlareup.present) {
      map['is_flareup'] = Variable<bool>(isFlareup.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (affectedAreas.present) {
      map['affected_areas'] = Variable<String>(affectedAreas.value);
    }
    if (symptoms.present) {
      map['symptoms'] = Variable<String>(symptoms.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('SymptomEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('isFlareup: $isFlareup, ')
          ..write('severity: $severity, ')
          ..write('affectedAreas: $affectedAreas, ')
          ..write('symptoms: $symptoms, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TreatmentsTable extends Treatments
    with TableInfo<$TreatmentsTable, Treatment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TreatmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES profiles(id) ON DELETE CASCADE');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
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
      [id, userId, name, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'treatments';
  @override
  VerificationContext validateIntegrity(Insertable<Treatment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
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
  Treatment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Treatment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TreatmentsTable createAlias(String alias) {
    return $TreatmentsTable(attachedDatabase, alias);
  }
}

class Treatment extends DataClass implements Insertable<Treatment> {
  final String id;
  final String userId;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Treatment(
      {required this.id,
      required this.userId,
      required this.name,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TreatmentsCompanion toCompanion(bool nullToAbsent) {
    return TreatmentsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Treatment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Treatment(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Treatment copyWith(
          {String? id,
          String? userId,
          String? name,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Treatment(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Treatment copyWithCompanion(TreatmentsCompanion data) {
    return Treatment(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Treatment(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, name, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Treatment &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TreatmentsCompanion extends UpdateCompanion<Treatment> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TreatmentsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TreatmentsCompanion.insert({
    required String id,
    required String userId,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Treatment> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TreatmentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? name,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return TreatmentsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
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
    return (StringBuffer('TreatmentsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SymptomTreatmentLinksTable extends SymptomTreatmentLinks
    with TableInfo<$SymptomTreatmentLinksTable, SymptomTreatmentLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomTreatmentLinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _symptomIdMeta =
      const VerificationMeta('symptomId');
  @override
  late final GeneratedColumn<String> symptomId = GeneratedColumn<String>(
      'symptom_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES symptom_entries(id) ON DELETE CASCADE');
  static const VerificationMeta _treatmentIdMeta =
      const VerificationMeta('treatmentId');
  @override
  late final GeneratedColumn<String> treatmentId = GeneratedColumn<String>(
      'treatment_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES treatments(id) ON DELETE CASCADE');
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES profiles(id) ON DELETE CASCADE');
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, symptomId, treatmentId, userId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptom_treatment_links';
  @override
  VerificationContext validateIntegrity(
      Insertable<SymptomTreatmentLink> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('symptom_id')) {
      context.handle(_symptomIdMeta,
          symptomId.isAcceptableOrUnknown(data['symptom_id']!, _symptomIdMeta));
    } else if (isInserting) {
      context.missing(_symptomIdMeta);
    }
    if (data.containsKey('treatment_id')) {
      context.handle(
          _treatmentIdMeta,
          treatmentId.isAcceptableOrUnknown(
              data['treatment_id']!, _treatmentIdMeta));
    } else if (isInserting) {
      context.missing(_treatmentIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SymptomTreatmentLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SymptomTreatmentLink(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      symptomId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symptom_id'])!,
      treatmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}treatment_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SymptomTreatmentLinksTable createAlias(String alias) {
    return $SymptomTreatmentLinksTable(attachedDatabase, alias);
  }
}

class SymptomTreatmentLink extends DataClass
    implements Insertable<SymptomTreatmentLink> {
  final String id;
  final String symptomId;
  final String treatmentId;
  final String userId;
  final DateTime createdAt;
  const SymptomTreatmentLink(
      {required this.id,
      required this.symptomId,
      required this.treatmentId,
      required this.userId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['symptom_id'] = Variable<String>(symptomId);
    map['treatment_id'] = Variable<String>(treatmentId);
    map['user_id'] = Variable<String>(userId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SymptomTreatmentLinksCompanion toCompanion(bool nullToAbsent) {
    return SymptomTreatmentLinksCompanion(
      id: Value(id),
      symptomId: Value(symptomId),
      treatmentId: Value(treatmentId),
      userId: Value(userId),
      createdAt: Value(createdAt),
    );
  }

  factory SymptomTreatmentLink.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SymptomTreatmentLink(
      id: serializer.fromJson<String>(json['id']),
      symptomId: serializer.fromJson<String>(json['symptomId']),
      treatmentId: serializer.fromJson<String>(json['treatmentId']),
      userId: serializer.fromJson<String>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'symptomId': serializer.toJson<String>(symptomId),
      'treatmentId': serializer.toJson<String>(treatmentId),
      'userId': serializer.toJson<String>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SymptomTreatmentLink copyWith(
          {String? id,
          String? symptomId,
          String? treatmentId,
          String? userId,
          DateTime? createdAt}) =>
      SymptomTreatmentLink(
        id: id ?? this.id,
        symptomId: symptomId ?? this.symptomId,
        treatmentId: treatmentId ?? this.treatmentId,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
      );
  SymptomTreatmentLink copyWithCompanion(SymptomTreatmentLinksCompanion data) {
    return SymptomTreatmentLink(
      id: data.id.present ? data.id.value : this.id,
      symptomId: data.symptomId.present ? data.symptomId.value : this.symptomId,
      treatmentId:
          data.treatmentId.present ? data.treatmentId.value : this.treatmentId,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SymptomTreatmentLink(')
          ..write('id: $id, ')
          ..write('symptomId: $symptomId, ')
          ..write('treatmentId: $treatmentId, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, symptomId, treatmentId, userId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomTreatmentLink &&
          other.id == this.id &&
          other.symptomId == this.symptomId &&
          other.treatmentId == this.treatmentId &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt);
}

class SymptomTreatmentLinksCompanion
    extends UpdateCompanion<SymptomTreatmentLink> {
  final Value<String> id;
  final Value<String> symptomId;
  final Value<String> treatmentId;
  final Value<String> userId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SymptomTreatmentLinksCompanion({
    this.id = const Value.absent(),
    this.symptomId = const Value.absent(),
    this.treatmentId = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SymptomTreatmentLinksCompanion.insert({
    required String id,
    required String symptomId,
    required String treatmentId,
    required String userId,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        symptomId = Value(symptomId),
        treatmentId = Value(treatmentId),
        userId = Value(userId),
        createdAt = Value(createdAt);
  static Insertable<SymptomTreatmentLink> custom({
    Expression<String>? id,
    Expression<String>? symptomId,
    Expression<String>? treatmentId,
    Expression<String>? userId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symptomId != null) 'symptom_id': symptomId,
      if (treatmentId != null) 'treatment_id': treatmentId,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SymptomTreatmentLinksCompanion copyWith(
      {Value<String>? id,
      Value<String>? symptomId,
      Value<String>? treatmentId,
      Value<String>? userId,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SymptomTreatmentLinksCompanion(
      id: id ?? this.id,
      symptomId: symptomId ?? this.symptomId,
      treatmentId: treatmentId ?? this.treatmentId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (symptomId.present) {
      map['symptom_id'] = Variable<String>(symptomId.value);
    }
    if (treatmentId.present) {
      map['treatment_id'] = Variable<String>(treatmentId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomTreatmentLinksCompanion(')
          ..write('id: $id, ')
          ..write('symptomId: $symptomId, ')
          ..write('treatmentId: $treatmentId, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $MedicationsTable medications = $MedicationsTable(this);
  late final $PhotosTable photos = $PhotosTable(this);
  late final $LifestyleEntriesTable lifestyleEntries =
      $LifestyleEntriesTable(this);
  late final $SymptomEntriesTable symptomEntries = $SymptomEntriesTable(this);
  late final $TreatmentsTable treatments = $TreatmentsTable(this);
  late final $SymptomTreatmentLinksTable symptomTreatmentLinks =
      $SymptomTreatmentLinksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        profiles,
        reminders,
        medications,
        photos,
        lifestyleEntries,
        symptomEntries,
        treatments,
        symptomTreatmentLinks
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('profiles',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('reminders', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('profiles',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('medications', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('profiles',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('photos', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('profiles',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('lifestyle_entries', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('profiles',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('symptom_entries', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('profiles',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('treatments', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('symptom_entries',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('symptom_treatment_links', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('treatments',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('symptom_treatment_links', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('profiles',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('symptom_treatment_links', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$ProfilesTableCreateCompanionBuilder = ProfilesCompanion Function({
  required String id,
  required String email,
  required String displayName,
  required String firstName,
  required String lastName,
  Value<String?> avatarUrl,
  required DateTime dateOfBirth,
  required String knownAllergies,
  required String medicalNotes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ProfilesTableUpdateCompanionBuilder = ProfilesCompanion Function({
  Value<String> id,
  Value<String> email,
  Value<String> displayName,
  Value<String> firstName,
  Value<String> lastName,
  Value<String?> avatarUrl,
  Value<DateTime> dateOfBirth,
  Value<String> knownAllergies,
  Value<String> medicalNotes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$ProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $ProfilesTable, Profile> {
  $$ProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RemindersTable, List<Reminder>>
      _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.reminders,
          aliasName: $_aliasNameGenerator(db.profiles.id, db.reminders.userId));

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager($_db, $_db.reminders)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MedicationsTable, List<Medication>>
      _medicationsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.medications,
              aliasName:
                  $_aliasNameGenerator(db.profiles.id, db.medications.userId));

  $$MedicationsTableProcessedTableManager get medicationsRefs {
    final manager = $$MedicationsTableTableManager($_db, $_db.medications)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_medicationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PhotosTable, List<Photo>> _photosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.photos,
          aliasName: $_aliasNameGenerator(db.profiles.id, db.photos.userId));

  $$PhotosTableProcessedTableManager get photosRefs {
    final manager = $$PhotosTableTableManager($_db, $_db.photos)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_photosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LifestyleEntriesTable, List<LifestyleEntry>>
      _lifestyleEntriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.lifestyleEntries,
              aliasName: $_aliasNameGenerator(
                  db.profiles.id, db.lifestyleEntries.userId));

  $$LifestyleEntriesTableProcessedTableManager get lifestyleEntriesRefs {
    final manager =
        $$LifestyleEntriesTableTableManager($_db, $_db.lifestyleEntries)
            .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_lifestyleEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SymptomEntriesTable, List<SymptomEntry>>
      _symptomEntriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.symptomEntries,
              aliasName: $_aliasNameGenerator(
                  db.profiles.id, db.symptomEntries.userId));

  $$SymptomEntriesTableProcessedTableManager get symptomEntriesRefs {
    final manager = $$SymptomEntriesTableTableManager($_db, $_db.symptomEntries)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_symptomEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TreatmentsTable, List<Treatment>>
      _treatmentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.treatments,
              aliasName:
                  $_aliasNameGenerator(db.profiles.id, db.treatments.userId));

  $$TreatmentsTableProcessedTableManager get treatmentsRefs {
    final manager = $$TreatmentsTableTableManager($_db, $_db.treatments)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_treatmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SymptomTreatmentLinksTable,
      List<SymptomTreatmentLink>> _symptomTreatmentLinksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.symptomTreatmentLinks,
          aliasName: $_aliasNameGenerator(
              db.profiles.id, db.symptomTreatmentLinks.userId));

  $$SymptomTreatmentLinksTableProcessedTableManager
      get symptomTreatmentLinksRefs {
    final manager = $$SymptomTreatmentLinksTableTableManager(
            $_db, $_db.symptomTreatmentLinks)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_symptomTreatmentLinksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatarUrl => $composableBuilder(
      column: $table.avatarUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get knownAllergies => $composableBuilder(
      column: $table.knownAllergies,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicalNotes => $composableBuilder(
      column: $table.medicalNotes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> remindersRefs(
      Expression<bool> Function($$RemindersTableFilterComposer f) f) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reminders,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RemindersTableFilterComposer(
              $db: $db,
              $table: $db.reminders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> medicationsRefs(
      Expression<bool> Function($$MedicationsTableFilterComposer f) f) {
    final $$MedicationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.medications,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicationsTableFilterComposer(
              $db: $db,
              $table: $db.medications,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> photosRefs(
      Expression<bool> Function($$PhotosTableFilterComposer f) f) {
    final $$PhotosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.photos,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PhotosTableFilterComposer(
              $db: $db,
              $table: $db.photos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> lifestyleEntriesRefs(
      Expression<bool> Function($$LifestyleEntriesTableFilterComposer f) f) {
    final $$LifestyleEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lifestyleEntries,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LifestyleEntriesTableFilterComposer(
              $db: $db,
              $table: $db.lifestyleEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> symptomEntriesRefs(
      Expression<bool> Function($$SymptomEntriesTableFilterComposer f) f) {
    final $$SymptomEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.symptomEntries,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SymptomEntriesTableFilterComposer(
              $db: $db,
              $table: $db.symptomEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> treatmentsRefs(
      Expression<bool> Function($$TreatmentsTableFilterComposer f) f) {
    final $$TreatmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.treatments,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TreatmentsTableFilterComposer(
              $db: $db,
              $table: $db.treatments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> symptomTreatmentLinksRefs(
      Expression<bool> Function($$SymptomTreatmentLinksTableFilterComposer f)
          f) {
    final $$SymptomTreatmentLinksTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.symptomTreatmentLinks,
            getReferencedColumn: (t) => t.userId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SymptomTreatmentLinksTableFilterComposer(
                  $db: $db,
                  $table: $db.symptomTreatmentLinks,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
      column: $table.avatarUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get knownAllergies => $composableBuilder(
      column: $table.knownAllergies,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicalNotes => $composableBuilder(
      column: $table.medicalNotes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => column);

  GeneratedColumn<String> get knownAllergies => $composableBuilder(
      column: $table.knownAllergies, builder: (column) => column);

  GeneratedColumn<String> get medicalNotes => $composableBuilder(
      column: $table.medicalNotes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> remindersRefs<T extends Object>(
      Expression<T> Function($$RemindersTableAnnotationComposer a) f) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reminders,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RemindersTableAnnotationComposer(
              $db: $db,
              $table: $db.reminders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> medicationsRefs<T extends Object>(
      Expression<T> Function($$MedicationsTableAnnotationComposer a) f) {
    final $$MedicationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.medications,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicationsTableAnnotationComposer(
              $db: $db,
              $table: $db.medications,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> photosRefs<T extends Object>(
      Expression<T> Function($$PhotosTableAnnotationComposer a) f) {
    final $$PhotosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.photos,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PhotosTableAnnotationComposer(
              $db: $db,
              $table: $db.photos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> lifestyleEntriesRefs<T extends Object>(
      Expression<T> Function($$LifestyleEntriesTableAnnotationComposer a) f) {
    final $$LifestyleEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lifestyleEntries,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LifestyleEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.lifestyleEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> symptomEntriesRefs<T extends Object>(
      Expression<T> Function($$SymptomEntriesTableAnnotationComposer a) f) {
    final $$SymptomEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.symptomEntries,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SymptomEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.symptomEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> treatmentsRefs<T extends Object>(
      Expression<T> Function($$TreatmentsTableAnnotationComposer a) f) {
    final $$TreatmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.treatments,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TreatmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.treatments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> symptomTreatmentLinksRefs<T extends Object>(
      Expression<T> Function($$SymptomTreatmentLinksTableAnnotationComposer a)
          f) {
    final $$SymptomTreatmentLinksTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.symptomTreatmentLinks,
            getReferencedColumn: (t) => t.userId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SymptomTreatmentLinksTableAnnotationComposer(
                  $db: $db,
                  $table: $db.symptomTreatmentLinks,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProfilesTable,
    Profile,
    $$ProfilesTableFilterComposer,
    $$ProfilesTableOrderingComposer,
    $$ProfilesTableAnnotationComposer,
    $$ProfilesTableCreateCompanionBuilder,
    $$ProfilesTableUpdateCompanionBuilder,
    (Profile, $$ProfilesTableReferences),
    Profile,
    PrefetchHooks Function(
        {bool remindersRefs,
        bool medicationsRefs,
        bool photosRefs,
        bool lifestyleEntriesRefs,
        bool symptomEntriesRefs,
        bool treatmentsRefs,
        bool symptomTreatmentLinksRefs})> {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<DateTime> dateOfBirth = const Value.absent(),
            Value<String> knownAllergies = const Value.absent(),
            Value<String> medicalNotes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProfilesCompanion(
            id: id,
            email: email,
            displayName: displayName,
            firstName: firstName,
            lastName: lastName,
            avatarUrl: avatarUrl,
            dateOfBirth: dateOfBirth,
            knownAllergies: knownAllergies,
            medicalNotes: medicalNotes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String email,
            required String displayName,
            required String firstName,
            required String lastName,
            Value<String?> avatarUrl = const Value.absent(),
            required DateTime dateOfBirth,
            required String knownAllergies,
            required String medicalNotes,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ProfilesCompanion.insert(
            id: id,
            email: email,
            displayName: displayName,
            firstName: firstName,
            lastName: lastName,
            avatarUrl: avatarUrl,
            dateOfBirth: dateOfBirth,
            knownAllergies: knownAllergies,
            medicalNotes: medicalNotes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ProfilesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {remindersRefs = false,
              medicationsRefs = false,
              photosRefs = false,
              lifestyleEntriesRefs = false,
              symptomEntriesRefs = false,
              treatmentsRefs = false,
              symptomTreatmentLinksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (remindersRefs) db.reminders,
                if (medicationsRefs) db.medications,
                if (photosRefs) db.photos,
                if (lifestyleEntriesRefs) db.lifestyleEntries,
                if (symptomEntriesRefs) db.symptomEntries,
                if (treatmentsRefs) db.treatments,
                if (symptomTreatmentLinksRefs) db.symptomTreatmentLinks
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (remindersRefs)
                    await $_getPrefetchedData<Profile, $ProfilesTable,
                            Reminder>(
                        currentTable: table,
                        referencedTable:
                            $$ProfilesTableReferences._remindersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProfilesTableReferences(db, table, p0)
                                .remindersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (medicationsRefs)
                    await $_getPrefetchedData<Profile, $ProfilesTable,
                            Medication>(
                        currentTable: table,
                        referencedTable:
                            $$ProfilesTableReferences._medicationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProfilesTableReferences(db, table, p0)
                                .medicationsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (photosRefs)
                    await $_getPrefetchedData<Profile, $ProfilesTable, Photo>(
                        currentTable: table,
                        referencedTable:
                            $$ProfilesTableReferences._photosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProfilesTableReferences(db, table, p0).photosRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (lifestyleEntriesRefs)
                    await $_getPrefetchedData<Profile, $ProfilesTable,
                            LifestyleEntry>(
                        currentTable: table,
                        referencedTable: $$ProfilesTableReferences
                            ._lifestyleEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProfilesTableReferences(db, table, p0)
                                .lifestyleEntriesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (symptomEntriesRefs)
                    await $_getPrefetchedData<Profile, $ProfilesTable,
                            SymptomEntry>(
                        currentTable: table,
                        referencedTable: $$ProfilesTableReferences
                            ._symptomEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProfilesTableReferences(db, table, p0)
                                .symptomEntriesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (treatmentsRefs)
                    await $_getPrefetchedData<Profile, $ProfilesTable,
                            Treatment>(
                        currentTable: table,
                        referencedTable:
                            $$ProfilesTableReferences._treatmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProfilesTableReferences(db, table, p0)
                                .treatmentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (symptomTreatmentLinksRefs)
                    await $_getPrefetchedData<Profile, $ProfilesTable,
                            SymptomTreatmentLink>(
                        currentTable: table,
                        referencedTable: $$ProfilesTableReferences
                            ._symptomTreatmentLinksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProfilesTableReferences(db, table, p0)
                                .symptomTreatmentLinksRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProfilesTable,
    Profile,
    $$ProfilesTableFilterComposer,
    $$ProfilesTableOrderingComposer,
    $$ProfilesTableAnnotationComposer,
    $$ProfilesTableCreateCompanionBuilder,
    $$ProfilesTableUpdateCompanionBuilder,
    (Profile, $$ProfilesTableReferences),
    Profile,
    PrefetchHooks Function(
        {bool remindersRefs,
        bool medicationsRefs,
        bool photosRefs,
        bool lifestyleEntriesRefs,
        bool symptomEntriesRefs,
        bool treatmentsRefs,
        bool symptomTreatmentLinksRefs})>;
typedef $$RemindersTableCreateCompanionBuilder = RemindersCompanion Function({
  required String id,
  required String userId,
  required String title,
  Value<String?> description,
  Value<String?> reminderType,
  required DateTime time,
  required String repeatDays,
  Value<bool> isActive,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$RemindersTableUpdateCompanionBuilder = RemindersCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> title,
  Value<String?> description,
  Value<String?> reminderType,
  Value<DateTime> time,
  Value<String> repeatDays,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$RemindersTableReferences
    extends BaseReferences<_$AppDatabase, $RemindersTable, Reminder> {
  $$RemindersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _userIdTable(_$AppDatabase db) => db.profiles
      .createAlias($_aliasNameGenerator(db.reminders.userId, db.profiles.id));

  $$ProfilesTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$ProfilesTableTableManager($_db, $_db.profiles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderType => $composableBuilder(
      column: $table.reminderType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get repeatDays => $composableBuilder(
      column: $table.repeatDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ProfilesTableFilterComposer get userId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableFilterComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderType => $composableBuilder(
      column: $table.reminderType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get repeatDays => $composableBuilder(
      column: $table.repeatDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ProfilesTableOrderingComposer get userId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get reminderType => $composableBuilder(
      column: $table.reminderType, builder: (column) => column);

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get repeatDays => $composableBuilder(
      column: $table.repeatDays, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get userId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RemindersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RemindersTable,
    Reminder,
    $$RemindersTableFilterComposer,
    $$RemindersTableOrderingComposer,
    $$RemindersTableAnnotationComposer,
    $$RemindersTableCreateCompanionBuilder,
    $$RemindersTableUpdateCompanionBuilder,
    (Reminder, $$RemindersTableReferences),
    Reminder,
    PrefetchHooks Function({bool userId})> {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> reminderType = const Value.absent(),
            Value<DateTime> time = const Value.absent(),
            Value<String> repeatDays = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RemindersCompanion(
            id: id,
            userId: userId,
            title: title,
            description: description,
            reminderType: reminderType,
            time: time,
            repeatDays: repeatDays,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<String?> reminderType = const Value.absent(),
            required DateTime time,
            required String repeatDays,
            Value<bool> isActive = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              RemindersCompanion.insert(
            id: id,
            userId: userId,
            title: title,
            description: description,
            reminderType: reminderType,
            time: time,
            repeatDays: repeatDays,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RemindersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$RemindersTableReferences._userIdTable(db),
                    referencedColumn:
                        $$RemindersTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RemindersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RemindersTable,
    Reminder,
    $$RemindersTableFilterComposer,
    $$RemindersTableOrderingComposer,
    $$RemindersTableAnnotationComposer,
    $$RemindersTableCreateCompanionBuilder,
    $$RemindersTableUpdateCompanionBuilder,
    (Reminder, $$RemindersTableReferences),
    Reminder,
    PrefetchHooks Function({bool userId})>;
typedef $$MedicationsTableCreateCompanionBuilder = MedicationsCompanion
    Function({
  required String id,
  required String userId,
  required String name,
  required String dosage,
  required String frequency,
  required DateTime startDate,
  Value<DateTime?> endDate,
  Value<int?> effectiveness,
  Value<String?> sideEffects,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$MedicationsTableUpdateCompanionBuilder = MedicationsCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<String> name,
  Value<String> dosage,
  Value<String> frequency,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<int?> effectiveness,
  Value<String?> sideEffects,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$MedicationsTableReferences
    extends BaseReferences<_$AppDatabase, $MedicationsTable, Medication> {
  $$MedicationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _userIdTable(_$AppDatabase db) => db.profiles
      .createAlias($_aliasNameGenerator(db.medications.userId, db.profiles.id));

  $$ProfilesTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$ProfilesTableTableManager($_db, $_db.profiles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MedicationsTableFilterComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get effectiveness => $composableBuilder(
      column: $table.effectiveness, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sideEffects => $composableBuilder(
      column: $table.sideEffects, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ProfilesTableFilterComposer get userId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableFilterComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MedicationsTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get effectiveness => $composableBuilder(
      column: $table.effectiveness,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sideEffects => $composableBuilder(
      column: $table.sideEffects, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ProfilesTableOrderingComposer get userId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MedicationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get dosage =>
      $composableBuilder(column: $table.dosage, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get effectiveness => $composableBuilder(
      column: $table.effectiveness, builder: (column) => column);

  GeneratedColumn<String> get sideEffects => $composableBuilder(
      column: $table.sideEffects, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get userId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MedicationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MedicationsTable,
    Medication,
    $$MedicationsTableFilterComposer,
    $$MedicationsTableOrderingComposer,
    $$MedicationsTableAnnotationComposer,
    $$MedicationsTableCreateCompanionBuilder,
    $$MedicationsTableUpdateCompanionBuilder,
    (Medication, $$MedicationsTableReferences),
    Medication,
    PrefetchHooks Function({bool userId})> {
  $$MedicationsTableTableManager(_$AppDatabase db, $MedicationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> dosage = const Value.absent(),
            Value<String> frequency = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<int?> effectiveness = const Value.absent(),
            Value<String?> sideEffects = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicationsCompanion(
            id: id,
            userId: userId,
            name: name,
            dosage: dosage,
            frequency: frequency,
            startDate: startDate,
            endDate: endDate,
            effectiveness: effectiveness,
            sideEffects: sideEffects,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String name,
            required String dosage,
            required String frequency,
            required DateTime startDate,
            Value<DateTime?> endDate = const Value.absent(),
            Value<int?> effectiveness = const Value.absent(),
            Value<String?> sideEffects = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicationsCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            dosage: dosage,
            frequency: frequency,
            startDate: startDate,
            endDate: endDate,
            effectiveness: effectiveness,
            sideEffects: sideEffects,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MedicationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$MedicationsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$MedicationsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MedicationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MedicationsTable,
    Medication,
    $$MedicationsTableFilterComposer,
    $$MedicationsTableOrderingComposer,
    $$MedicationsTableAnnotationComposer,
    $$MedicationsTableCreateCompanionBuilder,
    $$MedicationsTableUpdateCompanionBuilder,
    (Medication, $$MedicationsTableReferences),
    Medication,
    PrefetchHooks Function({bool userId})>;
typedef $$PhotosTableCreateCompanionBuilder = PhotosCompanion Function({
  required String id,
  required String userId,
  required String imageUrl,
  required String bodyPart,
  required int itchIntensity,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$PhotosTableUpdateCompanionBuilder = PhotosCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> imageUrl,
  Value<String> bodyPart,
  Value<int> itchIntensity,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$PhotosTableReferences
    extends BaseReferences<_$AppDatabase, $PhotosTable, Photo> {
  $$PhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _userIdTable(_$AppDatabase db) => db.profiles
      .createAlias($_aliasNameGenerator(db.photos.userId, db.profiles.id));

  $$ProfilesTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$ProfilesTableTableManager($_db, $_db.profiles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PhotosTableFilterComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bodyPart => $composableBuilder(
      column: $table.bodyPart, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get itchIntensity => $composableBuilder(
      column: $table.itchIntensity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ProfilesTableFilterComposer get userId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableFilterComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bodyPart => $composableBuilder(
      column: $table.bodyPart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get itchIntensity => $composableBuilder(
      column: $table.itchIntensity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ProfilesTableOrderingComposer get userId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get bodyPart =>
      $composableBuilder(column: $table.bodyPart, builder: (column) => column);

  GeneratedColumn<int> get itchIntensity => $composableBuilder(
      column: $table.itchIntensity, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get userId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PhotosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PhotosTable,
    Photo,
    $$PhotosTableFilterComposer,
    $$PhotosTableOrderingComposer,
    $$PhotosTableAnnotationComposer,
    $$PhotosTableCreateCompanionBuilder,
    $$PhotosTableUpdateCompanionBuilder,
    (Photo, $$PhotosTableReferences),
    Photo,
    PrefetchHooks Function({bool userId})> {
  $$PhotosTableTableManager(_$AppDatabase db, $PhotosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> imageUrl = const Value.absent(),
            Value<String> bodyPart = const Value.absent(),
            Value<int> itchIntensity = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PhotosCompanion(
            id: id,
            userId: userId,
            imageUrl: imageUrl,
            bodyPart: bodyPart,
            itchIntensity: itchIntensity,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String imageUrl,
            required String bodyPart,
            required int itchIntensity,
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PhotosCompanion.insert(
            id: id,
            userId: userId,
            imageUrl: imageUrl,
            bodyPart: bodyPart,
            itchIntensity: itchIntensity,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PhotosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable: $$PhotosTableReferences._userIdTable(db),
                    referencedColumn:
                        $$PhotosTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PhotosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PhotosTable,
    Photo,
    $$PhotosTableFilterComposer,
    $$PhotosTableOrderingComposer,
    $$PhotosTableAnnotationComposer,
    $$PhotosTableCreateCompanionBuilder,
    $$PhotosTableUpdateCompanionBuilder,
    (Photo, $$PhotosTableReferences),
    Photo,
    PrefetchHooks Function({bool userId})>;
typedef $$LifestyleEntriesTableCreateCompanionBuilder
    = LifestyleEntriesCompanion Function({
  required String id,
  required String userId,
  required DateTime date,
  required String foodsConsumed,
  required String potentialTriggerFoods,
  required int sleepHours,
  required int sleepQuality,
  required int stressLevel,
  required double waterIntakeLiters,
  required int exerciseMinutes,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$LifestyleEntriesTableUpdateCompanionBuilder
    = LifestyleEntriesCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<DateTime> date,
  Value<String> foodsConsumed,
  Value<String> potentialTriggerFoods,
  Value<int> sleepHours,
  Value<int> sleepQuality,
  Value<int> stressLevel,
  Value<double> waterIntakeLiters,
  Value<int> exerciseMinutes,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$LifestyleEntriesTableReferences extends BaseReferences<
    _$AppDatabase, $LifestyleEntriesTable, LifestyleEntry> {
  $$LifestyleEntriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _userIdTable(_$AppDatabase db) =>
      db.profiles.createAlias(
          $_aliasNameGenerator(db.lifestyleEntries.userId, db.profiles.id));

  $$ProfilesTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$ProfilesTableTableManager($_db, $_db.profiles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LifestyleEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LifestyleEntriesTable> {
  $$LifestyleEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodsConsumed => $composableBuilder(
      column: $table.foodsConsumed, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get potentialTriggerFoods => $composableBuilder(
      column: $table.potentialTriggerFoods,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sleepHours => $composableBuilder(
      column: $table.sleepHours, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sleepQuality => $composableBuilder(
      column: $table.sleepQuality, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stressLevel => $composableBuilder(
      column: $table.stressLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get waterIntakeLiters => $composableBuilder(
      column: $table.waterIntakeLiters,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get exerciseMinutes => $composableBuilder(
      column: $table.exerciseMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ProfilesTableFilterComposer get userId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableFilterComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LifestyleEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LifestyleEntriesTable> {
  $$LifestyleEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodsConsumed => $composableBuilder(
      column: $table.foodsConsumed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get potentialTriggerFoods => $composableBuilder(
      column: $table.potentialTriggerFoods,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sleepHours => $composableBuilder(
      column: $table.sleepHours, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sleepQuality => $composableBuilder(
      column: $table.sleepQuality,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stressLevel => $composableBuilder(
      column: $table.stressLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get waterIntakeLiters => $composableBuilder(
      column: $table.waterIntakeLiters,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get exerciseMinutes => $composableBuilder(
      column: $table.exerciseMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ProfilesTableOrderingComposer get userId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LifestyleEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LifestyleEntriesTable> {
  $$LifestyleEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get foodsConsumed => $composableBuilder(
      column: $table.foodsConsumed, builder: (column) => column);

  GeneratedColumn<String> get potentialTriggerFoods => $composableBuilder(
      column: $table.potentialTriggerFoods, builder: (column) => column);

  GeneratedColumn<int> get sleepHours => $composableBuilder(
      column: $table.sleepHours, builder: (column) => column);

  GeneratedColumn<int> get sleepQuality => $composableBuilder(
      column: $table.sleepQuality, builder: (column) => column);

  GeneratedColumn<int> get stressLevel => $composableBuilder(
      column: $table.stressLevel, builder: (column) => column);

  GeneratedColumn<double> get waterIntakeLiters => $composableBuilder(
      column: $table.waterIntakeLiters, builder: (column) => column);

  GeneratedColumn<int> get exerciseMinutes => $composableBuilder(
      column: $table.exerciseMinutes, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get userId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LifestyleEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LifestyleEntriesTable,
    LifestyleEntry,
    $$LifestyleEntriesTableFilterComposer,
    $$LifestyleEntriesTableOrderingComposer,
    $$LifestyleEntriesTableAnnotationComposer,
    $$LifestyleEntriesTableCreateCompanionBuilder,
    $$LifestyleEntriesTableUpdateCompanionBuilder,
    (LifestyleEntry, $$LifestyleEntriesTableReferences),
    LifestyleEntry,
    PrefetchHooks Function({bool userId})> {
  $$LifestyleEntriesTableTableManager(
      _$AppDatabase db, $LifestyleEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LifestyleEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LifestyleEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LifestyleEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> foodsConsumed = const Value.absent(),
            Value<String> potentialTriggerFoods = const Value.absent(),
            Value<int> sleepHours = const Value.absent(),
            Value<int> sleepQuality = const Value.absent(),
            Value<int> stressLevel = const Value.absent(),
            Value<double> waterIntakeLiters = const Value.absent(),
            Value<int> exerciseMinutes = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LifestyleEntriesCompanion(
            id: id,
            userId: userId,
            date: date,
            foodsConsumed: foodsConsumed,
            potentialTriggerFoods: potentialTriggerFoods,
            sleepHours: sleepHours,
            sleepQuality: sleepQuality,
            stressLevel: stressLevel,
            waterIntakeLiters: waterIntakeLiters,
            exerciseMinutes: exerciseMinutes,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required DateTime date,
            required String foodsConsumed,
            required String potentialTriggerFoods,
            required int sleepHours,
            required int sleepQuality,
            required int stressLevel,
            required double waterIntakeLiters,
            required int exerciseMinutes,
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LifestyleEntriesCompanion.insert(
            id: id,
            userId: userId,
            date: date,
            foodsConsumed: foodsConsumed,
            potentialTriggerFoods: potentialTriggerFoods,
            sleepHours: sleepHours,
            sleepQuality: sleepQuality,
            stressLevel: stressLevel,
            waterIntakeLiters: waterIntakeLiters,
            exerciseMinutes: exerciseMinutes,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LifestyleEntriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$LifestyleEntriesTableReferences._userIdTable(db),
                    referencedColumn:
                        $$LifestyleEntriesTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LifestyleEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LifestyleEntriesTable,
    LifestyleEntry,
    $$LifestyleEntriesTableFilterComposer,
    $$LifestyleEntriesTableOrderingComposer,
    $$LifestyleEntriesTableAnnotationComposer,
    $$LifestyleEntriesTableCreateCompanionBuilder,
    $$LifestyleEntriesTableUpdateCompanionBuilder,
    (LifestyleEntry, $$LifestyleEntriesTableReferences),
    LifestyleEntry,
    PrefetchHooks Function({bool userId})>;
typedef $$SymptomEntriesTableCreateCompanionBuilder = SymptomEntriesCompanion
    Function({
  required String id,
  required String userId,
  required DateTime date,
  required bool isFlareup,
  required String severity,
  required String affectedAreas,
  Value<String?> symptoms,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$SymptomEntriesTableUpdateCompanionBuilder = SymptomEntriesCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<DateTime> date,
  Value<bool> isFlareup,
  Value<String> severity,
  Value<String> affectedAreas,
  Value<String?> symptoms,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$SymptomEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $SymptomEntriesTable, SymptomEntry> {
  $$SymptomEntriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _userIdTable(_$AppDatabase db) =>
      db.profiles.createAlias(
          $_aliasNameGenerator(db.symptomEntries.userId, db.profiles.id));

  $$ProfilesTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$ProfilesTableTableManager($_db, $_db.profiles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SymptomTreatmentLinksTable,
      List<SymptomTreatmentLink>> _symptomTreatmentLinksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.symptomTreatmentLinks,
          aliasName: $_aliasNameGenerator(
              db.symptomEntries.id, db.symptomTreatmentLinks.symptomId));

  $$SymptomTreatmentLinksTableProcessedTableManager
      get symptomTreatmentLinksRefs {
    final manager = $$SymptomTreatmentLinksTableTableManager(
            $_db, $_db.symptomTreatmentLinks)
        .filter((f) => f.symptomId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_symptomTreatmentLinksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SymptomEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomEntriesTable> {
  $$SymptomEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFlareup => $composableBuilder(
      column: $table.isFlareup, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get severity => $composableBuilder(
      column: $table.severity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get affectedAreas => $composableBuilder(
      column: $table.affectedAreas, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get symptoms => $composableBuilder(
      column: $table.symptoms, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ProfilesTableFilterComposer get userId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableFilterComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> symptomTreatmentLinksRefs(
      Expression<bool> Function($$SymptomTreatmentLinksTableFilterComposer f)
          f) {
    final $$SymptomTreatmentLinksTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.symptomTreatmentLinks,
            getReferencedColumn: (t) => t.symptomId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SymptomTreatmentLinksTableFilterComposer(
                  $db: $db,
                  $table: $db.symptomTreatmentLinks,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$SymptomEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomEntriesTable> {
  $$SymptomEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFlareup => $composableBuilder(
      column: $table.isFlareup, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get severity => $composableBuilder(
      column: $table.severity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get affectedAreas => $composableBuilder(
      column: $table.affectedAreas,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get symptoms => $composableBuilder(
      column: $table.symptoms, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ProfilesTableOrderingComposer get userId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SymptomEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomEntriesTable> {
  $$SymptomEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get isFlareup =>
      $composableBuilder(column: $table.isFlareup, builder: (column) => column);

  GeneratedColumn<String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<String> get affectedAreas => $composableBuilder(
      column: $table.affectedAreas, builder: (column) => column);

  GeneratedColumn<String> get symptoms =>
      $composableBuilder(column: $table.symptoms, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get userId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> symptomTreatmentLinksRefs<T extends Object>(
      Expression<T> Function($$SymptomTreatmentLinksTableAnnotationComposer a)
          f) {
    final $$SymptomTreatmentLinksTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.symptomTreatmentLinks,
            getReferencedColumn: (t) => t.symptomId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SymptomTreatmentLinksTableAnnotationComposer(
                  $db: $db,
                  $table: $db.symptomTreatmentLinks,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$SymptomEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SymptomEntriesTable,
    SymptomEntry,
    $$SymptomEntriesTableFilterComposer,
    $$SymptomEntriesTableOrderingComposer,
    $$SymptomEntriesTableAnnotationComposer,
    $$SymptomEntriesTableCreateCompanionBuilder,
    $$SymptomEntriesTableUpdateCompanionBuilder,
    (SymptomEntry, $$SymptomEntriesTableReferences),
    SymptomEntry,
    PrefetchHooks Function({bool userId, bool symptomTreatmentLinksRefs})> {
  $$SymptomEntriesTableTableManager(
      _$AppDatabase db, $SymptomEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<bool> isFlareup = const Value.absent(),
            Value<String> severity = const Value.absent(),
            Value<String> affectedAreas = const Value.absent(),
            Value<String?> symptoms = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SymptomEntriesCompanion(
            id: id,
            userId: userId,
            date: date,
            isFlareup: isFlareup,
            severity: severity,
            affectedAreas: affectedAreas,
            symptoms: symptoms,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required DateTime date,
            required bool isFlareup,
            required String severity,
            required String affectedAreas,
            Value<String?> symptoms = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SymptomEntriesCompanion.insert(
            id: id,
            userId: userId,
            date: date,
            isFlareup: isFlareup,
            severity: severity,
            affectedAreas: affectedAreas,
            symptoms: symptoms,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SymptomEntriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {userId = false, symptomTreatmentLinksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (symptomTreatmentLinksRefs) db.symptomTreatmentLinks
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$SymptomEntriesTableReferences._userIdTable(db),
                    referencedColumn:
                        $$SymptomEntriesTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (symptomTreatmentLinksRefs)
                    await $_getPrefetchedData<SymptomEntry,
                            $SymptomEntriesTable, SymptomTreatmentLink>(
                        currentTable: table,
                        referencedTable: $$SymptomEntriesTableReferences
                            ._symptomTreatmentLinksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SymptomEntriesTableReferences(db, table, p0)
                                .symptomTreatmentLinksRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.symptomId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SymptomEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SymptomEntriesTable,
    SymptomEntry,
    $$SymptomEntriesTableFilterComposer,
    $$SymptomEntriesTableOrderingComposer,
    $$SymptomEntriesTableAnnotationComposer,
    $$SymptomEntriesTableCreateCompanionBuilder,
    $$SymptomEntriesTableUpdateCompanionBuilder,
    (SymptomEntry, $$SymptomEntriesTableReferences),
    SymptomEntry,
    PrefetchHooks Function({bool userId, bool symptomTreatmentLinksRefs})>;
typedef $$TreatmentsTableCreateCompanionBuilder = TreatmentsCompanion Function({
  required String id,
  required String userId,
  required String name,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$TreatmentsTableUpdateCompanionBuilder = TreatmentsCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> name,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$TreatmentsTableReferences
    extends BaseReferences<_$AppDatabase, $TreatmentsTable, Treatment> {
  $$TreatmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _userIdTable(_$AppDatabase db) => db.profiles
      .createAlias($_aliasNameGenerator(db.treatments.userId, db.profiles.id));

  $$ProfilesTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$ProfilesTableTableManager($_db, $_db.profiles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SymptomTreatmentLinksTable,
      List<SymptomTreatmentLink>> _symptomTreatmentLinksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.symptomTreatmentLinks,
          aliasName: $_aliasNameGenerator(
              db.treatments.id, db.symptomTreatmentLinks.treatmentId));

  $$SymptomTreatmentLinksTableProcessedTableManager
      get symptomTreatmentLinksRefs {
    final manager = $$SymptomTreatmentLinksTableTableManager(
            $_db, $_db.symptomTreatmentLinks)
        .filter((f) => f.treatmentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_symptomTreatmentLinksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TreatmentsTableFilterComposer
    extends Composer<_$AppDatabase, $TreatmentsTable> {
  $$TreatmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ProfilesTableFilterComposer get userId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableFilterComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> symptomTreatmentLinksRefs(
      Expression<bool> Function($$SymptomTreatmentLinksTableFilterComposer f)
          f) {
    final $$SymptomTreatmentLinksTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.symptomTreatmentLinks,
            getReferencedColumn: (t) => t.treatmentId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SymptomTreatmentLinksTableFilterComposer(
                  $db: $db,
                  $table: $db.symptomTreatmentLinks,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TreatmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $TreatmentsTable> {
  $$TreatmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ProfilesTableOrderingComposer get userId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TreatmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TreatmentsTable> {
  $$TreatmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get userId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> symptomTreatmentLinksRefs<T extends Object>(
      Expression<T> Function($$SymptomTreatmentLinksTableAnnotationComposer a)
          f) {
    final $$SymptomTreatmentLinksTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.symptomTreatmentLinks,
            getReferencedColumn: (t) => t.treatmentId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SymptomTreatmentLinksTableAnnotationComposer(
                  $db: $db,
                  $table: $db.symptomTreatmentLinks,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TreatmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TreatmentsTable,
    Treatment,
    $$TreatmentsTableFilterComposer,
    $$TreatmentsTableOrderingComposer,
    $$TreatmentsTableAnnotationComposer,
    $$TreatmentsTableCreateCompanionBuilder,
    $$TreatmentsTableUpdateCompanionBuilder,
    (Treatment, $$TreatmentsTableReferences),
    Treatment,
    PrefetchHooks Function({bool userId, bool symptomTreatmentLinksRefs})> {
  $$TreatmentsTableTableManager(_$AppDatabase db, $TreatmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TreatmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TreatmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TreatmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TreatmentsCompanion(
            id: id,
            userId: userId,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String name,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TreatmentsCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TreatmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {userId = false, symptomTreatmentLinksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (symptomTreatmentLinksRefs) db.symptomTreatmentLinks
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$TreatmentsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$TreatmentsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (symptomTreatmentLinksRefs)
                    await $_getPrefetchedData<Treatment, $TreatmentsTable, SymptomTreatmentLink>(
                        currentTable: table,
                        referencedTable: $$TreatmentsTableReferences
                            ._symptomTreatmentLinksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TreatmentsTableReferences(db, table, p0)
                                .symptomTreatmentLinksRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.treatmentId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TreatmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TreatmentsTable,
    Treatment,
    $$TreatmentsTableFilterComposer,
    $$TreatmentsTableOrderingComposer,
    $$TreatmentsTableAnnotationComposer,
    $$TreatmentsTableCreateCompanionBuilder,
    $$TreatmentsTableUpdateCompanionBuilder,
    (Treatment, $$TreatmentsTableReferences),
    Treatment,
    PrefetchHooks Function({bool userId, bool symptomTreatmentLinksRefs})>;
typedef $$SymptomTreatmentLinksTableCreateCompanionBuilder
    = SymptomTreatmentLinksCompanion Function({
  required String id,
  required String symptomId,
  required String treatmentId,
  required String userId,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SymptomTreatmentLinksTableUpdateCompanionBuilder
    = SymptomTreatmentLinksCompanion Function({
  Value<String> id,
  Value<String> symptomId,
  Value<String> treatmentId,
  Value<String> userId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$SymptomTreatmentLinksTableReferences extends BaseReferences<
    _$AppDatabase, $SymptomTreatmentLinksTable, SymptomTreatmentLink> {
  $$SymptomTreatmentLinksTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SymptomEntriesTable _symptomIdTable(_$AppDatabase db) =>
      db.symptomEntries.createAlias($_aliasNameGenerator(
          db.symptomTreatmentLinks.symptomId, db.symptomEntries.id));

  $$SymptomEntriesTableProcessedTableManager get symptomId {
    final $_column = $_itemColumn<String>('symptom_id')!;

    final manager = $$SymptomEntriesTableTableManager($_db, $_db.symptomEntries)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_symptomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TreatmentsTable _treatmentIdTable(_$AppDatabase db) =>
      db.treatments.createAlias($_aliasNameGenerator(
          db.symptomTreatmentLinks.treatmentId, db.treatments.id));

  $$TreatmentsTableProcessedTableManager get treatmentId {
    final $_column = $_itemColumn<String>('treatment_id')!;

    final manager = $$TreatmentsTableTableManager($_db, $_db.treatments)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_treatmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProfilesTable _userIdTable(_$AppDatabase db) =>
      db.profiles.createAlias($_aliasNameGenerator(
          db.symptomTreatmentLinks.userId, db.profiles.id));

  $$ProfilesTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$ProfilesTableTableManager($_db, $_db.profiles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SymptomTreatmentLinksTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomTreatmentLinksTable> {
  $$SymptomTreatmentLinksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$SymptomEntriesTableFilterComposer get symptomId {
    final $$SymptomEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.symptomId,
        referencedTable: $db.symptomEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SymptomEntriesTableFilterComposer(
              $db: $db,
              $table: $db.symptomEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TreatmentsTableFilterComposer get treatmentId {
    final $$TreatmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.treatmentId,
        referencedTable: $db.treatments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TreatmentsTableFilterComposer(
              $db: $db,
              $table: $db.treatments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProfilesTableFilterComposer get userId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableFilterComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SymptomTreatmentLinksTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomTreatmentLinksTable> {
  $$SymptomTreatmentLinksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$SymptomEntriesTableOrderingComposer get symptomId {
    final $$SymptomEntriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.symptomId,
        referencedTable: $db.symptomEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SymptomEntriesTableOrderingComposer(
              $db: $db,
              $table: $db.symptomEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TreatmentsTableOrderingComposer get treatmentId {
    final $$TreatmentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.treatmentId,
        referencedTable: $db.treatments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TreatmentsTableOrderingComposer(
              $db: $db,
              $table: $db.treatments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProfilesTableOrderingComposer get userId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SymptomTreatmentLinksTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomTreatmentLinksTable> {
  $$SymptomTreatmentLinksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SymptomEntriesTableAnnotationComposer get symptomId {
    final $$SymptomEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.symptomId,
        referencedTable: $db.symptomEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SymptomEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.symptomEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TreatmentsTableAnnotationComposer get treatmentId {
    final $$TreatmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.treatmentId,
        referencedTable: $db.treatments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TreatmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.treatments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProfilesTableAnnotationComposer get userId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SymptomTreatmentLinksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SymptomTreatmentLinksTable,
    SymptomTreatmentLink,
    $$SymptomTreatmentLinksTableFilterComposer,
    $$SymptomTreatmentLinksTableOrderingComposer,
    $$SymptomTreatmentLinksTableAnnotationComposer,
    $$SymptomTreatmentLinksTableCreateCompanionBuilder,
    $$SymptomTreatmentLinksTableUpdateCompanionBuilder,
    (SymptomTreatmentLink, $$SymptomTreatmentLinksTableReferences),
    SymptomTreatmentLink,
    PrefetchHooks Function({bool symptomId, bool treatmentId, bool userId})> {
  $$SymptomTreatmentLinksTableTableManager(
      _$AppDatabase db, $SymptomTreatmentLinksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomTreatmentLinksTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomTreatmentLinksTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomTreatmentLinksTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> symptomId = const Value.absent(),
            Value<String> treatmentId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SymptomTreatmentLinksCompanion(
            id: id,
            symptomId: symptomId,
            treatmentId: treatmentId,
            userId: userId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String symptomId,
            required String treatmentId,
            required String userId,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SymptomTreatmentLinksCompanion.insert(
            id: id,
            symptomId: symptomId,
            treatmentId: treatmentId,
            userId: userId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SymptomTreatmentLinksTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {symptomId = false, treatmentId = false, userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (symptomId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.symptomId,
                    referencedTable: $$SymptomTreatmentLinksTableReferences
                        ._symptomIdTable(db),
                    referencedColumn: $$SymptomTreatmentLinksTableReferences
                        ._symptomIdTable(db)
                        .id,
                  ) as T;
                }
                if (treatmentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.treatmentId,
                    referencedTable: $$SymptomTreatmentLinksTableReferences
                        ._treatmentIdTable(db),
                    referencedColumn: $$SymptomTreatmentLinksTableReferences
                        ._treatmentIdTable(db)
                        .id,
                  ) as T;
                }
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$SymptomTreatmentLinksTableReferences._userIdTable(db),
                    referencedColumn: $$SymptomTreatmentLinksTableReferences
                        ._userIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SymptomTreatmentLinksTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SymptomTreatmentLinksTable,
        SymptomTreatmentLink,
        $$SymptomTreatmentLinksTableFilterComposer,
        $$SymptomTreatmentLinksTableOrderingComposer,
        $$SymptomTreatmentLinksTableAnnotationComposer,
        $$SymptomTreatmentLinksTableCreateCompanionBuilder,
        $$SymptomTreatmentLinksTableUpdateCompanionBuilder,
        (SymptomTreatmentLink, $$SymptomTreatmentLinksTableReferences),
        SymptomTreatmentLink,
        PrefetchHooks Function(
            {bool symptomId, bool treatmentId, bool userId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$MedicationsTableTableManager get medications =>
      $$MedicationsTableTableManager(_db, _db.medications);
  $$PhotosTableTableManager get photos =>
      $$PhotosTableTableManager(_db, _db.photos);
  $$LifestyleEntriesTableTableManager get lifestyleEntries =>
      $$LifestyleEntriesTableTableManager(_db, _db.lifestyleEntries);
  $$SymptomEntriesTableTableManager get symptomEntries =>
      $$SymptomEntriesTableTableManager(_db, _db.symptomEntries);
  $$TreatmentsTableTableManager get treatments =>
      $$TreatmentsTableTableManager(_db, _db.treatments);
  $$SymptomTreatmentLinksTableTableManager get symptomTreatmentLinks =>
      $$SymptomTreatmentLinksTableTableManager(_db, _db.symptomTreatmentLinks);
}
