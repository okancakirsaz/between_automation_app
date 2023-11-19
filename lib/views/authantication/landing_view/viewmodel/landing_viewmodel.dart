import 'package:flutter/material.dart';
import 'package:between_automation/core/init/cache/local_keys_enums.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'landing_viewmodel.g.dart';

class LandingViewModel = _LandingViewModelBase with _$LandingViewModel;

abstract class _LandingViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  Future<int> init() async {
    await localeManager.getSharedPreferencesInstance();
    //await localeManager.removeData(LocaleKeysEnums.mostPopularItems.name);
    //await localeManager.removeData(LocaleKeysEnums.inventory.name);
    return 1;
  }

  bool isCacheHaveToken() {
    final String? tokenData =
        localeManager.getNullableStringData(LocaleKeysEnums.token.name);
    if (tokenData != null) {
      return true;
    } else {
      return false;
    }
  }
}
