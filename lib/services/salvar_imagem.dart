import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SalvarImagem{

  static Future<dynamic> salvarImagem(List<img.Image> image) async {

    try {
      final file = await ImagePicker().pickMedia(imageQuality: 100);
      
      // final imagem = img.encodeCurImages(image);

      // final base64 = base64Encode(imagem);

      // final file = File(base64); 

      for (int i = 0; i < 10;) {

        if (file != null) {
          final File storeImage = File(file.path);

          final appDir = await getApplicationDocumentsDirectory();

          final fileName = basename(file.path);
    
          final File localImage = await storeImage.copy('${appDir.path}/parte-$i-$fileName ');

          return localImage;

        }

      }

    }catch(_) {}
  }
}

