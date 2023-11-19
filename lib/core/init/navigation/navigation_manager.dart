import 'package:flutter/cupertino.dart';
import 'package:between_automation/core/init/navigation/navigation_enums.dart';
import 'package:between_automation/views/authantication/forgot_password/views/forgot_password_view.dart';
import 'package:between_automation/views/authantication/login/view/login_view.dart';

import '../../../views/authantication/sign_up/view/sign_up_view.dart';
import '../../../views/main/view/main_view.dart';

class NavigationManager {
  static final NavigationManager instance = NavigationManager();

  void navigateTo(NavigationEnums pageName, BuildContext context) {
    switch (pageName) {
      case NavigationEnums.LOGIN:
        _normalNavigate(const LoginView(), context);
        break;
      case NavigationEnums.FORGOT_PASSWORD:
        _normalNavigate(const ForgotPasswordView(), context);
        break;
      case NavigationEnums.MAIN:
        _normalNavigate(const MainView(), context);
        break;
      case NavigationEnums.SIGN_UP:
        _normalNavigate(const SignUpView(), context);
        break;
    }
  }

  void _normalNavigate(Widget widget, BuildContext context) {
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => widget,
        ));

    // Platform.isIOS
    //     ? Navigator.push(
    //         context,
    //         CupertinoPageRoute(
    //           builder: (context) => widget,
    //         ))
    //     : Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => widget,
    //         ));
  }

  void removeUntil(NavigationEnums pageName, BuildContext context) {
    switch (pageName) {
      case NavigationEnums.LOGIN:
        _navigateAndRemoveUntil(const LoginView(), context);
        break;
      case NavigationEnums.FORGOT_PASSWORD:
        _navigateAndRemoveUntil(const ForgotPasswordView(), context);
        break;
      case NavigationEnums.MAIN:
        _navigateAndRemoveUntil(const MainView(), context);
        break;
      case NavigationEnums.SIGN_UP:
        _navigateAndRemoveUntil(const SignUpView(), context);
        break;
    }
  }

  void _navigateAndRemoveUntil(Widget widget, BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => widget,
        ),
        (Route<dynamic> route) => false);
  }
}
