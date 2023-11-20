import 'dart:async';

import 'package:between_automation/core/init/cache/local_keys_enums.dart';
import 'package:between_automation/views/make_order/view/make_order_view.dart';
import 'package:between_automation/views/menu/view/menu_view.dart';
import 'package:between_automation/views/stock/view/stock_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';
import '../../stock/models/inventory_element_model.dart';

part 'main_viewmodel.g.dart';

class MainViewModel = _MainViewModelBase with _$MainViewModel;

abstract class _MainViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  void init() {
    listenStocks().listen((event) {
      print("stok tükendi");
    }, onDone: () {
      listenStocks().listen((event) {});
    });
  }

  @observable
  ObservableList<Widget> pages = ObservableList.of(
      <Widget>[const MakeOrderView(), const StockView(), const MenuView()]);

  @action
  Widget changePage(int index) {
    return pages[index];
  }

  Stream<void> listenStocks() async* {
    List currentInventory =
        localeManager.getNullableJsonData(LocaleKeysEnums.inventory.name) ?? [];
    for (int i = 0; i <= currentInventory.length - 1; i++) {
      InventoryElementModel elementAsModel =
          InventoryElementModel.fromJson(currentInventory[i]);
      if (elementAsModel.count! <= 0) {
        currentInventory.removeAt(i);
      }
    }
    yield localeManager.setJsonData(
        LocaleKeysEnums.inventory.name, currentInventory);
  }
}
