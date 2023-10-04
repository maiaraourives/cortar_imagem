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

  static Future<List<img.Image>> cropImage(int columns, int rows, XFile file, img.Image image) async {

    int altura = image.height; //Altura da imagem
    int lagura = image.width; //Largura da imagem

    int alturaCada = altura ~/ rows;

    int laguraCada = lagura ~/ columns;

    //Quando for a primeira será Y e X sempre zero
    for(int i = 1; i >= rows; i >= columns){
      int x = lagura ~/ columns;
      int y = altura ~/ rows;

      if(i >= columns){
        int x = 0;
        image = img.copyCrop(file as img.Image, x, y, laguraCada, alturaCada);
      }

      if(i >= rows){
        int y = 0;
        image = img.copyCrop(file as img.Image, x, y, laguraCada, alturaCada);
      }

      for(int i = 1; i < rows; i < columns){
        
        if(i < columns){
          int x = lagura ~/ columns;
          image = img.copyCrop(file as img.Image, x, y, laguraCada, alturaCada);
        }

        if (i < rows){
          late final int y;
          y = alturaCada + i;
          image = img.copyCrop(file as img.Image, x, y, laguraCada, alturaCada);
        }

      }
    }

    imgImageTo(image).then((value){
      file;
    });

    //retornar a lista
    return [image];
  }
}
