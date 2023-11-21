import 'package:between_automation/core/base/view/base_view.dart';
import 'package:between_automation/core/consts/asset_consts.dart';
import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:between_automation/core/consts/padding_consts.dart';
import 'package:between_automation/core/consts/radius_consts.dart';
import 'package:between_automation/core/consts/text_consts.dart';
import 'package:between_automation/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:between_automation/core/widgets/custom_button.dart';
import 'package:between_automation/core/widgets/custom_dropdown.dart';
import 'package:between_automation/core/widgets/custom_scaffold.dart';
import 'package:between_automation/core/widgets/custom_text_field.dart';
import 'package:between_automation/core/widgets/logo.dart';
import 'package:between_automation/views/make_order/viewmodel/make_order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

part 'components/make_order.dart';
part 'components/orders.dart';

class MakeOrderView extends StatefulWidget {
  const MakeOrderView({super.key});

  @override
  State<MakeOrderView> createState() => _MakeOrderViewState();
}

class _MakeOrderViewState extends State<MakeOrderView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<MakeOrderViewModel>(
        viewModel: MakeOrderViewModel(),
        onPageBuilder: ((context, model) {
          return CustomScaffold(
              appBar: CustomAppBar(
                  title: const Logo(),
                  tabs: TabBar(
                      onTap: (index) => model.navigateToIndexedPage(index),
                      controller: TabController(length: 2, vsync: this),
                      tabs: <Widget>[
                        Tab(
                          icon: Text(
                            "Siparişler",
                            style: TextConsts.instance.regularWhite16Bold,
                          ),
                        ),
                        Tab(
                          icon: Text(
                            "Sipariş Oluştur",
                            style: TextConsts.instance.regularWhite16Bold,
                          ),
                        ),
                      ])).build(),
              body: Padding(
                padding: PaddingConsts.instance.top15,
                child: PageView(
                  controller: model.pageController,
                  children: <Widget>[
                    Orders(viewModel: model),
                    MakeOrder(
                      viewModel: model,
                      onPressed: () async => await model.makeOrder(),
                    )
                  ],
                ),
              ));
        }),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onDispose: () {});
  }
}
