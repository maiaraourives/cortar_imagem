import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SalvarImagem{

  static Future<dynamic> salvarImagem(List<img.Image> image) async {

    try {
      final pickedFile = await ImagePicker().pickMedia(imageQuality: 100);

      for (int i = 0; i < 10; i++) {

        if (pickedFile != null) {
          final File storeImage = File(pickedFile.path);

          final appDir = await getApplicationDocumentsDirectory();

          final fileName = basename(pickedFile.path);
    
          final File localImage = await storeImage.copy('${appDir.path}/parte-$i-$fileName ');

          return localImage;

        }

      }

    }catch(_) {}
  }
}

