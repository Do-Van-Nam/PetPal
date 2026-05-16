import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:demo_app/main/data/model/chatbot/chatbot_data_model.dart';
import 'package:demo_app/main/data/model/pet.dart';
import 'package:demo_app/main/data/model/activity.dart';
import 'package:demo_app/main/data/model/photo.dart';

part 'app_database.g.dart';
// chay de gen app_database.g.dart
// fvm dart run build_runner build --delete-conflicting-outputs

// ═══════════════════════════════════════════════════════════════════════════════
// TABLE DEFINITIONS
// ═══════════════════════════════════════════════════════════════════════════════

class ChatMessages extends Table {
  IntColumn get localId => integer().autoIncrement()();
  TextColumn get jsonData => text()();
  TextColumn get timestamp => text()(); // ISO8601 string
}

/// Bảng Pets — mỗi row là 1 pet, lưu toàn bộ dữ liệu dưới dạng JSON
class PetTable extends Table {
  TextColumn get id => text()(); // pet.id làm khóa chính
  TextColumn get jsonData => text()(); // json của toàn bộ Pet object

  @override
  Set<Column> get primaryKey => {id};
}

/// Bảng Activities — mỗi row là 1 activity, lưu toàn bộ dưới dạng JSON
class ActivityTable extends Table {
  TextColumn get id => text()(); // activity.id làm khóa chính
  TextColumn get petId => text()(); // để lọc theo pet
  TextColumn get jsonData => text()(); // json của toàn bộ Activity object

  @override
  Set<Column> get primaryKey => {id};
}

/// Bảng Photos — mỗi row là 1 photo, lưu toàn bộ dưới dạng JSON
class PhotoTable extends Table {
  TextColumn get id => text()(); // photo.id làm khóa chính
  TextColumn get petId => text()(); // để lọc theo pet
  TextColumn get jsonData => text()(); // json của toàn bộ Photo object

  @override
  Set<Column> get primaryKey => {id};
}

// ═══════════════════════════════════════════════════════════════════════════════
// DATABASE
// ═══════════════════════════════════════════════════════════════════════════════

@DriftDatabase(tables: [ChatMessages, PetTable, ActivityTable, PhotoTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.createTable(petTable);
            await migrator.createTable(activityTable);
            await migrator.createTable(photoTable);
          }
        },
      );

  // ─── ChatMessages ────────────────────────────────────────────────────────────

  Future<void> saveMessage(ChatbotData message) async {
    final row = ChatMessagesCompanion(
      jsonData: Value(jsonEncode(message.toJson())),
      timestamp: Value((message.datetime ?? DateTime.now()).toIso8601String()),
    );
    await into(chatMessages).insertOnConflictUpdate(row);
  }

  Future<List<ChatbotData>> loadMessages() async {
    final rows = await select(chatMessages).get();
    return rows.map((row) {
      final jsonMap = jsonDecode(row.jsonData) as Map<String, dynamic>;
      return ChatbotData.fromJson(jsonMap);
    }).toList();
  }

  Future<void> clearHistory() async {
    await delete(chatMessages).go();
  }

  // ─── Pets ────────────────────────────────────────────────────────────────────

  Future<void> savePet(Pet pet) async {
    await into(petTable).insertOnConflictUpdate(PetTableCompanion(
      id: Value(pet.id),
      jsonData: Value(jsonEncode(pet.toJson())),
    ));
  }

  Future<List<Pet>> loadAllPets() async {
    final rows = await select(petTable).get();
    return rows.map((row) {
      final jsonMap = jsonDecode(row.jsonData) as Map<String, dynamic>;
      return Pet.fromJson(jsonMap);
    }).toList();
  }

  Future<Pet?> loadPetById(String id) async {
    final row = await (select(petTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    final jsonMap = jsonDecode(row.jsonData) as Map<String, dynamic>;
    return Pet.fromJson(jsonMap);
  }

  Future<void> deletePet(String id) async {
    await (delete(petTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> clearAllPets() async {
    await delete(petTable).go();
  }

  // ─── Activities ──────────────────────────────────────────────────────────────

  Future<void> saveActivity(Activity activity) async {
    await into(activityTable).insertOnConflictUpdate(ActivityTableCompanion(
      id: Value(activity.id),
      petId: Value(activity.petId),
      jsonData: Value(jsonEncode(activity.toJson())),
    ));
  }

  Future<List<Activity>> loadActivitiesByPet(String petId) async {
    final rows = await (select(activityTable)
          ..where((t) => t.petId.equals(petId)))
        .get();
    return rows.map((row) {
      final jsonMap = jsonDecode(row.jsonData) as Map<String, dynamic>;
      return Activity.fromJson(jsonMap);
    }).toList();
  }

  Future<void> deleteActivity(String id) async {
    await (delete(activityTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteActivitiesByPet(String petId) async {
    await (delete(activityTable)..where((t) => t.petId.equals(petId))).go();
  }

  // ─── Photos ──────────────────────────────────────────────────────────────────

  Future<void> savePhoto(Photo photo) async {
    await into(photoTable).insertOnConflictUpdate(PhotoTableCompanion(
      id: Value(photo.id),
      petId: Value(photo.petId),
      jsonData: Value(jsonEncode(photo.toJson())),
    ));
  }

  Future<Photo> getPhotoById(String id) async {
    final row =
        await (select(photoTable)..where((t) => t.id.equals(id))).getSingle();
    final jsonMap = jsonDecode(row.jsonData) as Map<String, dynamic>;
    return Photo.fromJson(jsonMap);
  }

  Future<List<Photo>> loadPhotosByPet(String petId) async {
    final rows =
        await (select(photoTable)..where((t) => t.petId.equals(petId))).get();
    return rows.map((row) {
      final jsonMap = jsonDecode(row.jsonData) as Map<String, dynamic>;
      return Photo.fromJson(jsonMap);
    }).toList();
  }

  Future<void> deletePhoto(String id) async {
    await (delete(photoTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteAllPhotosByPet(String petId) async {
    await (delete(photoTable)..where((t) => t.petId.equals(petId))).go();
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CONNECTION
// ═══════════════════════════════════════════════════════════════════════════════

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'petpal.db'));
    return NativeDatabase.createInBackground(file);
  });
}
