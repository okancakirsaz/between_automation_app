import 'package:flutter/material.dart';
import 'package:between_automation/core/base/view/base_view.dart';
import 'package:between_automation/core/consts/padding_consts.dart';
import 'package:between_automation/core/consts/text_consts.dart';
import 'package:between_automation/core/init/navigation/navigation_enums.dart';
import 'package:between_automation/core/init/navigation/navigation_manager.dart';
import 'package:between_automation/core/widgets/custom_button.dart';
import 'package:between_automation/views/authantication/core/components/logo_view_auth.dart';
import '../../../../core/consts/color_consts/color_consts.dart';
import '../../../../core/consts/radius_consts.dart';
import '../../core/components/auth_text_field.dart';
import '../../core/components/title.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        viewModel: LoginViewModel(),
        onPageBuilder: (context, model) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildLoginArea(model, context),
                ],
              ),
            ),
          );
        },
        onModelReady: (model) {
          model.setContext(context);
        },
        onDispose: () {});
  }

  Widget buildSubButton(VoidCallback onPressed, String text, Alignment align) {
    return Align(
      alignment: align,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(ColorConsts.instance.lightGray),
          elevation: const MaterialStatePropertyAll(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: align == Alignment.bottomLeft
                  ? RadiusConsts.instance.circularRight100
                  : RadiusConsts.instance.circularLeft100,
              side: BorderSide(color: ColorConsts.instance.black),
            ),
          ),
        ),
        child: Text(text, style: TextConsts.instance.regularBlack18),
      ),
    );
  }

  Widget buildLoginArea(LoginViewModel model, BuildContext context) {
    return Container(
      margin: PaddingConsts.instance.bottom15,
      decoration: BoxDecoration(
        color: ColorConsts.instance.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 15),
          const Center(child: LogoViewAuth()),
          Padding(
              padding: PaddingConsts.instance.left30,
              child: const CustomTitle(text: "E-Posta")),
          const SizedBox(height: 5),
          AuthTextField(
            controller: model.emailController,
          ),
          const SizedBox(height: 10),
          Padding(
              padding: PaddingConsts.instance.left30,
              child: const CustomTitle(text: "Şifre")),
          const SizedBox(height: 5),
          AuthTextField(
            controller: model.passwordController,
          ),
          const SizedBox(height: 15),
          Center(
            child: CustomButton(
                onPressed: () async => await model.tryToLogin(),
                style: TextConsts.instance.regularBlack25Bold,
                text: "Giriş",
                width: 135,
                height: 60),
          ),
          const SizedBox(height: 25),
          buildSubButton(
              () => NavigationManager.instance
                  .navigateTo(NavigationEnums.FORGOT_PASSWORD, context),
              "Şifremi Unuttum",
              Alignment.bottomLeft),
          const SizedBox(height: 10),
          buildSubButton(
              () => NavigationManager.instance
                  .navigateTo(NavigationEnums.SIGN_UP, context),
              "Hesap Oluştur",
              Alignment.bottomRight),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
