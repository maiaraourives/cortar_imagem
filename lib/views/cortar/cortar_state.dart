import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'cortar_state.g.dart';

class CortarState = _CortarState with _$CortarState;

abstract class _CortarState with Store {
  @observable
  XFile? _image;

  @observable
  ObservableList<img.Image> _partsImages = ObservableList();

  @computed
  XFile? get image => _image;

  @computed
  List<img.Image> get partsImages => [..._partsImages];

  @action
  void setImage(XFile? image) {
    _image = image;
  }

  @action
  void setPartsImages(List<img.Image> parts) {
    _partsImages = parts.asObservable();
  }
}
