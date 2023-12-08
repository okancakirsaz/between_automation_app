part of '../stock_view.dart';

class AddInventory extends StatelessWidget {
  final StockViewModel viewModel;
  const AddInventory({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[buildAddContainer()],
      ),
    );
  }

  Widget buildAddContainer() {
    return Container(
        width: 500,
        height: 600,
        padding: PaddingConsts.instance.horizontal90,
        decoration: BoxDecoration(
          borderRadius: RadiusConsts.instance.circularAll50,
          color: ColorConsts.instance.secondary,
        ),
        child: AddElementInputs(
            viewModel: viewModel,
            onPressed: () async => await viewModel.fetchInventory()));
  }

  Widget buildMostPopular(BuildContext context) {
    return Container(
      height: 600,
      width: 500,
      padding: PaddingConsts.instance.horizontal90,
      decoration: BoxDecoration(
        borderRadius: RadiusConsts.instance.circularAll50,
        color: ColorConsts.instance.secondary,
      ),
      child: Column(
        children: <Widget>[
          Text("Hızlı Ürün Ekleme",
              style: TextConsts.instance.regularWhite25Bold),
          const SizedBox(height: 30),
          Expanded(
              child: viewModel.mostPopulars.isNotEmpty
                  ? ListView.builder(
                      itemCount: viewModel.mostPopulars.length,
                      itemBuilder: (context, index) {
                        return ElementCard(
                            viewModel: viewModel,
                            name: viewModel.mostPopulars[index]["name"],
                            cost: viewModel.mostPopulars[index]["cost"],
                            unit: viewModel.mostPopulars[index]["unit"],
                            count: viewModel.mostPopulars[index]["count"],
                            currency: viewModel.mostPopulars[index]["currency"],
                            onPressed: () async {
                              viewModel.dominateInputs(
                                  name: viewModel.mostPopulars[index]["name"],
                                  cost: viewModel.mostPopulars[index]["cost"]
                                      .toString(),
                                  unit: viewModel.mostPopulars[index]["unit"],
                                  count: viewModel.mostPopulars[index]["count"]
                                      .toString(),
                                  currency: viewModel.mostPopulars[index]
                                      ["currency"]);
                              await viewModel.fetchInventory();
                            });
                      })
                  : Center(
                      child: Text(
                        "Henüz sık eklediğiniz bir ürün yok.",
                        textAlign: TextAlign.center,
                        style: TextConsts.instance.regularWhite25Bold,
                      ),
                    )),
        ],
      ),
    );
  }
}
