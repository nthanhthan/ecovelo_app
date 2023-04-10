import 'package:path_provider/path_provider.dart';
import '../core.dart';

class HiveManager {
  static Future<void> init() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String hivePath = "$dir/${BuildConfig().env.dbName}-${BuildConfig().env.dbVersion}";
    Hive.init(hivePath);
  }

  static Future<void> close() async {
    await Hive.close();
  }

  static Future<void> clearBoxData<T>(String boxName) async {
    Box<T> box;
    if (!Hive.isBoxOpen(boxName)) {
      box = await Hive.openBox<T>(boxName);
    } else {
      box = Hive.box<T>(boxName);
    }
    await box.clear();
  }

  static Future<void> clearAllData() async {
  }
}
