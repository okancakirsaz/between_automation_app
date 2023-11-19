// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MenuViewModel on _MenuViewModelBase, Store {
  late final _$pickedPhotoAtom =
      Atom(name: '_MenuViewModelBase.pickedPhoto', context: context);

  @override
  Uint8List? get pickedPhoto {
    _$pickedPhotoAtom.reportRead();
    return super.pickedPhoto;
  }

  @override
  set pickedPhoto(Uint8List? value) {
    _$pickedPhotoAtom.reportWrite(value, super.pickedPhoto, () {
      super.pickedPhoto = value;
    });
  }

  late final _$menuAtom =
      Atom(name: '_MenuViewModelBase.menu', context: context);

  @override
  ObservableList<dynamic> get menu {
    _$menuAtom.reportRead();
    return super.menu;
  }

  @override
  set menu(ObservableList<dynamic> value) {
    _$menuAtom.reportWrite(value, super.menu, () {
      super.menu = value;
    });
  }

  late final _$selectedMaterialsAtom =
      Atom(name: '_MenuViewModelBase.selectedMaterials', context: context);

  @override
  ObservableList<dynamic> get selectedMaterials {
    _$selectedMaterialsAtom.reportRead();
    return super.selectedMaterials;
  }

  @override
  set selectedMaterials(ObservableList<dynamic> value) {
    _$selectedMaterialsAtom.reportWrite(value, super.selectedMaterials, () {
      super.selectedMaterials = value;
    });
  }

  late final _$getImageAsyncAction =
      AsyncAction('_MenuViewModelBase.getImage', context: context);

  @override
  Future getImage() {
    return _$getImageAsyncAction.run(() => super.getImage());
  }

  late final _$setEditedValuesAsyncAction =
      AsyncAction('_MenuViewModelBase.setEditedValues', context: context);

  @override
  Future<void> setEditedValues(int index) {
    return _$setEditedValuesAsyncAction.run(() => super.setEditedValues(index));
  }

  late final _$deleteFromMenuAsyncAction =
      AsyncAction('_MenuViewModelBase.deleteFromMenu', context: context);

  @override
  Future<void> deleteFromMenu(int index) {
    return _$deleteFromMenuAsyncAction.run(() => super.deleteFromMenu(index));
  }

  late final _$_MenuViewModelBaseActionController =
      ActionController(name: '_MenuViewModelBase', context: context);

  @override
  dynamic addMaterial() {
    final _$actionInfo = _$_MenuViewModelBaseActionController.startAction(
        name: '_MenuViewModelBase.addMaterial');
    try {
      return super.addMaterial();
    } finally {
      _$_MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteMaterial(int index) {
    final _$actionInfo = _$_MenuViewModelBaseActionController.startAction(
        name: '_MenuViewModelBase.deleteMaterial');
    try {
      return super.deleteMaterial(index);
    } finally {
      _$_MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pickedPhoto: ${pickedPhoto},
menu: ${menu},
selectedMaterials: ${selectedMaterials}
    ''';
  }
}
