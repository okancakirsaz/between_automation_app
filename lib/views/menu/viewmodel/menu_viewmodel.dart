// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:typed_data';
import 'package:between_automation/core/consts/color_consts/color_consts.dart';
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
    getMenu();
    getInventoryDataAsItem();
  }

  @observable
  Uint8List? pickedPhoto;
  final PageController pageController = PageController();
  final List<String> sqlKeys = ["name", "img", "materials", "price"];
  final TextEditingController materialCount = TextEditingController();
  final TextEditingController elementName = TextEditingController();
  final TextEditingController elementPrice = TextEditingController();
  final TextEditingController materialFromInventory = TextEditingController();
  late final List allInventory;
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
      allInventory = localeSqlManager.getTable("stock") ?? [];
    } catch (e) {
      debugPrint("error");
    }
  }

  getMenu() {
    menu = ObservableList.of(localeSqlManager.getTable("menu") ?? []);
  }

  getInventoryDataAsItem() {
    for (var inventoryElement in allInventory) {
      final InventoryElementModel allInventoryAsModel =
          InventoryElementModel.fromJson(inventoryElement);
      dropdownMenuItems.add(
        DropdownMenuEntry(
            value: "${allInventoryAsModel.name}",
            label: allInventoryAsModel.name!),
      );
    }
  }

  String findUnitForSelectedMaterial() {
    String response = "";
    var inventoryElement = localeSqlManager.getStringValue(
        "stock", "name", materialFromInventory.text);
    response = inventoryElement[0]["unit"];
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
      localeSqlManager.setValue(
        tableName: "menu",
        keys: sqlKeys,
        values: [
          elementName.text,
          pickedPhoto?.toList(),
          jsonEncode(selectedMaterials.toList()),
          int.parse(elementPrice.text),
        ],
      );
      getMenu();
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
                setEditedValues(index);
              }),
        ),
      ),
    );
  }

  @action
  setEditedValues(int index) {
    localeSqlManager.editValue(
      tableName: "menu",
      comparedValue: menu[index]["name"],
      keys: sqlKeys,
      whereParam: "name",
      values: [
        elementName.text,
        pickedPhoto,
        jsonEncode(selectedMaterials.toList()),
        int.parse(elementPrice.text),
      ],
    );
    getMenu();
  }

  dominateInputsForEdit(int index) {
    elementName.text = menu[index]["name"]!;
    elementPrice.text = menu[index]["price"]!.toString();
    pickedPhoto = Uint8List.fromList(menu[index]["img"]!);
    selectedMaterials = ObservableList.of(jsonDecode(menu[index]["materials"]));
  }

  edit(int index, MenuViewModel viewModel) {
    showEditDialog(viewModel, index);
    dominateInputsForEdit(index);
  }

  @action
  Future<void> deleteFromMenu(int index) async {
    localeSqlManager.deleteValue("menu", "name", menu[index]["name"]);
    getMenu();
  }

  List<String> fetchMaterialsForUi(int index) {
    List<String> finalResponse = [];
    List materials = jsonDecode(menu[index]["materials"]);
    materials.forEach((element) {
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
