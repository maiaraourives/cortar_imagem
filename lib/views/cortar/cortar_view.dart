import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/cortar/cortar_model.dart';
import '../../widgets/cs_text_form_field.dart';
import '../../widgets/label_text_form.dart';
import 'cortar_state.dart';
import 'cortar_validator.dart';

class CortarView extends StatefulWidget {
  const CortarView({    
    this.cortar,
    super.key,
  });

  final CortarModel? cortar;

  @override
  State<CortarView> createState() => _CortarViewState();
}

class _CortarViewState extends State<CortarView> {
  CortarModel? cortar;

  final stateView = CortarState();

  final formKey = GlobalKey<FormState>();

  ///[Controllers]
  final colunaController = TextEditingController();
  final linhaController = TextEditingController();

  bool _showProcessed = false;

  bool _quebraCabeca = false;
  
  File? _image;
  
  final picker = ImagePicker();

  img.Image? image;

  img.Image? imageCroppedOne;
  ui.Image? _partOne;

  img.Image? imageCroppedTwo;
  ui.Image? _partTwo;

  img.Image? imageCroppedThree;
  ui.Image? _partThree;

  img.Image? imageCroppedFour;
  ui.Image? _partFour;

  // img.Image? imageCroppedFive;
  // ui.Image? _partFive;

  // img.Image? imageCroppedSix;
  // ui.Image? _partSix;

  ///TODO Foi testado e funciona está forma mas ainda a parte da linha não funcionou com a imagem
  late int height = image!.height; //Altura de cada imagem
  late int width = image!.width; //Largura de cada imagem
  late int coluna = 2;
  late int linha = cortar!.linhas.length;

  late int h = height ~/ linha;
  late int y = height ~/ linha;
  late int w = width ~/ coluna;
  late int x = width ~/ coluna;

  @override
  void initState() {
    super.initState();

    cortar = widget.cortar ?? CortarModel();

    if (_image != null) {
      loadingImage().then((value){
        imgImageTo(imageCroppedOne!).then((value){
          _partOne = value;
        });
        imgImageTo(imageCroppedTwo!).then((value){
          _partTwo = value;
        });
        imgImageTo(imageCroppedThree!).then((value){
          _partThree = value;
        });
        imgImageTo(imageCroppedFour!).then((value){
          _partFour = value;
        });
        // imgImageTo(imageCroppedFive!).then((value){
        //   _partFive = value;
        // });
        // imgImageTo(imageCroppedSix!).then((value){
        // _partSix = value;
        // });
      });
    }
 
    if (widget.cortar != null) {
      _initialData();
    }
  }

  @override
  void dispose() {
    colunaController.dispose();
    linhaController.dispose();

    super.dispose();
  }

  void _initialData() {
    linhaController.text = cortar!.linhas;
  }

  //Carrega as 'peças' da imagem e as recorta
  Future<void> loadingImage() async {
    List<int> imageBase64 = _image!.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    image = Image.memory(uint8list) as img.Image?;

    // ByteData data = await rootBundle.load('assets/img/teste.png');
    // image = img.decodeImage(data.buffer.asUint8List())!;

    /////TODO Os primeiro Y sempre são 0 e também os primeiros X

    //Recorta as imagem conforme for seu posiocionamento
    imageCroppedOne = img.copyCrop(image!, 0, 0, w, h);
    //x
    imageCroppedTwo = img.copyCrop(image!, x, 0, w, h);
    //y
    imageCroppedThree = img.copyCrop(image!, 0, y, w, h);
    //y | x
    imageCroppedFour = img.copyCrop(image!, x, y, w, h);
    // //y+y
    // imageCroppedFive = img.copyCrop(image!, 0, y + y, w, h);
    // //y+y+y | x
    // imageCroppedSix = img.copyCrop(image!, x, y + y, w, h);
  }

