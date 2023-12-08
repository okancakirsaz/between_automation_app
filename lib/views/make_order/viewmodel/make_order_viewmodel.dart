// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:between_automation/core/init/cache/local_keys_enums.dart';
import 'package:between_automation/views/make_order/view/make_order_view.dart';
import 'package:between_automation/views/menu/models/menu_item_model.dart';
import 'package:between_automation/views/print/view/print_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';
import '../../../core/widgets/error_dialog.dart';

part 'make_order_viewmodel.g.dart';

class MakeOrderViewModel = MakeOrderViewModelBase with _$MakeOrderViewModel;

abstract class MakeOrderViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {
    getOrders();
    getAllMenu();
    getAllInventory();
    fetchMenuAsDropdownEntry();
  }

  final TextEditingController note = TextEditingController();
  final TextEditingController selectedFood = TextEditingController();
  final TextEditingController selectedFoodCount =
      TextEditingController(text: "1");
  final PageController pageController = PageController();
  @observable
  ObservableList selectedFoods = ObservableList.of([]);
  @observable
  ObservableList orders = ObservableList.of([]);
  bool _isStockEnought = false;
  List<DropdownMenuEntry> menuAsDropdownItem = [];
  late final List allInventory;
  late final List allMenu;

  Future<void> sendJsonToCache(LocaleKeysEnums key, dynamic value) async {
    await localeManager.setJsonData(key.name, value);
  }

  getAllMenu() {
    allMenu = localeSqlManager.getTable("menu") ?? [];
  }

  getOrders() {
    orders = ObservableList.of(
        localeManager.getNullableJsonData(LocaleKeysEnums.orders.name) ?? []);
  }

  getAllInventory() {
    allInventory = localeSqlManager.getTable("stock") ?? [];
  }

  fetchMenuAsDropdownEntry() {
    //TODO: optimize
    allMenu.forEach((element) {
      final MenuItemModel elementAsModel = MenuItemModel.fromJson(element);
      menuAsDropdownItem.add(DropdownMenuEntry(
          value: elementAsModel.name, label: elementAsModel.name!));
    });
  }

  @action
  addSelectFood() {
    selectedFoods.add({
      "name": selectedFood.text,
      "count": int.parse(selectedFoodCount.text)
    });
  }

  @action
  deleteSelectedFood(int index) {
    selectedFoods.removeAt(index);
  }

  Future<void> makeOrder() async {
    if (selectedFoods.isNotEmpty) {
      manipulateStockDatas();

      if (_isStockEnought) {
        orders.add({
          "order": selectedFoods,
          "note": note.text,
          "cost": getTotalCost()
        });
        await sendJsonToCache(LocaleKeysEnums.orders, orders);
        resetInputs();
      }
    } else {
      showErrorDialog("Lütfen önce sipariş giriniz.");
    }
  }

  int getTotalCost() {
    List<int> costList = [];
    for (var selectedElement in selectedFoods) {
      final List menuElement = localeSqlManager.getStringValue(
          "menu", "name", selectedElement["name"]);
      if (selectedElement["name"] == menuElement[0]["name"]) {
        costList.add(menuElement[0]["price"] * selectedElement["count"]);
      }
    }

    return costList.reduce((a, b) => a + b);
  }

  manipulateStockDatas() {
    isInventoryEmpty();
    /*
    First looking selectedFoods data or comed data with params
    Second getting who menu material equal selectedFood data
    After than getting stock datas in the menu material
    Last job is check the stock is enought
    Is true manupilate stock data
    Else quit.
     */
    for (Map<String, dynamic> selectedFood in selectedFoods) {
      final List menuElement =
          localeSqlManager.getStringValue("menu", "name", selectedFood["name"]);
      final List<dynamic> menuElementMaterials =
          jsonDecode(menuElement[0]["materials"]);
      for (Map<String, dynamic> menuElementMaterial in menuElementMaterials) {
        final List stockData = localeSqlManager.getStringValue(
            "stock", "name", menuElementMaterial["name"]);
        if (selectedFood["count"] <= stockData[0]["count"]) {
          localeSqlManager.editValue(
              tableName: "stock",
              comparedValue: menuElementMaterial["name"],
              keys: ["count"],
              whereParam: "name",
              values: [stockData[0]["count"] - selectedFood["count"]]);
          _isStockEnought = true;
        } else {
          showErrorDialog("Yeterli stok bulunmamakta");
        }
      }
    }
  }

  @action
  resetInputs() {
    note.text = "";
    selectedFoodCount.text = "1";
    selectedFoods = ObservableList.of([]);
  }

  @action
  List<String> fetchOrdersToUi(int index) {
    List<String> finalResponse = [];
    orders[index]["order"].forEach((order) {
      finalResponse.add("${order["name"]} x${order["count"]}");
    });
    return finalResponse;
  }

  @action
  Future<void> submitOrder(int index) async {
    orders.removeAt(index);
    await sendJsonToCache(LocaleKeysEnums.orders, orders);
  }

  @action
  Future<void> cancelOrder(int index) async {
    orders[index]["order"].where((order) {
      manipulateStockDatasForAddOrDelete(order, false);
      return true;
    }).toList();

    orders.removeAt(index);
    await sendJsonToCache(LocaleKeysEnums.orders, orders);
  }

  editOrder(MakeOrderViewModel viewModel, int index) {
    showEditDialog(viewModel, index);
    getInputDatasForEdit(index);
  }

  showEditDialog(MakeOrderViewModel viewModel, int index) {
    showDialog(
        context: viewModelContext,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ColorConsts.instance.secondary,
            content: SizedBox(
              width: 1000,
              child: MakeOrder(
                viewModel: viewModel,
                onPressed: () async {
                  Navigator.pop(context);
                  await updateOrder(index);
                },
              ),
            ),
          );
        });
  }

  getInputDatasForEdit(int index) {
    note.text = orders[index]["note"];
    selectedFoods = ObservableList.of(orders[index]["order"]);
  }

  @action
  Future<void> updateOrder(int index) async {
    checkNoteEqualToOldNote(index);
    checkStockEqualToOrder(index);
    orders[index]["cost"] = getTotalCost();
    orders[index]["order"] = selectedFoods;
    if (selectedFoods.isNotEmpty) {
      if (_isStockEnought) {
        await sendJsonToCache(LocaleKeysEnums.orders, orders);
        getOrders();
      }
    }
  }

  checkNoteEqualToOldNote(int index) {
    String oldNote = orders[index]["note"];
    orders[index]["note"] = note.text;
    if (oldNote != orders[index]["note"]) {
      _isStockEnought = true;
    }
  }

  checkStockEqualToOrder(int index) {
    final List<dynamic> oldOrderList = orders[index]["order"];
    oldOrderList.where((element) {
      bool isEqual = selectedFoods.contains(element);
      if (!isEqual) {
        //Increment
        manipulateStockDatasForAddOrDelete(element, false);
      }
      return isEqual == false;
    }).toList();

    selectedFoods.where((element) {
      bool isEqual = oldOrderList.contains(element);
      if (!isEqual) {
        //Decrament
        manipulateStockDatasForAddOrDelete(element, true);
      }
      return isEqual == false;
    }).toList();
  }

  manipulateStockDatasForAddOrDelete(dynamic element, bool isDecrament) {
    isInventoryEmpty();

    final List menuElement =
        localeSqlManager.getStringValue("menu", "name", element["name"]);
    final List<dynamic> menuElementMaterials =
        jsonDecode(menuElement[0]["materials"]);
    for (Map<String, dynamic> menuElementMaterial in menuElementMaterials) {
      final List stockData = localeSqlManager.getStringValue(
          "stock", "name", menuElementMaterial["name"]);
      if (element["count"] >= stockData[0]["count"]) {
        showErrorDialog("Yeterli stok bulunmamakta");
      }
      if (element["count"] <= stockData[0]["count"] && isDecrament) {
        localeSqlManager.editValue(
            tableName: "stock",
            comparedValue: menuElementMaterial["name"],
            keys: ["count"],
            whereParam: "name",
            values: [stockData[0]["count"] - element["count"]]);
        _isStockEnought = true;
      } else if (!isDecrament) {
        localeSqlManager.editValue(
            tableName: "stock",
            comparedValue: menuElementMaterial["name"],
            keys: ["count"],
            whereParam: "name",
            values: [stockData[0]["count"] + element["count"]]);
        _isStockEnought = true;
      }
    }
  }

  isInventoryEmpty() {
    if (allInventory.isEmpty) {
      showErrorDialog(
        "Yeterli stok bulunmamakta",
      );
      return;
    }
  }

  navigateToPrintView(int index) {
    Navigator.push(
        viewModelContext,
        CupertinoPageRoute(
            builder: (context) => PrintView(data: orders[index])));
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
