import 'dart:io';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class CropImageService {
  //Coverte a imagem para ui
  static Future<ui.Image> imgImageTo(img.Image image) async {
    ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(image.getBytes(format: img.Format.rgba));
    ui.ImageDescriptor id = ui.ImageDescriptor.raw(buffer, height: image.height, width: image.width, pixelFormat: ui.PixelFormat.rgba8888);
    ui.Codec codec = await id.instantiateCodec(targetHeight: image.height, targetWidth: image.width);
    ui.FrameInfo fi = await codec.getNextFrame();
    ui.Image part = fi.image;

    return part;
  }

  static Future<List<img.Image>> cropImage(int columns, int rows, XFile file) async {
    final path = file.path;

    final bytes = File(path).readAsBytesSync();

    final imageBytes = img.decodeImage(bytes)!;

    int altura = imageBytes.height; //Altura da imagem

    int lagura = imageBytes.width; //Largura da imagem

    int alturaCada = altura ~/ rows; //Altura de cada row

    int laguraCada = lagura ~/ columns; //Largura de cada column

    List<img.Image> partesImagens = [];

    //Realização do corte da imagem
    for (int i = 0; i < rows; i++) {
      int y = alturaCada * i;

      if (i < rows) {
        int x = 0;

        img.Image crop = img.copyCrop(imageBytes, x, y, laguraCada, alturaCada);

        partesImagens.add(crop);
      }

      for (int j = 0; j < columns; j++) {
        if (j % 2 == 1) {
          int x = laguraCada * j;

          img.Image crop = img.copyCrop(imageBytes, x, y, laguraCada, alturaCada);

          partesImagens.add(crop);
        }
      }
    }

    //retornar a lista
    return partesImagens;
  }
}
