// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StockViewModel on _StockViewModelBase, Store {
  late final _$currentInventoryAtom =
      Atom(name: '_StockViewModelBase.currentInventory', context: context);

  @override
  ObservableList<dynamic> get currentInventory {
    _$currentInventoryAtom.reportRead();
    return super.currentInventory;
  }

  @override
  set currentInventory(ObservableList<dynamic> value) {
    _$currentInventoryAtom.reportWrite(value, super.currentInventory, () {
      super.currentInventory = value;
    });
  }

  late final _$fetchInventoryAsyncAction =
      AsyncAction('_StockViewModelBase.fetchInventory', context: context);

  @override
  Future<void> fetchInventory() {
    return _$fetchInventoryAsyncAction.run(() => super.fetchInventory());
  }

  late final _$_StockViewModelBaseActionController =
      ActionController(name: '_StockViewModelBase', context: context);

  @override
  dynamic editElement(int index) {
    final _$actionInfo = _$_StockViewModelBaseActionController.startAction(
        name: '_StockViewModelBase.editElement');
    try {
      return super.editElement(index);
    } finally {
      _$_StockViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteElement(int index) {
    final _$actionInfo = _$_StockViewModelBaseActionController.startAction(
        name: '_StockViewModelBase.deleteElement');
    try {
      return super.deleteElement(index);
    } finally {
      _$_StockViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic checkIsInventoryElementExist() {
    final _$actionInfo = _$_StockViewModelBaseActionController.startAction(
        name: '_StockViewModelBase.checkIsInventoryElementExist');
    try {
      return super.checkIsInventoryElementExist();
    } finally {
      _$_StockViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentInventory: ${currentInventory}
    ''';
  }
}
