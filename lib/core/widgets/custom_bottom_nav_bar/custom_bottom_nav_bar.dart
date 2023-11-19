import 'package:flutter/material.dart';
import 'package:between_automation/core/base/view/base_view.dart';
import 'package:between_automation/core/consts/asset_consts.dart';
import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:between_automation/core/consts/text_consts.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'custom_bottom_nav_bar_viewmodel.dart';

class CustomButtonNavBar extends StatelessWidget {
  static final CustomBottomNavBarViewModel viewModel =
      CustomBottomNavBarViewModel();
  const CustomButtonNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CustomBottomNavBarViewModel>(
        viewModel: viewModel,
        onPageBuilder: (context, model) {
          return Observer(builder: (context) {
            return BottomNavigationBar(
                onTap: (index) => model.changePage(index),
                currentIndex: model.currentIndex,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                unselectedLabelStyle: TextConsts.instance.regularWhite14,
                selectedLabelStyle: TextConsts.instance.regularWhite16Bold,
                backgroundColor: ColorConsts.instance.primary,
                elevation: 4,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      label: "Siparişler",
                      icon: buildIcon(AssetConsts.instance.order)),
                  BottomNavigationBarItem(
                      label: "Envanter",
                      icon: buildIcon(AssetConsts.instance.stock)),
                  BottomNavigationBarItem(
                      label: "Menü",
                      icon: buildIcon(AssetConsts.instance.menu)),
                ]);
          });
        },
        onModelReady: (model) {},
        onDispose: () {});
  }

  Widget buildIcon(IconData path) {
    return Icon(
      size: 40,
      path,
    );
  }
}
