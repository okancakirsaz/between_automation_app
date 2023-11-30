// ignore_for_file: unnecessary_string_interpolations

import 'package:between_automation/core/consts/asset_consts.dart';
import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:between_automation/core/consts/padding_consts.dart';
import 'package:between_automation/core/consts/radius_consts.dart';
import 'package:between_automation/core/consts/text_consts.dart';
import 'package:between_automation/core/widgets/custom_button.dart';
import 'package:between_automation/core/widgets/custom_dropdown.dart';
import 'package:between_automation/core/widgets/custom_text_field.dart';
import 'package:between_automation/views/menu/viewmodel/menu_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AddMenuItem extends StatelessWidget {
  final VoidCallback onPressed;
  final MenuViewModel viewModel;
  const AddMenuItem(
      {super.key, required this.viewModel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: PaddingConsts.instance.bottom50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildAddDefaultElement(),
              buildAddMaterialContainer()
            ],
          ),
        ),
        CustomButton(
            onPressed: onPressed,
            style: TextConsts.instance.regularBlack18,
            text: "Onayla",
            width: 300,
            height: 50),
      ],
    );
  }

  Widget buildAddDefaultElement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Menüye Element Ekle",
          style: TextConsts.instance.regularBlack20Bold,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: PaddingConsts.instance.bottom40,
          child: buildTextField(viewModel.elementName, "Element Adı"),
        ),
        Padding(
          padding: PaddingConsts.instance.bottom40,
          child: Row(
            children: <Widget>[
              CustomButton(
                  onPressed: () => viewModel.getImage(),
                  style: TextConsts.instance.regularBlack18,
                  text: "Fotoğraf Ekle",
                  width: 260,
                  height: 40),
              const SizedBox(width: 5),
              Observer(builder: (context) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: RadiusConsts.instance.circularAll5,
                      image: viewModel.pickedPhoto != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(viewModel.pickedPhoto!))
                          : null),
                );
              })
            ],
          ),
        ),
        Padding(
          padding: PaddingConsts.instance.bottom50,
          child: buildTextField(viewModel.elementPrice, "Element Ücreti",
              type: TextInputType.number),
        ),
      ],
    );
  }

  Widget buildAddMaterialContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Kullanılan Malzemeler",
          style: TextConsts.instance.regularBlack20Bold,
        ),
        const SizedBox(height: 30),
        Padding(
          padding: PaddingConsts.instance.bottom40,
          child: SizedBox(
            width: 300,
            child: CustomDropdown(
                props: viewModel.dropdownMenuItems,
                hint: "Seçiniz",
                controller: viewModel.materialFromInventory),
          ),
        ),
        Padding(
          padding: PaddingConsts.instance.bottom40,
          child: buildTextField(viewModel.materialCount, "Miktarı",
              type: TextInputType.number),
        ),
        Padding(
          padding: PaddingConsts.instance.bottom40,
          child: CustomButton(
              onPressed: () => viewModel.addMaterial(),
              style: TextConsts.instance.regularBlack18,
              text: "Ekle",
              width: 100,
              height: 50),
        ),
        Observer(builder: (context) {
          return SizedBox(
            width: 300,
            height: 100,
            child: viewModel.selectedMaterials.isEmpty
                ? Text("Henüz materyal eklenmedi.",
                    textAlign: TextAlign.center,
                    style: TextConsts.instance.regularBlack18)
                : Scrollbar(
                    thumbVisibility: true,
                    child: ListView.builder(
                        itemCount: viewModel.selectedMaterials.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: ColorConsts.instance.lightGray,
                            child: ListTile(
                              title: Text(
                                  "${viewModel.selectedMaterials[index]["name"]} ${viewModel.selectedMaterials[index]["count"]}/${viewModel.selectedMaterials[index]["unit"]}",
                                  style: TextConsts.instance.regularBlack18),
                              trailing: IconButton(
                                  onPressed: () =>
                                      viewModel.deleteMaterial(index),
                                  icon: Icon(
                                    AssetConsts.instance.delete,
                                    color: ColorConsts.instance.red,
                                  )),
                            ),
                          );
                        }),
                  ),
          );
        }),
      ],
    );
  }

  Widget buildTextField(TextEditingController controller, String hint,
      {TextInputType? type}) {
    return SizedBox(
      width: 300,
      child: CustomTextField(
          controller: controller,
          inputType: type,
          style: TextConsts.instance.regularBlack18,
          hint: hint),
    );
  }
}
