// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:between_automation/core/init/cache/local_keys_enums.dart';
import 'package:between_automation/views/make_order/view/make_order_view.dart';
import 'package:between_automation/views/menu/models/menu_item_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

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
    allMenu = localeManager.getNullableJsonData(LocaleKeysEnums.menu.name);
  }

  getOrders() {
    orders = ObservableList.of(
        localeManager.getNullableJsonData(LocaleKeysEnums.orders.name) ?? []);
  }

  getAllInventory() {
    allInventory =
        localeManager.getNullableJsonData(LocaleKeysEnums.inventory.name) ?? [];
  }

  fetchMenuAsDropdownEntry() {
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
        orders.add({"order": selectedFoods, "note": note.text});
        await sendJsonToCache(LocaleKeysEnums.orders, orders);
        await sendJsonToCache(LocaleKeysEnums.inventory, allInventory);
        resetInputs();
      }
    } else {
      Fluttertoast.showToast(
          msg: "Lütfen önce sipariş giriniz.",
          backgroundColor: ColorConsts.instance.secondary);
    }
  }

  manipulateStockDatas() {
    for (var menuElement in allMenu) {
      MenuItemModel.fromJson(menuElement).materials!.forEach((material) {
        selectedFoods.where((selectedFoodName) {
          if (selectedFoodName["name"] == menuElement["name"]) {
            allInventory.where((inventoryElement) {
              int finalValue = (material["count"] * selectedFoodName["count"]);
              if (material["name"] == inventoryElement["name"]) {
                if (inventoryElement["count"] < finalValue) {
                  Fluttertoast.showToast(
                      msg: "Yeterli stok bulunmamakta",
                      backgroundColor: ColorConsts.instance.secondary);
                } else {
                  inventoryElement["count"] =
                      inventoryElement["count"] - finalValue;
                  _isStockEnought = true;
                }
              }

              return true;
            }).toList();
          }
          return true;
        }).toList();
      });
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
    await sendJsonToCache(LocaleKeysEnums.inventory, allInventory);
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
    orders[index]["order"] = selectedFoods;
    if (selectedFoods.isNotEmpty) {
      await sendJsonToCache(LocaleKeysEnums.inventory, allInventory);
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
    for (var menuElement in allMenu) {
      MenuItemModel.fromJson(menuElement).materials!.forEach((material) {
        if (element["name"] == menuElement["name"]) {
          allInventory.where((inventoryElement) {
            int finalValue = (material["count"] * element["count"]);
            if (material["name"] == inventoryElement["name"]) {
              if (inventoryElement["count"] < finalValue) {
                Fluttertoast.showToast(
                    msg: "Yeterli stok bulunmamakta",
                    backgroundColor: ColorConsts.instance.secondary);
              } else {
                inventoryElement["count"] = isDecrament
                    ? inventoryElement["count"] -
                        (material["count"] * element["count"])
                    : inventoryElement["count"] +
                        (material["count"] * element["count"]);
                _isStockEnought = true;
              }
            }
            return true;
          }).toList();
        }
      });
    }
  }
}
