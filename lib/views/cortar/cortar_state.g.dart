// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cortar_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CortarState on _CortarState, Store {
  Computed<XFile?>? _$imageComputed;

  @override
  XFile? get image => (_$imageComputed ??=
          Computed<XFile?>(() => super.image, name: '_CortarState.image'))
      .value;
  Computed<List<img.Image>>? _$partsImagesComputed;

  @override
  List<img.Image> get partsImages => (_$partsImagesComputed ??=
          Computed<List<img.Image>>(() => super.partsImages,
              name: '_CortarState.partsImages'))
      .value;

  late final _$_imageAtom = Atom(name: '_CortarState._image', context: context);

  @override
  XFile? get _image {
    _$_imageAtom.reportRead();
    return super._image;
  }

  @override
  set _image(XFile? value) {
    _$_imageAtom.reportWrite(value, super._image, () {
      super._image = value;
    });
  }

  late final _$_partsImagesAtom =
      Atom(name: '_CortarState._partsImages', context: context);

  @override
  ObservableList<img.Image> get _partsImages {
    _$_partsImagesAtom.reportRead();
    return super._partsImages;
  }

  @override
  set _partsImages(ObservableList<img.Image> value) {
    _$_partsImagesAtom.reportWrite(value, super._partsImages, () {
      super._partsImages = value;
    });
  }

  late final _$_CortarStateActionController =
      ActionController(name: '_CortarState', context: context);

  @override
  void setImage(XFile? image) {
    final _$actionInfo = _$_CortarStateActionController.startAction(
        name: '_CortarState.setImage');
    try {
      return super.setImage(image);
    } finally {
      _$_CortarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPartsImages(List<img.Image> parts) {
    final _$actionInfo = _$_CortarStateActionController.startAction(
        name: '_CortarState.setPartsImages');
    try {
      return super.setPartsImages(parts);
    } finally {
      _$_CortarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
image: ${image},
partsImages: ${partsImages}
    ''';
  }
}
