import 'package:between_automation/core/base/view/base_view.dart';
import 'package:between_automation/core/consts/padding_consts.dart';
import 'package:between_automation/core/widgets/custom_scaffold.dart';
import 'package:between_automation/views/menu/view/components/add_menu_item.dart';
import 'package:between_automation/views/menu/view/components/menu_items.dart';
import 'package:between_automation/views/menu/viewmodel/menu_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../core/consts/text_consts.dart';
import '../../../core/widgets/custom_app_bar/custom_app_bar.dart';
import '../../../core/widgets/logo.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<MenuViewModel>(
        viewModel: MenuViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            appBar: CustomAppBar(
                title: const Logo(),
                tabs: TabBar(
                    onTap: (index) => model.navigateToIndexedPage(index),
                    controller: TabController(length: 2, vsync: this),
                    tabs: <Widget>[
                      Tab(
                        icon: Text(
                          "Menü",
                          style: TextConsts.instance.regularWhite16Bold,
                        ),
                      ),
                      Tab(
                        icon: Text(
                          "Menüye Element Ekle",
                          style: TextConsts.instance.regularWhite16Bold,
                        ),
                      ),
                    ])).build(),
            body: Padding(
              padding: PaddingConsts.instance.top15,
              child: PageView(
                controller: model.pageController,
                children: <Widget>[
                  MenuItems(viewModel: model),
                  AddMenuItem(
                    viewModel: model,
                    onPressed: () async => await model.getFinalValues(),
                  )
                ],
              ),
            ),
          );
        },
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onDispose: () {});
  }
}
