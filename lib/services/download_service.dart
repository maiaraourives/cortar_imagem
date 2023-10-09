import 'dart:io';

import 'package:flutter/services.dart';

import '../configs/constants.dart';
import 'file_storage_service.dart';
import 'shared_service.dart';

class DownloadService {
  static Future<String?> download(String link) async {
    String? path = await SharedService.getString(SharedKeys.IMAGES);

    if (path != null) {
      return path;
    }

    try {
      ByteData data = await downloadImage(link);
      String path = await saveImage(data);

      if (path.isNotEmpty) {
        await SharedService.saveString(SharedKeys.IMAGES, path);
      }

      return path;
    } catch (_) {}

    return path;
  }

  static Future<ByteData> downloadImage(String link) async {
    return await NetworkAssetBundle(Uri.parse(link)).load('');
  }

  static Future<String> saveImage(ByteData data) async {
    for (int i = 0; i < 5; i++) {
      String filename = 'imagem-quebra-cabeca-${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';

      File file = File(filename);

      if (!file.existsSync()) {
        return await saveFileAppDirectory(data.buffer.asUint8List(), filename);
      }
    }

    throw 'Não foi possível salvar a imagem';
  }
}
