import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image/image.dart' as img;

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
      final parts = await CropImageService.cropImage(cortar.colunas!, cortar.linhas!, stateView.image!, stateView.image as img.Image);

      stateView.setPartsImages(parts);
    }
  }

  @override
  Widget build(BuildContext context) {

    // final partsImages = stateView.partsImages;

    List<Widget> children = [];
    
    // for (int i = 1; i < partsImages.hashCode; i += 2) {
    //   if (i < partsImages.hashCode - 1) {
    //     img.Image parte1;
    //     img.Image parte2;

    //     parte1 = stateView.partsImages;
    //     parte2 = stateView.partsImages;
        
    //     children.add(Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         RawImage(image: parte1),
    //         RawImage(image: parte2),
    //       ],
    //     ));
    //   }
    // }

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

          //TODO exibir aqui as imagens cortadas. Utilizar GridView com axisCount = cortar.colunas
          
          Container(
            margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: stateView.partsImages.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cortar.colunas!,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (_, index) {
                // final partsImages = stateView.partsImages[index];
                
                return Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child:  ClipRRect(
                          child:  SingleChildScrollView(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: children,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
