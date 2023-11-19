import 'package:between_automation/views/make_order/view/make_order_view.dart';
import 'package:between_automation/views/menu/view/menu_view.dart';
import 'package:between_automation/views/stock/view/stock_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'main_viewmodel.g.dart';

class MainViewModel = _MainViewModelBase with _$MainViewModel;

abstract class _MainViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  void init() {}

  @observable
  ObservableList<Widget> pages = ObservableList.of(
      <Widget>[const MakeOrderView(), const StockView(), const MenuView()]);

  @action
  Widget changePage(int index) {
    return pages[index];
  }
}
