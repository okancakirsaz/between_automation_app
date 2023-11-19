part of '../stock_view.dart';

class ElementCard extends StatelessWidget {
  final StockViewModel viewModel;
  final String name;
  final int cost;
  final String unit;
  final int count;
  final String currency;
  final VoidCallback onPressed;
  const ElementCard(
      {super.key,
      required this.viewModel,
      required this.name,
      required this.cost,
      required this.unit,
      required this.count,
      required this.currency,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConsts.instance.lightGray,
      child: ListTile(
        title: Text(name, style: TextConsts.instance.regularBlack14Bold),
        subtitle: Text("$cost $currency, $count $unit",
            style: TextConsts.instance.regularBlack12),
        trailing: IconButton(
            onPressed: onPressed, icon: Icon(AssetConsts.instance.add)),
      ),
    );
  }
}
