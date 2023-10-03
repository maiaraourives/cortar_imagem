import '../../../utils/function_utils.dart';

class CortarValidator {
  static String? validateColuna(String? coluna) {
    if (isNullOrEmpty(coluna)) {
      return 'Informe o número de colunas';
    }

    if (coluna!.length != 2) {
      return 'A coluna deve ter no dois digitos';
    }

    return null;
  }

  static String? validateLinha(String? linha) {
    if (isNullOrEmpty(linha)) {
      return 'Informe o número de linhas';
    }

    if (linha!.length != 2) {
      return 'A linha deve ter no dois digitos';
    }

    return null;
  }
}