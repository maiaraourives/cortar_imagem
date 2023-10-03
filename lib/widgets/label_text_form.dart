import 'package:flutter/material.dart';

class LabelTextForm extends StatelessWidget {
  ///Retorna uma Label [Text], exibido junto ao [CustomTextFormField]
  ///
  ///Passe [isRequired] como `true` para o campo ser obrigatório
  const LabelTextForm({
    required this.label,
    this.child,
    this.isRequired = false,
    this.suffixIcon,
    this.enabled = true,
    this.withSign = true,
    super.key,
  });

  final String label;
  final Widget? child;
  final bool isRequired;
  final Widget? suffixIcon;
  final bool enabled;
  final bool withSign;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 12, top: 10),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: label,
                      style: isRequired
                          ? TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: enabled ? Colors.grey[700] : Colors.grey[300],
                            )
                          : TextStyle(
                              fontSize: 14,
                              color: enabled ? Colors.grey[700] : Colors.grey[300],
                            ),
                    ),
                    if (isRequired) ...[
                      if (withSign) ...[
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: enabled ? theme.colorScheme.error : Colors.red[100],
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
            if (child != null) ...[
              child!,
            ],
          ],
        ),

        /// Define a posição do ícone que será exibida no [TextField], se possuir
        if (suffixIcon != null) ...[
          Positioned(
            top: 0,
            bottom: 0,
            right: 5,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 12),
              child: suffixIcon!,
            ),
          ),
        ],
      ],
    );
  }
}
