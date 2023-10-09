import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

///Salva uma imagem no diretório de arquivos da aplicação
Future<String> savePictureAppDirectory(File file) async {
  //await _verifyPermission();

  Directory dir = await getApplicationDocumentsDirectory();

  String dirPath = dir.path;

  //Nome do arquivo
  String filename = basename(file.path);

  //Path final onde a imagem será salva
  String savedPath = '$dirPath/$filename';

  //Arquivo a ser salvo instanciado em objeto File
  File image = File(file.path);

  //Arquivo a ser salvo
  File(savedPath).writeAsBytesSync(image.readAsBytesSync());

  return savedPath;
}

///Salva um arquivo no diretório de arquivos da aplicação
Future<String> saveFileAppDirectory(Uint8List file, String filename) async {
  //await _verifyPermission();

  Directory dir = await getApplicationDocumentsDirectory();

  String dirPath = dir.path;

  //Path final onde a imagem será salva
  String savedPath = '$dirPath/$filename';

  //Arquivo a ser salvo
  File(savedPath).writeAsBytesSync(file);

  return savedPath;
}

///Deleta um arquivo salvo, se existente
Future<void> deleteFile(String path) async {
  try {
    File file = File(path);

    if (file.existsSync()) {
      file.deleteSync();
    }
  } catch (_) {}
}