  //Coverte a imagem para ui
  Future<ui.Image> imgImageTo(img.Image image) async{
    ui.ImmutableBuffer buffer = await
      ui.ImmutableBuffer.fromUint8List(
          image.getBytes(format: img.Format.rgba));
    ui.ImageDescriptor id = ui.ImageDescriptor.raw(
        buffer,
        height: image.height,
        width: image.width,
        pixelFormat: ui.PixelFormat.rgba8888);
    ui.Codec codec = await id.instantiateCodec(
        targetHeight: image.height,
        targetWidth: image.width);
    ui.FrameInfo fi = await codec.getNextFrame();
    ui.Image part = fi.image;
    return part;
  }

  //Pega a imagem da galeria 
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }
  
  //Direciona para Galeria
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Galeria'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery();
            },
          ),
        ],
      ),
    );
  }

  //Verifica os campos
  void _verifica({bool localAuth = false}){
    localAuth || formKey.currentState!.validate();
    setState(() {
      if(_quebraCabeca == false){
        _quebraCabeca = true;
      } else{
        _quebraCabeca = false;
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cortar imagem teste'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: _showProcessed ?   Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                _quebraCabeca 
                ? _image == null 
                ? const Text('Nenhuma imagem selecionada para cortar') 
                : Image.file(_image!) 
                : _partOne == null 
                ? const Text('Não foi realizado o quebra-cabeça') : 
                Column(
                  children: [
                    Row(
                      children: [
                        Container(margin: const EdgeInsets.all(5), child: RawImage(image: _partOne),),
                        Container(margin: const EdgeInsets.all(5), child: RawImage(image: _partTwo),),
                      ],
                    ),
                    Row(
                      children: [
                        Container(margin: const EdgeInsets.all(5), child: RawImage(image: _partThree),),
                        Container(margin: const EdgeInsets.all(5), child: RawImage(image: _partFour),),
                      ],
                    ),
                  ],
                )
              ]
            ) : Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: _image == null ? const Text('Nenhuma imagem selecionada') : Image.file(_image!),
                  ),
                ],
              ),
            ),
          ),

          Observer(
            builder: (_) {
              return Visibility(
                visible: _showProcessed == false,
                child: ElevatedButton(
                  onPressed: showOptions,
                  child: const Text('Selecionar a imagem'),
                ),
              );
            }
          ),

          Observer(
            builder: (_) {
              return Visibility(
                visible: _showProcessed == false,
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      if(_showProcessed == false){
                      _showProcessed = true;
                      }
                    });
                  },
                  child: const Text('Ir para cortar Image'),
                ),
              );
            }
          ),

          Observer(
            builder: (_) {
              return Visibility(
                visible: _quebraCabeca == true && _showProcessed == true,
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      if(_showProcessed == true){
                      _showProcessed = false;
                      }
                    });
                  },
                  child: const Text('Voltar'),
                ),
              );
            }
          ),

          Observer(
            builder: (_) {
              return Visibility(
                visible: _quebraCabeca  == false && _showProcessed == true,
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      if(_quebraCabeca == false){
                      _quebraCabeca = true;
                      }
                    });
                  },
                  child: const Text('Voltar'),
                ),
              );
            }
          ),
          
          Observer(
            builder: (_) {
              return Visibility(
                visible: _quebraCabeca == true && _showProcessed == true,
                child: LabelTextForm(
                  label: 'Divisão de colunas e linhas:',
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Form(
                      key: formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Linha:', 
                                style:  TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:Colors.grey[700],
                                ),
                              ) ,
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: CsTextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: linhaController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'),
                                    ),
                                  ],
                                  onChanged: (linha) {
                                    cortar!.setLinhas(linha!);
                                    stateView.setHouveAlteracoes(); 
                                  },
                                  validator: CortarValidator.validateLinha,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 50),

                          ElevatedButton(
                            onPressed: _verifica,
                            child: const Text('Cortar a imagem '),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
