import 'package:mobx/mobx.dart';

part 'cortar_state.g.dart';

class CortarState = _CortarState with _$CortarState;

abstract class _CortarState with Store {

  @observable
  bool _hasError = false;

  @observable
  bool _houveAlteracoes = false;

  @computed
  bool get hasError => _hasError;

  @computed
  bool get houveAlteracoes => _houveAlteracoes;

  @action
  void setHasError({required bool value}) {
    _hasError = value;
  }

  @action
  void setHouveAlteracoes() {
    _houveAlteracoes = true;
  }

  @action
  void resetState() {
    _hasError = false;
  }
}
