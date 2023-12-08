// ignore_for_file: library_private_types_in_public_api

import 'package:between_automation/core/consts/color_consts/color_consts.dart';
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
    await checkIsInventoryElementExist();
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
      0
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
  checkIsInventoryElementExist() {
    try {
      List finishedStocks =
          localeSqlManager.getDynamicValue("stock", "count", 0);
      localeSqlManager.deleteValue("stock", "name", finishedStocks[0]["name"]);
      initCurrentInventory();
    } catch (e) {
      //Inventory is empty
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
