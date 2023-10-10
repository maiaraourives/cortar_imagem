import 'dart:io';

class SalvarImagem{

  static Future<String> salvarImagem(File file) async {
    
    String filename = 'imagem - ${DateTime.now().microsecondsSinceEpoch.toString()}.jpg';

    String savedPath = '$filename';

    File(file.path);

    return savedPath;

  }

}