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

  static Future<List<img.Image>> cropImage(int columns, int rows, XFile image, img.Image imgs) async {

    late ui.Image parteImagem;

    //TODO pegar o tamanho total da imagem
    int altura = imgs.height; //Altura da imagem
    int lagura = imgs.width; //Largura da imagem

    //TODO dividir o total da altura da imagem pela quantidade de linhas -> vai descobrir a altura de cada parte
    int alturaCada = altura ~/ rows;

    //TODO dividir o total da largura pela quantidade de colunas -> vai descobrir a largura de cada parte
    int laguraCada = lagura ~/ columns;

    //TODO FOR para cortar as imagens

    //Quando for a primeira será Y e X sempre zero
    for(int i = 1; i >= rows; i >= columns){
      int x = 0 ~/ columns;
      int y = 0 ~/ rows;
      imgs = img.copyCrop(image as img.Image, x, y, laguraCada, alturaCada);
    }
    
    //Quando for a primeira linha será Y sempre zero
    for(int i = 1; i >= rows; i < columns){
      int x = lagura ~/ columns;
      int y = 0 ~/ rows; 
      imgs = img.copyCrop(image as img.Image, x, y, laguraCada, alturaCada);
    }

    /////////////////////////////////////////////////////////////////////////////////////////

    //Quando for depois da primeira Y e X terão valores, sendo o Y o único que pode aumentar
    for(int i = 1; i < rows; i < columns){
      int x = lagura ~/ columns;
      if (i < rows){
        late final int y;
        y = alturaCada + i;
        imgs = img.copyCrop(image as img.Image, x, y, laguraCada, alturaCada);
      }
    }

    //Quando for a primeira coluna será X sempre zero, sendo o Y o único que pode aumentar
    for(int i = 1; i < rows; i >= columns){
      int x = 0 ~/ columns;
      if (i < rows){
        late final int y;
        y = alturaCada + i;
        imgs = img.copyCrop(image as img.Image, x, y, laguraCada, alturaCada);
      }
    }

    //Teste
    for(int i = 1; i >= rows; i >= columns){

      img.Image? teste;

      if(i >= columns){
        int x = 0 ~/ columns;
        teste = img.copyCrop(image as img.Image, x, alturaCada, laguraCada, alturaCada);
      }
      
      if (i >= rows){
        int y = 0 ~/ rows;
        teste = img.copyCrop(image as img.Image, laguraCada, y, laguraCada, alturaCada);
      }
      
      imgImageTo(teste!).then((value){
        parteImagem = value;
      });

    }

    //Teste
    for(int i = 1; i < rows; i < columns){

      img.Image? teste;

      int x = lagura ~/ columns;

      if (i < columns){
      int y = 0 ~/ rows; 
      imgs = img.copyCrop(image as img.Image, x, y, laguraCada, alturaCada);
      }

      if (i < rows){
        late final int y;
        y = alturaCada + i;
        imgs = img.copyCrop(image as img.Image, x, y, laguraCada, alturaCada);
      }
      
      imgImageTo(teste!).then((value){
        parteImagem = value;
      });

    }

    // imgImageTo(imgs!).then((value){
    //   parteImagem = value;
    // });

    
    //retornar a lista
    return [imgs];
  }
}
