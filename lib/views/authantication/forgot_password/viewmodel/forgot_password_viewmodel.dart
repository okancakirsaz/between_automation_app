import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:between_automation/core/init/cache/local_keys_enums.dart';
import 'package:between_automation/core/init/navigation/navigation_enums.dart';
import 'package:between_automation/core/init/navigation/navigation_manager.dart';
import 'package:between_automation/core/models/mail_status_model.dart';
import 'package:between_automation/core/service/mock_services/forgot_password_mock_service.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'forgot_password_viewmodel.g.dart';

class ForgotPasswordViewModel = _ForgotPasswordViewModelBase
    with _$ForgotPasswordViewModel;

abstract class _ForgotPasswordViewModelBase with Store, BaseViewModel {
  //If status from service is true go back login screen
  //If status from service is false show reason screen

  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  void init() {
    String? cachedMailData =
        localeManager.getNullableStringData(LocaleKeysEnums.mail.name);
    if (cachedMailData != null) {
      controller.text = cachedMailData;
    }
  }

  final ForgotPasswordMockService service = ForgotPasswordMockService();
  final TextEditingController controller = TextEditingController();

  Future<void> takeMailStatus() async {
    final MailStatusModel? response = await service.getStatus(controller.text);
    if (response!.isMailSended) {
      //TODO: Add succesfull UI
      navigateToLoginPage();
    } else {
      //TODO: Add error screen
      print("Reasoned error screen");
    }
  }

  navigateToLoginPage() {
    NavigationManager.instance
        .removeUntil(NavigationEnums.LOGIN, viewModelContext);
  }
}
