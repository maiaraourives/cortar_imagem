import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CsTextFormField extends StatelessWidget {
  ///[TextFormField] utilizados no aplicativo
  const CsTextFormField({
    this.hintText,
    this.labelText,
    this.controller,
    this.validator,
    this.isActiveError = false,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.forceDisable = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLength,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.contentPadding,
    this.topPadding = 20,
    this.bottomPadding = 12,
    this.focusNode,
    this.colorText = Colors.grey,
    this.errorText,
    this.isEnabledBorder = true,
    super.key,
  });

  ///[TextFormField] small utilizados no aplicativo
  const CsTextFormField.small({
    this.hintText,
    this.labelText,
    this.controller,
    this.validator,
    this.isActiveError = true,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.characters,
    this.autovalidateMode = AutovalidateMode.always,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.forceDisable = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLength,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.contentPadding,
    this.topPadding = 5,
    this.bottomPadding = 12,
    this.focusNode,
    this.colorText = Colors.black,
    this.errorText,
    this.isEnabledBorder = true,
    super.key,
  });

  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? isActiveError;
  final void Function(String?)? onChanged;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool enabled;
  final bool forceDisable;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final EdgeInsets? contentPadding;
  final double topPadding;
  final double bottomPadding;
  final FocusNode? focusNode;
  final Color? colorText;
  final String? errorText;
  final bool isEnabledBorder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        IgnorePointer(
          ignoring: true,
          child: TextFormField(
            enabled: forceDisable ? false : !enabled,
            validator: validator,
            autovalidateMode: autovalidateMode,
            decoration: InputDecoration(
              isDense: true,
              // Padding do [TextField] muda conforme possui ícone ou não
              contentPadding: contentPadding ??
                  EdgeInsets.fromLTRB(
                    prefixIcon != null ? 50 : 12,
                    topPadding,
                    suffixIcon != null ? 50 : 12,
                    bottomPadding,
                  ),
              errorStyle: isActiveError!
                  ? TextStyle(color: theme.colorScheme.error)
                  // fontSize 0 para esconder o texto
                  : const TextStyle(fontSize: 0),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              disabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),

        TextFormField(
          //Campos obrigatórios
          controller: controller,
          validator: validator,
          onChanged: onChanged,

          //Campos opcionais
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          autovalidateMode: autovalidateMode,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          enabled: enabled,
          maxLength: maxLength,
          autofocus: autofocus,
          enableSuggestions: enableSuggestions,
          autocorrect: autocorrect,
          textInputAction: textInputAction,
          maxLines: maxLines,
          focusNode: focusNode,

          //Default
          style: TextStyle(
            color: colorText,
          ),
          decoration: isEnabledBorder
              ? InputDecoration(
                  errorStyle: isActiveError!
                      ? TextStyle(
                          color: theme.colorScheme.error,
                        )
                      // fontSize 0 para esconder o texto
                      : const TextStyle(fontSize: 0),
                  fillColor: Colors.transparent,
                  filled: true,
                  hintText: hintText,
                  labelText: labelText,
                  enabled: enabled,
                  isDense: true,
                  counterText: '',
                  errorText: errorText,

                  // Padding do [TextField] muda conforme possui ícone ou não
                  // (left, top, rigth, bottom),
                  contentPadding: contentPadding ??
                      EdgeInsets.fromLTRB(
                        prefixIcon != null ? 50 : 12,
                        topPadding,
                        suffixIcon != null ? 50 : 12,
                        12,
                      ),
                )
              : InputDecoration(
                  isDense: true,
                  // Padding do [TextField] muda conforme possui ícone ou não
                  // (left, top, rigth, bottom),
                  contentPadding: contentPadding ??
                      EdgeInsets.fromLTRB(
                        prefixIcon != null ? 50 : 12,
                        topPadding,
                        suffixIcon != null ? 50 : 12,
                        12,
                      ),
                  errorStyle: isActiveError!
                      ? TextStyle(
                          color: theme.colorScheme.error,
                        )
                      : const TextStyle(fontSize: 0),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  disabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
          scrollPhysics: const BouncingScrollPhysics(),
        ),

        ///Define a posição do ícone que será exibida no [TextField], se possuir
        if (prefixIcon != null) ...[
          Positioned(
            top: 15,
            bottom: 10,
            left: 5,
            child: prefixIcon!,
          ),
        ],

        ///Define a posição do ícone que será exibida no [TextField], se possuir
        if (suffixIcon != null) ...[
          Positioned(
            top: topPadding == 5 ? 0 : 10,
            bottom: 5,
            right: 0,
            child: suffixIcon!,
          ),
        ],
      ],
    );
  }
}
