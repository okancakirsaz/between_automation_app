import 'package:flutter/material.dart';
import 'package:between_automation/core/base/view/base_view.dart';
import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:between_automation/core/consts/text_consts.dart';
import 'package:between_automation/core/widgets/pop_button.dart';
import '../../../../core/consts/padding_consts.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../core/components/auth_text_field.dart';
import '../../core/components/logo_view_auth.dart';
import '../../core/components/title.dart';
import '../viewmodel/forgot_password_viewmodel.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewModel>(
      viewModel: ForgotPasswordViewModel(),
      onPageBuilder: (context, model) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50),
                buildInputArea(model, context),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onDispose: () {},
    );
  }

  Widget buildInputArea(ForgotPasswordViewModel model, BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorConsts.instance.primary),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 15),
          PopButton(style: TextConsts.instance.regularWhite20),
          const SizedBox(height: 25),
          const Center(child: LogoViewAuth()),
          Padding(
              padding: PaddingConsts.instance.left30,
              child: const CustomTitle(text: "E-Posta")),
          const SizedBox(height: 10),
          AuthTextField(
            controller: model.controller,
          ),
          const SizedBox(height: 30),
          Center(
            child: CustomButton(
                onPressed: () async => await model.takeMailStatus(),
                style: TextConsts.instance.regularBlack25Bold,
                text: "Kod Gönder",
                width: 205,
                height: 60),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
