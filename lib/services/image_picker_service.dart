import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

///Obtém uma foto através da câmera -> `Solicitações`
Future<XFile?> openCamera() async {
  XFile? photo = await ImagePicker().pickImage(
    source: ImageSource.camera,
    imageQuality: 80,
    preferredCameraDevice: CameraDevice.front,
  );

  return photo;
}

///Obtém uma foto através da galeria
Future<List<XFile>?> openGaleria([List<String>? whiteList]) async {
  List<XFile>? gallery = await ImagePicker().pickMultiImage(imageQuality: 100);

  List<String> whiteListExt = whiteList ?? ['.png', '.jpg', '.jpeg', '.pdf', '.docx', '.docs', '.rtf', '.doc'];

  if (gallery.isNotEmpty) {
    int count = gallery.where((e) => !whiteListExt.contains(e.path)).toList().length;

    //Remove documentos com extensões não permitidas
    if (count > 0) {
      gallery.removeWhere((e) => !whiteListExt.contains(extension(e.path)));
    }
  }

  return gallery;
}