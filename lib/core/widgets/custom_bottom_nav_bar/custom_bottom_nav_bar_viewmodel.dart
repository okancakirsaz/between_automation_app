import 'package:flutter/material.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'custom_bottom_nav_bar_viewmodel.g.dart';

class CustomBottomNavBarViewModel = _CustomBottomNavBarViewModelBase
    with _$CustomBottomNavBarViewModel;

abstract class _CustomBottomNavBarViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() {}

  @observable
  int currentIndex = 0;

  @action
  void changePage(comedIndex) {
    currentIndex = comedIndex;
  }
}
