import 'package:between_automation/core/consts/asset_consts.dart';
import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:between_automation/core/consts/padding_consts.dart';
import 'package:between_automation/core/consts/radius_consts.dart';
import 'package:between_automation/core/consts/text_consts.dart';
import 'package:between_automation/views/menu/viewmodel/menu_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MenuItems extends StatelessWidget {
  final MenuViewModel viewModel;
  const MenuItems({super.key, required this.viewModel});
  //TODO: you had a view bug fix it
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return viewModel.menu.isEmpty
          ? Center(
              child: Text(
                "Henüz bir menünüz bulunmamakta.",
                style: TextConsts.instance.regularBlack36Bold,
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: viewModel.menu.length,
              itemBuilder: (context, index) {
                return Observer(builder: (context) {
                  return Container(
                    margin: PaddingConsts.instance.all20,
                    decoration: BoxDecoration(
                        boxShadow: ColorConsts.instance.shadow,
                        borderRadius: RadiusConsts.instance.circularAll10,
                        color: ColorConsts.instance.secondary),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                            borderRadius: RadiusConsts.instance.circularTop10,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(
                                Uint8List.fromList(
                                    viewModel.menuAsModel[index].img!),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          viewModel.menuAsModel[index].name!,
                          style: TextConsts.instance.regularWhite25Bold,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: PaddingConsts.instance.left30,
                          child: SizedBox(
                            width: 500,
                            child: Text(
                              "Ücret: ${viewModel.menuAsModel[index].price!}₺",
                              style: TextConsts.instance.regularWhite20,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
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
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                IconButton(
                                    onPressed: () async =>
                                        viewModel.deleteFromMenu(index),
                                    icon: Icon(
                                      AssetConsts.instance.delete,
                                      color: ColorConsts.instance.red,
                                      size: 40,
                                    )),
                                IconButton(
                                    onPressed: () =>
                                        viewModel.edit(index, viewModel),
                                    icon: Icon(
                                      color: ColorConsts.instance.lightGray,
                                      AssetConsts.instance.edit,
                                      size: 40,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
              });
    });
  }
}
