import 'dart:io';

import 'package:path_provider/path_provider.dart';

class SalvarImagem{

  static Future<String> salvarImagem(File file) async {

    Directory directory = Directory('C:/Users/maiara.ferreira/Documents');
    
    if (!await directory.exists()) directory = (await getExternalStorageDirectory())!;

    String filename = 'imagem - ${DateTime.now().microsecondsSinceEpoch.toString()}.jpg';

    String savedPath = '$filename';

    File(file.path);

    return savedPath;
  }
}