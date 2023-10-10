import 'dart:io';

import 'package:path_provider/path_provider.dart';

class SalvarImagem{

  static Future<String> salvarImagem(File file) async {

    Directory dir = await getApplicationDocumentsDirectory();

    String dirPath = dir.path;

    String filename = 'imagem - ${DateTime.now().microsecondsSinceEpoch.toString()}.jpg';

    String savedPath = '$dirPath/$filename';

    File image = File(file.path);

    File(savedPath).writeAsBytesSync(image.readAsBytesSync());

    return savedPath;
  }
}