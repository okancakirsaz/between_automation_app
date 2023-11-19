part of '../make_order_view.dart';

class MakeOrder extends StatelessWidget {
  final VoidCallback onPressed;
  final MakeOrderViewModel viewModel;
  const MakeOrder(
      {super.key, required this.viewModel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[buildAddColumn(), buildAddedFoods()],
    );
  }

  Widget buildAddColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: PaddingConsts.instance.bottom40,
          child: CustomDropdown(
              props: viewModel.menuAsDropdownItem,
              hint: "Menüden seçiniz",
              controller: viewModel.selectedFood),
        ),
        Padding(
          padding: PaddingConsts.instance.bottom40,
          child: SizedBox(
              width: 120,
              child: buildTextInput(
                  viewModel.selectedFoodCount, "Sayısı", TextInputType.number)),
        ),
        Padding(
          padding: PaddingConsts.instance.bottom40,
          child: CustomButton(
              onPressed: () => viewModel.addSelectFood(),
              style: TextConsts.instance.regularBlack18,
              text: "Ekle",
              width: 140,
              height: 40),
        ),
        Padding(
          padding: PaddingConsts.instance.bottom40,
          child: SizedBox(
              width: 300,
              child: buildTextInput(viewModel.note, "Sipariş Notu")),
        ),
        Padding(
          padding: PaddingConsts.instance.left50,
          child: CustomButton(
              onPressed: onPressed,
              style: TextConsts.instance.regularBlack18,
              text: "Onayla",
              width: 200,
              height: 45),
        ),
      ],
    );
  }

  Widget buildAddedFoods() {
    return Container(
      width: 500,
      height: 500,
      decoration: BoxDecoration(
          color: ColorConsts.instance.secondary,
          borderRadius: RadiusConsts.instance.circularAll10),
      child: Observer(builder: (context) {
        return viewModel.selectedFoods.isEmpty
            ? Center(
                child: Text("Lütfen menüden yiyecek ekleyiniz.",
                    style: TextConsts.instance.regularWhite25Bold))
            : ListView.builder(
                itemCount: viewModel.selectedFoods.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: PaddingConsts.instance.horizontal30,
                    child: Card(
                      color: ColorConsts.instance.lightGray,
                      child: ListTile(
                        title: Text(
                            "${viewModel.selectedFoods[index]["name"]} x${viewModel.selectedFoods[index]["count"]}",
                            style: TextConsts.instance.regularBlack18Bold),
                        trailing: IconButton(
                          onPressed: () => viewModel.deleteSelectedFood(index),
                          icon: Icon(
                            size: 30,
                            AssetConsts.instance.delete,
                            color: ColorConsts.instance.red,
                          ),
                        ),
                      ),
                    ),
                  );
                });
      }),
    );
  }

  Widget buildTextInput(TextEditingController controller, String hint,
      [TextInputType? type]) {
    return CustomTextField(
        controller: controller,
        style: TextConsts.instance.regularBlack18,
        hint: hint,
        inputType: type);
  }
}
