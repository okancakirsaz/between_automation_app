// ignore_for_file: library_private_types_in_public_api

import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:between_automation/core/init/cache/local_keys_enums.dart';
import 'package:between_automation/views/stock/models/inventory_element_model.dart';
import 'package:between_automation/views/stock/view/stock_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';
import '../../../core/widgets/error_dialog.dart';

part 'stock_viewmodel.g.dart';

class StockViewModel = _StockViewModelBase with _$StockViewModel;

abstract class _StockViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  Future<void> init() async {
    currentInventory = ObservableList.of(
        localeManager.getNullableJsonData(LocaleKeysEnums.inventory.name) ??
            []);
    mostPopulars = localeManager
            .getNullableJsonData(LocaleKeysEnums.mostPopularItems.name) ??
        [];
    await checkIsInventoryElementExist();
    await fetchMostPopulars();
  }

  @observable
  ObservableList currentInventory = ObservableList.of([]);
  List mostPopulars = [];
  final PageController pageController = PageController();
  final TextEditingController elementName = TextEditingController();
  final TextEditingController elementCost = TextEditingController();
  final TextEditingController elementUnit = TextEditingController();
  final TextEditingController elementCurrency = TextEditingController();
  final TextEditingController elementCount = TextEditingController();

  @action
  Future<void> fetchInventory() async {
    try {
      if (validate()) {
        currentInventory.add(InventoryElementModel(
          name: elementName.text,
          cost: int.parse(elementCost.text),
          unit: elementUnit.text,
          currency: elementCurrency.text,
          count: int.parse(elementCount.text),
          prefferedCount: checkPrefferedCount(
            elementName.text,
            elementUnit.text,
            elementCurrency.text,
            int.parse(elementCost.text),
            int.parse(elementCount.text),
          ),
        ).toJson());
        await localeManager.setJsonData(
            LocaleKeysEnums.inventory.name, currentInventory);
        resetAllControllers();
      } else {
        showErrorDialog("Eksik bilgi girdiniz, tekrar deneyiniz.");
      }
    } catch (e) {
      showErrorDialog(
        "Bir sorun oluştu, lütfen tekrar deneyiniz",
      );
    }
  }

  bool validate() {
    if (elementName.text == "" ||
        elementCost.text == "" ||
        elementCurrency.text == "" ||
        elementUnit.text == "" ||
        elementCount.text == "") {
      return false;
    } else {
      return true;
    }
  }

  int checkPrefferedCount(String elementName, String elementUnit,
      String elementCurrency, int elementCost, int elementCount) {
    int finalValue = 0;
    for (int i = 0; i <= currentInventory.length - 1; i++) {
      final InventoryElementModel asModel =
          InventoryElementModel.fromJson(currentInventory[i]);
      if (elementName == asModel.name &&
          elementUnit == asModel.unit &&
          elementCost == asModel.cost &&
          elementCurrency == asModel.currency &&
          elementCount == asModel.count) {
        finalValue = asModel.prefferedCount! + 1;
      }
    }
    return finalValue;
  }

  fetchMostPopulars() async {
    for (int i = 0; i <= currentInventory.length - 1; i++) {
      final InventoryElementModel asModel =
          InventoryElementModel.fromJson(currentInventory[i]);

      if (asModel.prefferedCount! == 2) {
        if (!mostPopulars
            .any((element) => deepEquals(element, asModel.toJson()))) {
          mostPopulars.add(asModel.toJson());
        }
        await localeManager.setJsonData(
            LocaleKeysEnums.mostPopularItems.name, mostPopulars);
      }
    }
  }

  bool deepEquals(Map<String, dynamic> map1, Map<String, dynamic> map2) {
    if (map1.length != map2.length) return false;

    for (var key in map1.keys) {
      if (!map2.containsKey(key) || map1[key] != map2[key]) {
        return false;
      }
    }

    return true;
  }

  resetAllControllers() {
    elementCost.text = "";
    elementName.text = "";
    elementCount.text = "";
    elementCurrency.text = "";
    elementUnit.text = "";
  }

  dominateInputs(
      {required String name,
      required String cost,
      required String unit,
      required String count,
      required String currency}) async {
    elementName.text = name;
    elementCost.text = cost;
    elementCurrency.text = currency;
    elementCount.text = count;
    elementUnit.text = unit;
  }

  openEditDialog(StockViewModel viewModel, int index) {
    showDialog(
        context: viewModelContext,
        builder: (viewModelContext) {
          return AlertDialog(
            backgroundColor: ColorConsts.instance.secondary,
            content: AddElementInputs(
              onPressed: () async {
                editElement(index);
                Navigator.pop(viewModelContext);
              },
              viewModel: viewModel,
            ),
          );
        });
  }

  @action
  editElement(int index) async {
    currentInventory[index] = InventoryElementModel(
            name: elementName.text,
            unit: elementUnit.text,
            cost: int.parse(elementCost.text),
            count: int.parse(elementCount.text),
            currency: elementCurrency.text,
            prefferedCount: currentInventory[index]["prefferedCount"])
        .toJson();
    await localeManager.removeData(LocaleKeysEnums.inventory.name);
    await localeManager.setJsonData(
        LocaleKeysEnums.inventory.name, currentInventory);
  }

  @action
  deleteElement(int index) async {
    currentInventory.removeAt(index);
    await localeManager.removeData(LocaleKeysEnums.inventory.name);
    await localeManager.setJsonData(
        LocaleKeysEnums.inventory.name, currentInventory);
  }

  @action
  Future<void> checkIsInventoryElementExist() async {
    for (int i = 0; i <= currentInventory.length - 1; i++) {
      InventoryElementModel elementAsModel =
          InventoryElementModel.fromJson(currentInventory[i]);
      if (elementAsModel.count! <= 0) {
        currentInventory.removeAt(i);
        await localeManager.setJsonData(
            LocaleKeysEnums.inventory.name, currentInventory);
      }
    }
  }

  navigateToIndexedPage(int index) {
    pageController.jumpToPage(index);
  }

  showErrorDialog(String reason) {
    showDialog(
        context: viewModelContext,
        builder: (context) => ErrorDialog(reason: reason));
  }
}
