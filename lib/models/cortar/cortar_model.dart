class CortarModel {

  late String _colunas;

  late String _linhas;

  void setColunas(String colunas) {
    _colunas = colunas;
  }

  String get colunas => _colunas;

  void setLinhas(String linhas) {
    _linhas = linhas;
  }

  String get linhas => _linhas;

  CortarModel copyWith(CortarModel corte) {
    return CortarModel()
      ..setColunas(corte.colunas)
      ..setLinhas(corte.linhas);
  }

}
