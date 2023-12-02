// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:between_automation/views/authantication/core/models/user_data_model.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import '../../../../core/service/mock_services/sign_up_mock_services.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../login/viewmodel/login_viewmodel.dart';

part 'sign_up_viewmodel.g.dart';

class SignUpViewModel = _SignUpViewModelBase with _$SignUpViewModel;

abstract class _SignUpViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  void init() {
    loginViewModel.viewModelContext = viewModelContext;
  }

  final SignUpMockServices services = SignUpMockServices();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final LoginViewModel loginViewModel = LoginViewModel();

  showErrorDialog(String reason) {
    showDialog(
        context: viewModelContext,
        builder: (context) => ErrorDialog(reason: reason));
  }

  Future<void> createMembership() async {
    try {
      final UserDataModel request = UserDataModel(
        token: "3124rıwajroıj12j1",
        name: nameController.text,
        phoneNumber: numberController.text,
        password: passwordController.text,
        eMail: emailController.text,
      );

      if (_validation(request)) {
        services.post(request);
        await loginViewModel.tryToLogin(
            comedMail: emailController.text,
            comedPassword: passwordController.text);
      }
    } catch (e) {
      showErrorDialog("Bir şeyler ters gitti. Lütfen tekrar deneyiniz");
    }
  }

  bool _validation(UserDataModel response) {
    print(response);
    if (response.name != "" &&
        response.phoneNumber != "" &&
        response.password != "" &&
        response.eMail != "") {
      return true;
    } else {
      return false;
    }
  }
}
