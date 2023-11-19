// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_bottom_nav_bar_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomBottomNavBarViewModel on _CustomBottomNavBarViewModelBase, Store {
  late final _$currentIndexAtom = Atom(
      name: '_CustomBottomNavBarViewModelBase.currentIndex', context: context);

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$_CustomBottomNavBarViewModelBaseActionController =
      ActionController(
          name: '_CustomBottomNavBarViewModelBase', context: context);

  @override
  void changePage(dynamic comedIndex) {
    final _$actionInfo = _$_CustomBottomNavBarViewModelBaseActionController
        .startAction(name: '_CustomBottomNavBarViewModelBase.changePage');
    try {
      return super.changePage(comedIndex);
    } finally {
      _$_CustomBottomNavBarViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex}
    ''';
  }
}
