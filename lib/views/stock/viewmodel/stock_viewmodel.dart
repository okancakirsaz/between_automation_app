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
    initCurrentInventory();
    mostPopulars = localeManager
            .getNullableJsonData(LocaleKeysEnums.mostPopularItems.name) ??
        [];
    await checkIsInventoryElementExist();
    await fetchMostPopulars();
  }

  @observable
  ObservableList currentInventory = ObservableList.of([]);
  List mostPopulars = [];
  final List<String> sqlKeys = [
    "name",
    "cost",
    "unit",
    "currency",
    "count",
    "prefferedCount"
  ];
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
        setInputValuesToDb();
        initCurrentInventory();
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

  setInputValuesToDb() {
    localeSqlManager.setValue(tableName: "stock", keys: sqlKeys, values: [
      elementName.text,
      int.parse(elementCost.text),
      elementUnit.text,
      elementCurrency.text,
      int.parse(elementCount.text),
      checkPrefferedCount(
        elementName.text,
        elementUnit.text,
        elementCurrency.text,
        int.parse(elementCost.text),
        int.parse(elementCount.text),
      ),
    ]);
  }

  initCurrentInventory() {
    currentInventory =
        ObservableList.of(localeSqlManager.getTable("stock") ?? []);
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
    //TODO: optimize
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
    //TODO: optimize
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
              onPressed: () {
                editElement(index);
                Navigator.pop(viewModelContext);
              },
              viewModel: viewModel,
            ),
          );
        });
  }

  @action
  editElement(int index) {
    try {
      localeSqlManager.editValue(
        whereParam: "name",
        tableName: "stock",
        comparedValue: currentInventory[index]["name"],
        keys: sqlKeys,
        values: [
          elementName.text,
          int.parse(elementCost.text),
          elementUnit.text,
          elementCurrency.text,
          int.parse(elementCount.text),
          1,
        ],
      );
      initCurrentInventory();
    } catch (_) {
      showErrorDialog("Bir hata oluştu, tekrar deneyiniz.");
    }
  }

  @action
  deleteElement(int index) {
    localeSqlManager.deleteValue(
        "stock", "name", currentInventory[index]["name"]);
    initCurrentInventory();
  }

  @action
  Future<void> checkIsInventoryElementExist() async {
    //TODO: optimize
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
