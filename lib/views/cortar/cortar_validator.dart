import '../../../utils/function_utils.dart';

class CortarValidator {
  static String? validateColuna(String? coluna) {
    if (isNullOrEmpty(coluna)) {
      return 'Informe o número de colunas';
    }

    return null;
  }

  static String? validateLinha(String? linha) {
    if (isNullOrEmpty(linha)) {
      return 'Informe o número de linhas';
    }

    return null;
  }
}
