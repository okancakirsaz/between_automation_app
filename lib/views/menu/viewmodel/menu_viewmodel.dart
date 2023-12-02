// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:typed_data';

import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:between_automation/core/init/cache/local_keys_enums.dart';
import 'package:between_automation/views/menu/models/menu_item_model.dart';
import 'package:between_automation/views/menu/view/components/add_menu_item.dart';
import 'package:between_automation/views/stock/models/inventory_element_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import '../../../core/widgets/error_dialog.dart';

part 'menu_viewmodel.g.dart';

class MenuViewModel = _MenuViewModelBase with _$MenuViewModel;

abstract class _MenuViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  void init() {
    getAllInventory();
    menu = ObservableList.of(
        localeManager.getNullableJsonData(LocaleKeysEnums.menu.name) ?? []);
    convertModelToMenu();
    getInventoryDataAsItem();
  }

  @observable
  Uint8List? pickedPhoto;
  final PageController pageController = PageController();
  final TextEditingController materialCount = TextEditingController();
  final TextEditingController elementName = TextEditingController();
  final TextEditingController elementPrice = TextEditingController();
  final TextEditingController materialFromInventory = TextEditingController();
  late final List allInventory;
  ObservableList<MenuItemModel> menuAsModel = ObservableList.of([]);
  @observable
  ObservableList menu = ObservableList.of([]);
  @observable
  ObservableList selectedMaterials = ObservableList.of([]);
  List<DropdownMenuEntry<dynamic>> dropdownMenuItems = [];

  checkInventory() {
    if (allInventory.isEmpty) {
      showErrorDialog(
          "Menü oluşturabilmek için önce stok bilgilerinizi girmelisiniz.");
    }
  }

  getAllInventory() {
    try {
      allInventory =
          localeManager.getNullableJsonData(LocaleKeysEnums.inventory.name) ??
              [];
    } catch (e) {
      debugPrint("error");
    }
  }

  convertModelToMenu() {
    //TODO: optimize
    menu.forEach(
      (element) {
        menuAsModel.add(MenuItemModel.fromJson(element));
      },
    );
  }

  getInventoryDataAsItem() {
    //TODO: optimize
    for (int i = 0; i <= allInventory.length - 1; i++) {
      final InventoryElementModel allInventoryAsModel =
          InventoryElementModel.fromJson(allInventory[i]);
      dropdownMenuItems.add(
        DropdownMenuEntry(
            value: "${allInventoryAsModel.name}",
            label: allInventoryAsModel.name!),
      );
    }
  }

  String findUnitForSelectedMaterial() {
    //TODO: optimize
    String response = "";
    for (int i = 0; i <= allInventory.length - 1; i++) {
      final InventoryElementModel allInventoryAsModel =
          InventoryElementModel.fromJson(allInventory[i]);
      if (materialFromInventory.text == allInventoryAsModel.name) {
        response = allInventoryAsModel.unit!;
      }
    }
    return response;
  }

  @action
  addMaterial() {
    if (addMaterialValidation()) {
      selectedMaterials.add(
        InventoryElementModel(
                name: materialFromInventory.text,
                count: int.parse(materialCount.text),
                unit: findUnitForSelectedMaterial())
            .toJson(),
      );
    } else {
      showErrorDialog("Eksik bilgi girdiniz, tekrar deneyiniz.");
    }
  }

  @action
  getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    pickedPhoto = await image?.readAsBytes();
  }

  bool addMaterialValidation() {
    if (materialCount.text == "" || materialFromInventory.text == "") {
      return false;
    } else {
      return true;
    }
  }

  bool addElementValidation() {
    if (elementName.text == "" ||
        elementPrice.text == "" ||
        pickedPhoto == null ||
        selectedMaterials.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> getFinalValues() async {
    if (addElementValidation()) {
      //TODO: optimize
      menu.add(MenuItemModel(
        name: elementName.text,
        price: int.parse(elementPrice.text),
        img: pickedPhoto,
        materials: selectedMaterials.toList(),
      ).toJson());
      menuAsModel.add(MenuItemModel(
        name: elementName.text,
        price: int.parse(elementPrice.text),
        img: pickedPhoto,
        materials: selectedMaterials.toList(),
      ));
      await localeManager.setJsonData(LocaleKeysEnums.menu.name, menu);
      resetInputs();
    } else {
      showErrorDialog("Eksik bilgi girdiniz, tekrar deneyiniz.");
    }
  }

  @action
  deleteMaterial(int index) {
    selectedMaterials.removeAt(index);
  }

  showEditDialog(MenuViewModel viewModel, int index) {
    showDialog(
      context: viewModelContext,
      builder: (context) => AlertDialog(
        backgroundColor: ColorConsts.instance.secondary,
        content: SizedBox(
          width: 700,
          child: AddMenuItem(
              viewModel: viewModel,
              onPressed: () async {
                Navigator.pop(context);
                await setEditedValues(index);
              }),
        ),
      ),
    );
  }

  @action
  Future<void> setEditedValues(int index) async {
    menu[index]["name"] = elementName.text;
    menu[index]["price"] = int.parse(elementPrice.text);
    menu[index]["img"] = pickedPhoto;
    menu[index]["materials"] = selectedMaterials.toList();

    menuAsModel[index] = MenuItemModel.fromJson(menu[index]);
    await localeManager.setJsonData(LocaleKeysEnums.menu.name, menu);
  }

  dominateInputsForEdit(int index) {
    elementName.text = menuAsModel[index].name!;
    elementPrice.text = menuAsModel[index].price!.toString();
    pickedPhoto = Uint8List.fromList(menuAsModel[index].img!);
    selectedMaterials = ObservableList.of(menuAsModel[index].materials!);
  }

  edit(int index, MenuViewModel viewModel) {
    showEditDialog(viewModel, index);
    dominateInputsForEdit(index);
  }

  @action
  Future<void> deleteFromMenu(int index) async {
    menu.removeAt(index);
    menuAsModel.removeAt(index);
    await localeManager.setJsonData(LocaleKeysEnums.menu.name, menu);
  }

  List<String> fetchMaterialsForUi(int index) {
    List<String> finalResponse = [];
    menuAsModel[index].materials!.forEach((element) {
      InventoryElementModel elementAsModel =
          InventoryElementModel.fromJson(element);
      finalResponse.add(
          "${elementAsModel.name} ${elementAsModel.count}/${elementAsModel.unit}");
    });
    return finalResponse;
  }

  navigateToIndexedPage(int index) {
    pageController.jumpToPage(index);
  }

  showErrorDialog(String reason) {
    showDialog(
        context: viewModelContext,
        builder: (context) => ErrorDialog(reason: reason));
  }

  resetInputs() {
    materialCount.text = "";
    elementName.text = "";
    elementPrice.text = "";
    selectedMaterials = ObservableList.of([]);
  }
}
