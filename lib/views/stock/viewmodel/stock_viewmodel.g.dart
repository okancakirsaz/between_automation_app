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

  late final _$editElementAsyncAction =
      AsyncAction('_StockViewModelBase.editElement', context: context);

  @override
  Future editElement(int index) {
    return _$editElementAsyncAction.run(() => super.editElement(index));
  }

  late final _$deleteElementAsyncAction =
      AsyncAction('_StockViewModelBase.deleteElement', context: context);

  @override
  Future deleteElement(int index) {
    return _$deleteElementAsyncAction.run(() => super.deleteElement(index));
  }

  @override
  String toString() {
    return '''
currentInventory: ${currentInventory}
    ''';
  }
}
