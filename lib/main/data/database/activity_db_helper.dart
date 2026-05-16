import 'package:demo_app/main/data/database/app_database.dart';
import 'package:demo_app/main/data/model/activity.dart';

class ActivityDbHelper {
  static final ActivityDbHelper instance = ActivityDbHelper._init();
  static AppDatabase? _db;

  ActivityDbHelper._init();

  Future<AppDatabase> get database async {
    _db ??= AppDatabase();
    return _db!;
  }

  // --- LƯU MỘT ACTIVITY (thêm mới hoặc cập nhật nếu đã tồn tại) ---
  Future<void> saveActivity(Activity activity) async {
    final db = await database;
    await db.saveActivity(activity);
  }

  // --- LẤY TOÀN BỘ ACTIVITY CỦA MỘT PET ---
  Future<List<Activity>> loadActivitiesByPet(String petId) async {
    final db = await database;
    return await db.loadActivitiesByPet(petId);
  }

  // --- XÓA MỘT ACTIVITY THEO ID ---
  Future<void> deleteActivity(String id) async {
    final db = await database;
    await db.deleteActivity(id);
  }

  // --- XÓA TOÀN BỘ ACTIVITY CỦA MỘT PET ---
  Future<void> deleteActivitiesByPet(String petId) async {
    final db = await database;
    await db.deleteActivitiesByPet(petId);
  }

  // Đóng database khi không dùng nữa (optional, gọi khi app terminate)
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
