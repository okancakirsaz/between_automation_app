import 'package:between_automation/core/init/cache/local_sql_manager.dart';
import 'package:flutter/material.dart';
import 'package:between_automation/core/init/cache/local_manager.dart';

abstract mixin class BaseViewModel {
  late BuildContext viewModelContext;
  void setContext(BuildContext context);
  LocaleManager localeManager = LocaleManager.instance;
  LocaleSqlManager localeSqlManager = LocaleSqlManager.instance;
  void init() {}
}
