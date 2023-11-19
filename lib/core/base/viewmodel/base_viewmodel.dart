import 'package:flutter/material.dart';
import 'package:between_automation/core/init/cache/local_manager.dart';

abstract mixin class BaseViewModel {
  late BuildContext viewModelContext;
  void setContext(BuildContext context);
  LocaleManager localeManager = LocaleManager.instance;
  void init() {}
}
