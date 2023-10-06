import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../models/cortar_model.dart';
import '../../services/crop_image_service.dart';
import '../../services/image_picker_service.dart';
import '../../widgets/cs_text_form_field.dart';
import 'cortar_state.dart';
import 'cortar_validator.dart';

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
    if (formKey.currentState!.validate()) {
      final parts = await CropImageService.cropImage(cortar.colunas!, cortar.linhas!, stateView.image!);

      stateView.setPartsImages(parts);
    }
  }

  void salvarImagem() async{}

  @override
  Widget build(BuildContext context) {

    List<Widget> children = [];

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
                        validator: CortarValidator.validateLinha,
                      ),
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
                        validator: CortarValidator.validateColuna,
                      ),
                    ],
                  ),
                ),
              ),

              // ElevatedButton(
              //   onPressed: (){},
              //   child: const Text('Salvar imagem'),
              // ),

              Column(
                children: [
                  ElevatedButton(
                    onPressed: selectImage,
                    child: const Text('Selecionar Imagem'),
                  ),
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

          const SizedBox(height: 50),
          
          Container(
            margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cortar.colunas!,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (_, index) {
                final partsImages = stateView.partsImages[index];
                // children.add(Image.file(File(stateView.image!.path)));

                // for (int i = 0; i < partsImages.length; i += 2) {
                //   if (i < partsImages.length - 1) {
                //     late final String imagem;

                //     imagem = partsImages[i + 1].toString();

                //     children.add(Image.file(File(imagem)));
                //   }
                // }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}