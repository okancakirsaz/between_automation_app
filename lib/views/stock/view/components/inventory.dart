part of '../stock_view.dart';

class Inventory extends StatelessWidget {
  final StockViewModel viewModel;
  const Inventory({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 15),
        Expanded(
            child: viewModel.currentInventory.isNotEmpty
                ? Observer(builder: (context) {
                    return ListView.builder(
                        itemCount: viewModel.currentInventory.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: PaddingConsts.instance.horizontal90,
                            child: EditableElementCard(
                                index: index,
                                viewModel: viewModel,
                                name: viewModel.currentInventory[index]["name"],
                                cost: viewModel.currentInventory[index]["cost"],
                                unit: viewModel.currentInventory[index]["unit"],
                                count: viewModel.currentInventory[index]
                                    ["count"],
                                currency: viewModel.currentInventory[index]
                                    ["currency"],
                                onPressed: () {
                                  viewModel.openEditDialog(viewModel, index);
                                  viewModel.dominateInputs(
                                    name: viewModel.currentInventory[index]
                                        ["name"],
                                    cost: viewModel.currentInventory[index]
                                            ["cost"]
                                        .toString(),
                                    unit: viewModel.currentInventory[index]
                                        ["unit"],
                                    count: viewModel.currentInventory[index]
                                            ["count"]
                                        .toString(),
                                    currency: viewModel.currentInventory[index]
                                        ["currency"],
                                  );
                                }),
                          );
                        });
                  })
                : Center(
                    child: Text("Henüz envanterde ürün bulunmamakta.",
                        style: TextConsts.instance.regularBlack25Bold),
                  )),
      ],
    );
  }
}
