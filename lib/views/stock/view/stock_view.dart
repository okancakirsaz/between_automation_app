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

part 'components/add_inventory.dart';
part 'components/inventory.dart';
part 'components/element_card.dart';
part 'components/editable_element_card.dart';
part 'components/add_element_inputs.dart';

class StockView extends StatelessWidget {
  const StockView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<StockViewModel>(
        viewModel: StockViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
              body: PageView(
            children: <Widget>[
              Inventory(viewModel: model),
              AddInventory(viewModel: model)
            ],
          ));
        },
        onModelReady: (model) async {
          model.setContext(context);
          await model.init();
        },
        onDispose: () {});
  }
}
