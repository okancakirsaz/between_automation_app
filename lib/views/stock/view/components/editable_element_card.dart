part of '../stock_view.dart';

class EditableElementCard extends StatelessWidget {
  final StockViewModel viewModel;
  final String name;
  final int cost;
  final String unit;
  final int count;
  final String currency;
  final int index;
  final VoidCallback onPressed;
  const EditableElementCard(
      {super.key,
      required this.viewModel,
      required this.name,
      required this.cost,
      required this.unit,
      required this.count,
      required this.currency,
      required this.onPressed,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConsts.instance.lightGray,
      child: ListTile(
          title: Text(name, style: TextConsts.instance.regularBlack25Bold),
          subtitle: Text("$cost $currency, $count $unit",
              style: TextConsts.instance.regularBlack18),
          leading: IconButton(
              onPressed: onPressed, icon: Icon(AssetConsts.instance.edit)),
          trailing: IconButton(
              onPressed: () async => viewModel.deleteElement(index),
              icon: Icon(
                AssetConsts.instance.delete,
                color: ColorConsts.instance.red,
              ))),
    );
  }
}
