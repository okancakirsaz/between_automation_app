import 'package:flutter/material.dart';
import 'package:between_automation/core/base/view/base_view.dart';
import 'package:between_automation/views/authantication/landing_view/viewmodel/landing_viewmodel.dart';
import 'package:between_automation/views/main/view/main_view.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LandingViewModel>(
        viewModel: LandingViewModel(),
        onPageBuilder: (context, model) {
          return FutureBuilder(
              future: model.init(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (model.isCacheHaveToken()) {
                    return const MainView();
                  } else {
                    return const MainView();
                    //return const LoginView();
                  }
                } else {
                  //TODO: Add custom loading widget
                  return const Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                }
              });
        },
        onModelReady: (model) {
          model.setContext(context);
        },
        onDispose: () {});
  }
}
