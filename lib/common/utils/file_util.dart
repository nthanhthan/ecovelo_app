import 'dart:io';
import 'dart:typed_data';


import 'package:path_provider/path_provider.dart';

import 'log_util.dart';
import 'object_util.dart';
import 'uuid/uuid.dart';

class FileUtil {
  static String _dirPath = "";
  static Future<String> getDir() async {
    if (ObjectUtil.isEmptyString(_dirPath)) {
      _dirPath = (await getApplicationDocumentsDirectory()).path;
    }
    return _dirPath;
  }

  static Future<File> wirteFileToStorage(
      List<int> itemData, String fileName) async {
    String dir = await getDir();
    String filePath = "$dir/$fileName";

    File fileData = File(filePath);
    if (await fileData.exists()) {
      await fileData.delete();
    }
    return await fileData.writeAsBytes(itemData);
  }

  static Future<File> wirteImageToStorage(
    Uint8List itemData,
    String extensionFile, {
    String? fileName,
  }) async {
    if (ObjectUtil.isEmptyString(fileName)) {
      fileName = const Uuid().v1() + ".$extensionFile";
    }
    final buffer = itemData.buffer;
    return await wirteFileToStorage(
        buffer.asUint8List(itemData.offsetInBytes, itemData.lengthInBytes),
        fileName!);
  }

  static Future<File> wirteVideoToStorage(
    Uint8List itemData,
    String extensionFile, {
    String? fileName,
  }) async {
    if (ObjectUtil.isEmptyString(fileName)) {
      fileName = const Uuid().v1() + ".$extensionFile";
    }
    final buffer = itemData.buffer;
    return await wirteFileToStorage(
        buffer.asUint8List(itemData.offsetInBytes, itemData.lengthInBytes),
        fileName!);
  }

  static Future<bool> isExistsFile(String fileName) async {
    String dir = await getDir();
    String filePath = "$dir/$fileName";
    File fileData = File(filePath);
    if (await fileData.exists()) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getFilePath(String fileName) async {
    String dir = await getDir();
    String filePath = "$dir/$fileName";
    File fileData = File(filePath);
    if (await fileData.exists()) {
      return fileData.path;
    } else {
      return "";
    }
  }

  static Future<File> copyFileToStorage(File origin, String fileName) async {
    String dir = await getDir();
    String filePath = "$dir/$fileName";

    File fileData = File(filePath);
    if (await fileData.exists()) {
      await fileData.delete();
    }
    return await origin.copy(filePath);
  }

  static Future<bool> deleteFileInStorage(String filePath) async {
    File fileData = File(filePath);
    if (await fileData.exists()) {
      await fileData.delete();
    }
    return true;
  }

  static String getFileNameByUrl(String url, {bool isSkipUUID = false}) {
    String fileName = "";
    try {
      Uri uri = Uri.parse(url);
      fileName = uri.path.split('/').last;
      fileName = Uri.decodeComponent(fileName);
    } catch (e) {
      LogUtil.e("getFileNameByUrl error: " + e.toString());
      fileName = url.split('/').last;
    }
    //remove uuid in file name if the file name have start with uuid
    if (isSkipUUID && fileName.length > 36) {
      String uuidSplit = fileName.substring(0, 36);
      if (Uuid.isValidUUID(fromString: uuidSplit) &&
          fileName.substring(36, 37) == "-") {
        fileName = fileName.substring(37, fileName.length);
      }
    }

    return fileName;
  }

  static Future<int> fileSize(File file) async {
    var fileSize = await file.length();
    return fileSize;
  }
}
