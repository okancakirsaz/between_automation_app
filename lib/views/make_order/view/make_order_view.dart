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
import 'package:between_automation/views/make_order/viewmodel/make_order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

part 'components/make_order.dart';
part 'components/orders.dart';

class MakeOrderView extends StatelessWidget {
  const MakeOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<MakeOrderViewModel>(
        viewModel: MakeOrderViewModel(),
        onPageBuilder: ((context, model) {
          return CustomScaffold(
              body: PageView(
            children: <Widget>[
              Orders(viewModel: model),
              MakeOrder(
                viewModel: model,
                onPressed: () async => await model.makeOrder(),
              )
            ],
          ));
        }),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onDispose: () {});
  }
}
