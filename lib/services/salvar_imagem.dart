import 'dart:io';
import 'package:file_picker/file_picker.dart';
class SalvarImagem{

  static Future<String> salvarImagem(File file) async {

    String filename = 'imagem - ${DateTime.now().microsecondsSinceEpoch.toString()}.jpg';

    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Salve seu arquivo no local desejado',
      fileName: filename
    );

    File(outputFile!).writeAsBytesSync(file.readAsBytesSync());

    return outputFile;
  }
}