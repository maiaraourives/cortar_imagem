import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class CropImageService {
  //Coverte a imagem para ui
  Future<ui.Image> imgImageTo(img.Image image) async {
    ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(image.getBytes(format: img.Format.rgba));
    ui.ImageDescriptor id = ui.ImageDescriptor.raw(buffer, height: image.height, width: image.width, pixelFormat: ui.PixelFormat.rgba8888);
    ui.Codec codec = await id.instantiateCodec(targetHeight: image.height, targetWidth: image.width);
    ui.FrameInfo fi = await codec.getNextFrame();
    ui.Image part = fi.image;

    return part;
  }

  // //Carrega as 'peças' da imagem e as recorta
  // Future<void> loadingImage() async {
  //   List<int> imageBase64 = imageGaleria!.readAsBytesSync();
  //   String imageAsString = base64Encode(imageBase64);
  //   Uint8List uint8list = base64.decode(imageAsString);
  //   image = Image.memory(uint8list) as img.Image?;

  //   // ByteData data = await rootBundle.load('assets/img/teste.png');
  //   // image = img.decodeImage(data.buffer.asUint8List())!;

  //   //TODO Os primeiro Y sempre são 0 e também os primeiros X

  //   //Recorta as imagem conforme for seu posiocionamento
  //   imageCroppedOne = img.copyCrop(image!, 0, 0, w, h);
  //   //x
  //   imageCroppedTwo = img.copyCrop(image!, x, 0, w, h);
  //   //y
  //   imageCroppedThree = img.copyCrop(image!, 0, y, w, h);
  //   //y | x
  //   imageCroppedFour = img.copyCrop(image!, x, y, w, h);
  //   // //y+y
  //   // imageCroppedFive = img.copyCrop(image!, 0, y + y, w, h);
  //   // //y+y | x
  //   // imageCroppedSix = img.copyCrop(image!, x, y + y, w, h);
  // }

  static Future<List<img.Image>> cropImage(int columns, int rows, XFile image) async {
    //TODO pegar o tamanho total da imagem
    //TODO dividir o total da altura da imagem pela quantidade de linhas -> vai descobrir a altura de cada parte
    //TODO dividir o total da largura pela quantidade de colunas -> vai descobrir a largura de cada parte

    //TODO FOR para cortar as imagens

    //retornar a lista
    return [];
  }
}
