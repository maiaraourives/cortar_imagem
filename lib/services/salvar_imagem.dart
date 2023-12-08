import 'dart:io';
import 'dart:typed_data';

class SalvarImagem {
  static Future<String> salvarImagem(Uint8List bytes, String outputFile) async {
    File(outputFile).writeAsBytesSync(bytes, flush: true);

    return '';
  }
}