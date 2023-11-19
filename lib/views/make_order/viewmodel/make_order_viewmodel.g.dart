// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make_order_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MakeOrderViewModel on MakeOrderViewModelBase, Store {
  late final _$selectedFoodsAtom =
      Atom(name: 'MakeOrderViewModelBase.selectedFoods', context: context);

  @override
  ObservableList<dynamic> get selectedFoods {
    _$selectedFoodsAtom.reportRead();
    return super.selectedFoods;
  }

  @override
  set selectedFoods(ObservableList<dynamic> value) {
    _$selectedFoodsAtom.reportWrite(value, super.selectedFoods, () {
      super.selectedFoods = value;
    });
  }

  late final _$MakeOrderViewModelBaseActionController =
      ActionController(name: 'MakeOrderViewModelBase', context: context);

  @override
  dynamic addSelectFood() {
    final _$actionInfo = _$MakeOrderViewModelBaseActionController.startAction(
        name: 'MakeOrderViewModelBase.addSelectFood');
    try {
      return super.addSelectFood();
    } finally {
      _$MakeOrderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedFoods: ${selectedFoods}
    ''';
  }
}
