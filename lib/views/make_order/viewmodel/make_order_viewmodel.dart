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
  ObservableList orders = ObservableList.of([]);
  List<DropdownMenuEntry> menuAsDropdownItem = [];
  late final List allInventory;
  late final List allMenu;

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
      orders.add({"order": selectedFoods, "note": note.text});
      await localeManager.setJsonData(LocaleKeysEnums.orders.name, orders);
      await manipulateStockDatas();
      resetInputs();
    } else {
      Fluttertoast.showToast(
          msg: "Lütfen önce sipariş giriniz.",
          backgroundColor: ColorConsts.instance.secondary);
    }
  }

  Future<void> manipulateStockDatas() async {
    selectedFoods.forEach((element) {
      //First getting all selected foods
      for (int i = 0; i <= allInventory.length - 1; i++) {
        //Second getting inventory elements
        allMenu.forEach((menuElement) {
          //Third getting menu element
          final MenuItemModel menuElementAsModel =
              MenuItemModel.fromJson(menuElement);
          menuElementAsModel.materials!.forEach((menuMaterial) {
            //Last getting inventory elements in menu element
            allInventory[i]["count"] = (allInventory[i]["count"] -
                (menuMaterial!["count"] * element["count"])) as int?;

            allInventory[i] = allInventory[i];
          });
        });
      }
    });

    await localeManager.setJsonData(
        LocaleKeysEnums.inventory.name, allInventory);
  }

  @action
  resetInputs() {
    note.text = "";
    selectedFoodCount.text = "1";
    selectedFoods = ObservableList.of([]);
  }

  List<String> fetchOrdersToUi(int index) {
    List<String> finalResponse = [];
    orders[index]["order"].forEach((order) {
      finalResponse.add("${order["name"]} x${order["count"]}");
    });
    return finalResponse;
  }

  @action
  Future<void> removeOrder(int index) async {
    orders.removeAt(index);
    await localeManager.setJsonData(LocaleKeysEnums.orders.name, orders);
  }

  Future<void> editOrder(MakeOrderViewModel viewModel, int index) async {
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
                child: MakeOrder(viewModel: viewModel, onPressed: () async {})),
          );
        });
  }

  getInputDatasForEdit(int index) {
    note.text = orders[index]["note"];
    selectedFoods = ObservableList.of(orders[index]["order"]);
  }

  @action
  Future<void> updateOrder(int index) async {
    //TODO:Continue here
    orders[index]["note"] = note.text;
    final List<String> oldOrderList = orders[index]["order"];
    if (oldOrderList.length > selectedFoods.length) {
    } else if (oldOrderList.length < selectedFoods.length) {}
  }
}
