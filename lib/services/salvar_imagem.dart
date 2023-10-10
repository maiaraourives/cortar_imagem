import 'dart:io';

import 'dart:io' as io;

class SalvarImagem{

  static Future<String> salvarImagem(File file) async {

    // para um arquivo
    io.File(file.path).exists();

    // // para um diretório
    // io.Directory(await path).exists();

    String filename = 'imagem - ${DateTime.now().microsecondsSinceEpoch.toString()}.jpg';

    String savedPath = '$filename';

    File(file.path);

    return savedPath;
  }
}