import 'package:demo_app/main/data/database/app_database.dart';
import 'package:demo_app/main/data/model/photo.dart';

class PhotoDbHelper {
  static final PhotoDbHelper instance = PhotoDbHelper._init();
  static AppDatabase? _db;

  PhotoDbHelper._init();

  Future<AppDatabase> get database async {
    _db ??= AppDatabase();
    return _db!;
  }

  // --- LƯU MỘT PHOTO (thêm mới hoặc cập nhật nếu đã tồn tại) ---
  Future<void> savePhoto(Photo photo) async {
    final db = await database;
    await db.savePhoto(photo);
  }

  // --- LẤY TOÀN BỘ ẢNH CỦA MỘT PET ---
  Future<List<Photo>> loadPhotosByPet(String petId) async {
    final db = await database;
    return await db.loadPhotosByPet(petId);
  }

  Future<Photo> getPhotoById(String id) async {
    final db = await database;
    return await db.getPhotoById(id);
  }

  // --- XÓA MỘT PHOTO THEO ID ---
  Future<void> deletePhoto(String id) async {
    final db = await database;
    await db.deletePhoto(id);
  }

  // --- XÓA TOÀN BỘ ẢNH CỦA MỘT PET ---
  Future<void> deleteAllPhotosByPet(String petId) async {
    final db = await database;
    await db.deleteAllPhotosByPet(petId);
  }

  // Đóng database khi không dùng nữa (optional, gọi khi app terminate)
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
