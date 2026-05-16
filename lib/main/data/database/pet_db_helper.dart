import 'package:demo_app/main/data/database/app_database.dart';
import 'package:demo_app/main/data/model/pet.dart';

class PetDbHelper {
  static final PetDbHelper instance = PetDbHelper._init();
  static AppDatabase? _db;

  PetDbHelper._init();

  Future<AppDatabase> get database async {
    _db ??= AppDatabase();
    return _db!;
  }

  // --- LƯU MỘT PET (thêm mới hoặc cập nhật nếu đã tồn tại) ---
  Future<void> savePet(Pet pet) async {
    final db = await database;
    await db.savePet(pet);
  }

  // --- LẤY TOÀN BỘ DANH SÁCH PET ---
  Future<List<Pet>> loadAllPets() async {
    final db = await database;
    return await db.loadAllPets();
  }

  // --- LẤY MỘT PET THEO ID ---
  Future<Pet?> loadPetById(String id) async {
    final db = await database;
    return await db.loadPetById(id);
  }

  // --- XÓA MỘT PET THEO ID ---
  Future<void> deletePet(String id) async {
    final db = await database;
    await db.deletePet(id);
  }

  // --- XÓA TOÀN BỘ PETS ---
  Future<void> clearAllPets() async {
    final db = await database;
    await db.clearAllPets();
  }

  // Đóng database khi không dùng nữa (optional, gọi khi app terminate)
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
