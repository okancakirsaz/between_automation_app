import 'package:between_automation/core/base/view/base_view.dart';
import 'package:between_automation/core/consts/asset_consts.dart';
import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:between_automation/core/consts/padding_consts.dart';
import 'package:between_automation/core/consts/radius_consts.dart';
import 'package:between_automation/core/consts/text_consts.dart';
import 'package:between_automation/core/widgets/custom_button.dart';
import 'package:between_automation/core/widgets/custom_dropdown.dart';
import 'package:between_automation/core/widgets/custom_scaffold.dart';
import 'package:between_automation/core/widgets/custom_text_field.dart';
import 'package:between_automation/views/stock/viewmodel/stock_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/widgets/custom_app_bar/custom_app_bar.dart';
import '../../../core/widgets/logo.dart';

part 'components/add_inventory.dart';
part 'components/inventory.dart';
part 'components/element_card.dart';
part 'components/editable_element_card.dart';
part 'components/add_element_inputs.dart';

class StockView extends StatefulWidget {
  const StockView({super.key});

  @override
  State<StockView> createState() => _StockViewState();
}

class _StockViewState extends State<StockView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<StockViewModel>(
        viewModel: StockViewModel(),
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
                            "Envanter",
                            style: TextConsts.instance.regularWhite16Bold,
                          ),
                        ),
                        Tab(
                          icon: Text(
                            "Stok Ekle",
                            style: TextConsts.instance.regularWhite16Bold,
                          ),
                        ),
                      ])).build(),
              body: Padding(
                padding: PaddingConsts.instance.top15,
                child: PageView(
                  controller: model.pageController,
                  children: <Widget>[
                    Inventory(viewModel: model),
                    AddInventory(viewModel: model)
                  ],
                ),
              ));
        },
        onModelReady: (model) async {
          model.setContext(context);
          await model.init();
        },
        onDispose: () {});
  }
}
