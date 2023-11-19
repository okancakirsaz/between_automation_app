part of '../make_order_view.dart';

class Orders extends StatelessWidget {
  final MakeOrderViewModel viewModel;
  const Orders({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return ListView.builder(
          itemCount: viewModel.orders.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: PaddingConsts.instance.horizontal90,
              child: Card(
                  color: ColorConsts.instance.lightGray,
                  child: ListTile(
                    title: Text(
                      viewModel.fetchOrdersToUi(index).join(" ,"),
                      style: TextConsts.instance.regularBlack18Bold,
                    ),
                    subtitle: Text(
                      viewModel.orders[index]["note"],
                      style: TextConsts.instance.regularBlack14,
                    ),
                    leading: IconButton(
                      onPressed: () => viewModel.editOrder(viewModel, index),
                      icon: Icon(
                        AssetConsts.instance.edit,
                        size: 30,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () async => await viewModel.removeOrder(index),
                      icon: Icon(
                        AssetConsts.instance.delete,
                        color: ColorConsts.instance.red,
                        size: 30,
                      ),
                    ),
                  )),
            );
          });
    });
  }
}
