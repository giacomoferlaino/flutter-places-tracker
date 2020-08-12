import 'dart:io';

class DeviceStorageService {
  final Directory appDir;

  DeviceStorageService(this.appDir);

  Future<File> saveFile(File file, String filePath) async {
    return file.copy('${appDir.path}/$filePath');
  }
}
