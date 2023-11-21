// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:typed_data';

import 'package:between_automation/core/init/cache/local_keys_enums.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'print_viewmodel.g.dart';

class PrintViewModel = _PrintViewModelBase with _$PrintViewModel;

abstract class _PrintViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  void init() {
    getAllMenu();
    getSeperatedOrderElementCost();
  }

  pw.TextStyle pdfRegularBlack18 = pw.TextStyle(
      fontSize: 12, color: PdfColors.black, fontWeight: pw.FontWeight.bold);

  pw.TextStyle pdfRegularBlack25 = pw.TextStyle(
      fontSize: 15, color: PdfColors.black, fontWeight: pw.FontWeight.bold);
  Map<String, dynamic> data = {};

  List<int> pricesList = [];
  late List menu;

  getAllMenu() {
    menu = localeManager.getNullableJsonData(LocaleKeysEnums.menu.name) ?? [];
  }

  getSeperatedOrderElementCost() {
    menu.forEach((element) {
      data["order"].forEach((order) {
        if (element["name"] == order["name"]) {
          pricesList.add(element["price"]);
        }
      });
    });
  }

  String getCurrentDate() {
    final DateTime date = DateTime.now();
    final int day = date.day;
    final int month = date.month;
    final int year = date.year;
    final int hour = date.hour;
    final int minute = date.minute;
    return "$day.$month.$year $hour:$minute";
  }

  FutureOr<Uint8List> fetchPdf(PdfPageFormat format) async {
    final pdf = pw.Document(compress: true);
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return buildAdditionContent();
        },
      ),
    );

    return await pdf.save();
  }

  buildAdditionContent() {
    return pw.SizedBox(
      height: 300,
      child: pw.Column(
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              "Adisyon",
              style: pdfRegularBlack25,
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              "Between",
              style: pdfRegularBlack18,
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              "Tarih: ${getCurrentDate()}",
              style: pdfRegularBlack18,
            ),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            margin: const pw.EdgeInsets.all(10),
            width: 300,
            decoration: pw.BoxDecoration(
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
              border: pw.Border.all(color: PdfColors.black),
            ),
            child: pw.ListView.builder(
                itemCount: data["order"].length,
                itemBuilder: (context, index) {
                  return pw.Container(
                    width: double.infinity,
                    height: 20,
                    decoration: pw.BoxDecoration(
                        borderRadius:
                            const pw.BorderRadius.all(pw.Radius.circular(10)),
                        color: PdfColor.fromHex("#f4f4f4")),
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                              "${data["order"][index]["name"]} / ${pricesList[index]}TL",
                              style: pdfRegularBlack18),
                          pw.Text("x${data["order"][index]["count"]}",
                              style: pdfRegularBlack18),
                        ]),
                  );
                }),
          ),
          pw.Container(
              margin: const pw.EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: pw.Text(
                "Toplam:${data["cost"]}TL",
                textAlign: pw.TextAlign.right,
                style: pdfRegularBlack18,
              )),
          pw.SizedBox(height: 20)
        ],
      ),
    );
  }
}
