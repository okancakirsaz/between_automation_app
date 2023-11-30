part of '../stock_view.dart';

class AddElementInputs extends StatelessWidget {
  final StockViewModel viewModel;
  final VoidCallback onPressed;
  const AddElementInputs(
      {super.key, required this.viewModel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Column(
        children: <Widget>[
          Text("Envantere Ürün Ekle",
              style: TextConsts.instance.regularWhite25Bold),
          const SizedBox(height: 30),
          Padding(
            padding: PaddingConsts.instance.bottom40,
            child: buildTextField(viewModel.elementName, "Ürün Adı"),
          ),
          Padding(
            padding: PaddingConsts.instance.bottom40,
            child: buildTextField(viewModel.elementCount, "Miktar",
                type: TextInputType.number),
          ),
          Padding(
            padding: PaddingConsts.instance.bottom40,
            child: Column(
              children: [
                buildTextField(viewModel.elementCost, "Maliyet",
                    type: TextInputType.number),
                Text(
                  "Girilen birim miktar başına maliyet baz alınır.",
                  style: TextConsts.instance.regularWhite12,
                ),
              ],
            ),
          ),
          Padding(
            padding: PaddingConsts.instance.bottom40,
            child: SizedBox(
              width: 300,
              child: CustomDropdown(
                  controller: viewModel.elementUnit,
                  hint: "Ölçü birimi",
                  props: const [
                    DropdownMenuEntry(value: "Gram", label: "Gram"),
                    DropdownMenuEntry(value: "Mililitre", label: "Mililitre"),
                    DropdownMenuEntry(value: "Adet", label: "Adet"),
                  ]),
            ),
          ),
          Padding(
            padding: PaddingConsts.instance.bottom40,
            child: SizedBox(
              width: 300,
              child: CustomDropdown(
                  controller: viewModel.elementCurrency,
                  hint: "Para birimi",
                  props: const [
                    DropdownMenuEntry(value: "Dolar", label: "Dolar"),
                    DropdownMenuEntry(value: "Euro", label: "Euro"),
                    DropdownMenuEntry(
                        value: "Türk Lirası", label: "Türk Lirası"),
                  ]),
            ),
          ),
          CustomButton(
              onPressed: onPressed,
              style: TextConsts.instance.regularBlack18,
              text: "Onayla",
              width: 200,
              height: 50)
        ],
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String text,
      {TextInputType? type}) {
    return SizedBox(
      width: 300,
      child: CustomTextField(
          inputType: type,
          controller: controller,
          style: TextConsts.instance.regularBlack18,
          hint: text),
    );
  }
}
