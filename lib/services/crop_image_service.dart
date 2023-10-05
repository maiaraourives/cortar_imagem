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
    final bytes = await File(path).readAsBytes();

    var imageBytes = img.decodeImage(bytes)!;

    // img.Image image;

    int altura = imageBytes.height; //Altura da imagem
    int lagura = imageBytes.width; //Largura da imagem

    int alturaCada = altura ~/ rows;

    int laguraCada = lagura ~/ columns;


    //Quando for a primeira será Y e X sempre zero
    for(int i = 0; i < rows; i ++){

      if(i > rows){
        int x = lagura ~/ columns;
        int y = 0;

        imageBytes = img.copyCrop(imageBytes, x, y, laguraCada, alturaCada);
      }

      if (i < rows){
        late final int y;
        y = alturaCada * i;
        int x = lagura ~/ columns;

        imageBytes = img.copyCrop(imageBytes, x, y, laguraCada, alturaCada);
      }

      for(int i = 0; i < columns; i ++){

        if(i > columns){
          int y = altura ~/ rows;
          int x = 0;

          imageBytes = img.copyCrop(imageBytes, x, y, laguraCada, alturaCada);
        }
        
        if(i < columns){
          int x = lagura * i;
          int y = altura ~/ rows;

          imageBytes = img.copyCrop(imageBytes, x, y, laguraCada, alturaCada);
        }
      }
    }

    //retornar a lista
    return [imageBytes];
  }
}
