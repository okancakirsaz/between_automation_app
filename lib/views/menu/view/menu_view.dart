import 'package:between_automation/core/base/view/base_view.dart';
import 'package:between_automation/views/menu/view/components/add_menu_item.dart';
import 'package:between_automation/views/menu/view/components/menu_items.dart';
import 'package:between_automation/views/menu/viewmodel/menu_viewmodel.dart';
import 'package:flutter/material.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<MenuViewModel>(
        viewModel: MenuViewModel(),
        onPageBuilder: (context, model) {
          return PageView(
            children: <Widget>[
              MenuItems(viewModel: model),
              AddMenuItem(
                viewModel: model,
                onPressed: () async => await model.getFinalValues(),
              )
            ],
          );
        },
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onDispose: () {});
  }
}
