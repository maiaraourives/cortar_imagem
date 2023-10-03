// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cortar_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CortarState on _CortarState, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??=
          Computed<bool>(() => super.hasError, name: '_CortarState.hasError'))
      .value;
  Computed<bool>? _$houveAlteracoesComputed;

  @override
  bool get houveAlteracoes =>
      (_$houveAlteracoesComputed ??= Computed<bool>(() => super.houveAlteracoes,
              name: '_CortarState.houveAlteracoes'))
          .value;

  late final _$_hasErrorAtom =
      Atom(name: '_CortarState._hasError', context: context);

  @override
  bool get _hasError {
    _$_hasErrorAtom.reportRead();
    return super._hasError;
  }

  @override
  set _hasError(bool value) {
    _$_hasErrorAtom.reportWrite(value, super._hasError, () {
      super._hasError = value;
    });
  }

  late final _$_houveAlteracoesAtom =
      Atom(name: '_CortarState._houveAlteracoes', context: context);

  @override
  bool get _houveAlteracoes {
    _$_houveAlteracoesAtom.reportRead();
    return super._houveAlteracoes;
  }

  @override
  set _houveAlteracoes(bool value) {
    _$_houveAlteracoesAtom.reportWrite(value, super._houveAlteracoes, () {
      super._houveAlteracoes = value;
    });
  }

  late final _$_CortarStateActionController =
      ActionController(name: '_CortarState', context: context);

  @override
  void setHasError({required bool value}) {
    final _$actionInfo = _$_CortarStateActionController.startAction(
        name: '_CortarState.setHasError');
    try {
      return super.setHasError(value: value);
    } finally {
      _$_CortarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHouveAlteracoes() {
    final _$actionInfo = _$_CortarStateActionController.startAction(
        name: '_CortarState.setHouveAlteracoes');
    try {
      return super.setHouveAlteracoes();
    } finally {
      _$_CortarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetState() {
    final _$actionInfo = _$_CortarStateActionController.startAction(
        name: '_CortarState.resetState');
    try {
      return super.resetState();
    } finally {
      _$_CortarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hasError: ${hasError},
houveAlteracoes: ${houveAlteracoes}
    ''';
  }
}
