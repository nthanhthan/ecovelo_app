import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'object_util.dart';
class StorageUtil {
  static Future<Directory> _initTempDir() {
    return getTemporaryDirectory();
  }

  static Future<Directory?> _initAppDocDir() async {
    return getApplicationDocumentsDirectory();
  }

  static Future<Directory?> _initStorageDir() async {
    return getExternalStorageDirectory();
  }

  static Directory? createDirSync(String path) {
    if (ObjectUtil.isEmpty(path)) return null;
    Directory dir = Directory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return dir;
  }

  static Future<Directory?> createDir(String path) async {
    if (ObjectUtil.isEmpty(path)) return null;
    Directory dir = Directory(path);
    bool exist = await dir.exists();
    if (!exist) {
      dir = await dir.create(recursive: true);
    }
    return dir;
  }

  /// fileName 
  /// dirName 
  /// String path = StorageUtil.getTempPath(fileName: 'demo.png', dirName: 'image');
  /// Android: /data/user/0/com.thl.flustars_example/cache/image/demo.png
  /// iOS: /var/mobile/Containers/Data/Application/xxx/Library/Caches/image/demo.png;
  static Future<String?> getTempPath({
    String? fileName,
    String? dirName,
  }) async {
    Directory _tempDir = await _initTempDir();
    // ignore: unnecessary_null_comparison
    if (_tempDir == null) {
      return null;
    }
    StringBuffer sb = StringBuffer(_tempDir.path);
    if (!ObjectUtil.isEmpty(dirName)) {
      sb.write("/$dirName");
      await createDir(sb.toString());
    }
    if (!ObjectUtil.isEmpty(fileName)) sb.write("/$fileName");
    return sb.toString();
  }

  /// fileName 
  /// dirName 
  /// String path = StorageUtil.getAppDocPath(fileName: 'demo.mp4', dirName: 'video');
  /// Android: /data/user/0/com.thl.flustars_example/app_flutter/video/demo.mp4
  /// iOS: /var/mobile/Containers/Data/Application/xxx/Documents/video/demo.mp4;
  static Future<String?> getAppDocPath({
    String? fileName,
    String? dirName,
  }) async {
    Directory? _appDocDir = await _initAppDocDir();
    if (_appDocDir == null) {
      return null;
    }
    StringBuffer sb = StringBuffer(_appDocDir.path);
    if (!ObjectUtil.isEmpty(dirName)) {
      sb.write("/$dirName");
      await createDir(sb.toString());
    }
    if (!ObjectUtil.isEmpty(fileName)) sb.write("/$fileName");
    return sb.toString();
  }

  /// fileName 
  /// dirName 
  /// category video，image
  /// String path = StorageUtil.getStoragePath(fileName: 'flutterwanandroid.apk', dirName: 'apk');
  /// Android: /storage/emulated/0/com.thl.flutterwanandroid/apk/flutterwanandroid.apk
  /// iOS: ;
  static Future<String?> getStoragePath({
    String? fileName,
    String? dirName,
  }) async {
    Directory? _storageDir = await _initStorageDir();
    if (_storageDir == null) {
      return null;
    }
    StringBuffer sb = StringBuffer(_storageDir.path);
    if (!ObjectUtil.isEmpty(dirName)) {
      sb.write("/$dirName");
      await createDir(sb.toString());
    }
    if (!ObjectUtil.isEmpty(fileName)) sb.write("/$fileName");
    return sb.toString();
  }

  /// dirName
  /// String path = StorageUtil.createTempDir( dirName: 'image');
  /// Android: /data/user/0/com.thl.flustars_example/cache/image
  /// iOS: /var/mobile/Containers/Data/Application/xxx/Library/Caches/image
  static Future<Directory?> createTempDir({String? dirName}) async {
    Directory? _tempDir = await _initTempDir();
    // ignore: unnecessary_null_comparison
    if (_tempDir == null) {
      return null;
    }
    StringBuffer sb = StringBuffer(_tempDir.path);
    if (!ObjectUtil.isEmpty(dirName)) sb.write("/$dirName");
    return createDir(sb.toString());
  }

  /// fileName 
  /// dirName
  /// String path = StorageUtil.getAppDocPath(fileName: 'demo.mp4', dirName: 'video');
  /// Android: /data/user/0/com.thl.flustars_example/app_flutter/video
  /// iOS: /var/mobile/Containers/Data/Application/xxx/Documents/video
  static Future<Directory?> createAppDocDir({String? dirName}) async {
    Directory? _appDocDir = await _initAppDocDir();
    if (_appDocDir == null) {
      return null;
    }
    StringBuffer sb = StringBuffer(_appDocDir.path);
    if (!ObjectUtil.isEmpty(dirName)) sb.write("/$dirName");
    return createDir(sb.toString());
  }

  /// dirName 
  /// category video，image
  /// String path = StorageUtil.getStoragePath(fileName: 'flutterwanandroid.apk', dirName: 'apk');
  /// Android: /storage/emulated/0/com.thl.flutterwanandroid/apk
  /// iOS: ;
  static Future<Directory?> createStorageDir({String? dirName}) async {
    Directory? _storageDir = await _initStorageDir();
    if (_storageDir == null) {
      return null;
    }
    StringBuffer sb = StringBuffer(_storageDir.path);
    if (!ObjectUtil.isEmpty(dirName)) sb.write("/$dirName");
    return createDir(sb.toString());
  }
}