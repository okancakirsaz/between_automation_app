import 'package:between_automation/core/consts/text_consts.dart';
import 'package:between_automation/views/menu/view/components/menu_item.dart';
import 'package:between_automation/views/menu/viewmodel/menu_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MenuItems extends StatelessWidget {
  final MenuViewModel viewModel;
  const MenuItems({super.key, required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return viewModel.menu.isEmpty
          ? Center(
              child: Text(
                "Henüz bir menünüz bulunmamakta.",
                style: TextConsts.instance.regularBlack36Bold,
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 0.9),
              itemCount: viewModel.menu.length,
              itemBuilder: (context, index) {
                return MenuItem(
                  index: index,
                  viewModel: viewModel,
                  data: viewModel.menu[index],
                );
              });
    });
  }
}
