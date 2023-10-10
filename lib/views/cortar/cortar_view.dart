import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image/image.dart' as img;

import '../../models/cortar_model.dart';
import '../../services/crop_image_service.dart';
import '../../services/image_picker_service.dart';
import '../../services/salvar_imagem.dart';
import '../../widgets/cs_text_form_field.dart';
import 'cortar_state.dart';

class CortarView extends StatefulWidget {
  const CortarView({super.key});

  @override
  State<CortarView> createState() => _CortarViewState();
}

class _CortarViewState extends State<CortarView> {
  CortarModel cortar = CortarModel();

  final stateView = CortarState();

  final formKey = GlobalKey<FormState>();

  ///[Controllers]
  final colunaController = TextEditingController();
  final linhaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    colunaController.text = cortar.colunas?.toString() ?? '';
    linhaController.text = cortar.linhas?.toString() ?? '';
  }

  @override
  void dispose() {
    colunaController.dispose();
    linhaController.dispose();

    super.dispose();
  }

  void selectImage() async {
    try {
      final image = await openGaleria();

      if (image?.isNotEmpty ?? false) {
        stateView.setImage(image?.first);
      }
    } catch (_) {}
  }

  void cropImage() async {
    final parts = await CropImageService.cropImage(cortar.colunas!, cortar.linhas!, stateView.image!);
    stateView.setPartsImages(parts);
    if (formKey.currentState!.validate()) {

    }
  }

  void salvarImagem() async {
    final imagem = await SalvarImagem.salvarImagem(stateView.partsImages);
    stateView.setPartsImages(imagem);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Cortar imagem')),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [

          Row(
            children: [
              Expanded(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [

                      //Campo para informar o número de linhas
                      CsTextFormField(
                        keyboardType: TextInputType.number,
                        controller: linhaController,
                        labelText: 'Linhas',
                        hintText: 'Informe o número de linhas',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        onChanged: (linha) {
                          cortar.linhas = int.tryParse(linha!);
                        },
                        //validator: CortarValidator.validateLinha,
                      ),

                      //Campo de número de colunas (fixo)
                      CsTextFormField(
                        keyboardType: TextInputType.number,
                        controller: colunaController,
                        labelText: 'Colunas',
                        enabled: false,
                        hintText: 'Informe o número de colunas',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        onChanged: (coluna) {
                          cortar.colunas = int.tryParse(coluna!);
                        },
                        //validator: CortarValidator.validateColuna,
                      ),

                    ],
                  ),
                ),
              ),

              

              Column(
                children: [

                  //ElevatedButton para selecionar imagem
                  ElevatedButton(
                    onPressed: selectImage,
                    child: const Text('Selecionar Imagem'),
                  ),

                  //ElevatedButton para cortar imagem
                  Observer(
                    builder: (_) {
                      return ElevatedButton(
                        onPressed: stateView.image == null ? null : cropImage,
                        child: const Text('Cortar Imagem'),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          //Campo que exibe as imagens cortadas
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            child: Observer(builder: (_){
              return GridView.builder(
              shrinkWrap: true,
              itemCount: stateView.partsImages.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cortar.colunas!,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (_, index) {
                final partsImages = stateView.partsImages[index];

                final imageBytes = img.encodePng(partsImages);

                final bytes = Uint8List.fromList(imageBytes);
                
                return Image.memory(bytes, fit: BoxFit.fill);
              },
            );
            }),
          ),

          ElevatedButton(
            onPressed: salvarImagem,
            child: const Text('Salvar imagem'),
          ),
        ],
      ),
    );
  }
}