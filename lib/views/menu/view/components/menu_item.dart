import 'package:between_automation/views/menu/viewmodel/menu_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/consts/asset_consts.dart';
import '../../../../core/consts/color_consts/color_consts.dart';
import '../../../../core/consts/padding_consts.dart';
import '../../../../core/consts/radius_consts.dart';
import '../../../../core/consts/text_consts.dart';

class MenuItem extends StatelessWidget {
  final MenuViewModel viewModel;
  final int index;
  final Map<String, dynamic> data;
  const MenuItem(
      {super.key,
      required this.data,
      required this.viewModel,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: PaddingConsts.instance.all20,
      decoration: BoxDecoration(
          boxShadow: ColorConsts.instance.shadow,
          borderRadius: RadiusConsts.instance.circularAll10,
          color: ColorConsts.instance.secondary),
      child: Column(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: RadiusConsts.instance.circularTop10,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: MemoryImage(
                  Uint8List.fromList(data["img"]),
                ),
              ),
            ),
          ),
          Text(
            data["name"],
            style: TextConsts.instance.regularWhite25Bold,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: PaddingConsts.instance.left30,
            child: SizedBox(
              width: 600,
              child: Text(
                "Ücret: ${data["price"]}₺",
                style: TextConsts.instance.regularWhite20,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Padding(
            padding: PaddingConsts.instance.left30,
            child: SizedBox(
                height: 70,
                width: 500,
                child: SingleChildScrollView(
                  child: Text(
                    "Malzemeler: ${viewModel.fetchMaterialsForUi(index).join(" ,")}",
                    style: TextConsts.instance.regularWhite20,
                    textAlign: TextAlign.left,
                  ),
                )),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                      onPressed: () async => viewModel.deleteFromMenu(index),
                      icon: Icon(
                        AssetConsts.instance.delete,
                        color: ColorConsts.instance.red,
                        size: 30,
                      )),
                  IconButton(
                      onPressed: () => viewModel.edit(index, viewModel),
                      icon: Icon(
                        color: ColorConsts.instance.lightGray,
                        AssetConsts.instance.edit,
                        size: 30,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
