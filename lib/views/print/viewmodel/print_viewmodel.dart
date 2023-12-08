// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'print_viewmodel.g.dart';

class PrintViewModel = _PrintViewModelBase with _$PrintViewModel;

abstract class _PrintViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() async {
    calculatePaperHeight();
    await getFont();
    getAllMenu();
    getSeperatedOrderElementCost();
  }

  late final pw.Font font;
  //Initalizing in getFont() function
  late final pw.TextStyle pdfRegularBlack18;

  pw.TextStyle pdfRegularBlack25 = pw.TextStyle(
      fontSize: 5, color: PdfColors.black, fontWeight: pw.FontWeight.bold);
  Map<String, dynamic> data = {};

  List<int> pricesList = [];
  double pageHeight = 90;
  late List menu;

  getAllMenu() {
    menu = localeSqlManager.getTable("menu") ?? [];
  }

  Future<void> getFont() async {
    font = await PdfGoogleFonts.courierPrimeBold();
    pdfRegularBlack18 = pw.TextStyle(
        font: font,
        fontSize: 2.2,
        color: PdfColors.black,
        fontWeight: pw.FontWeight.bold);
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
    return pw.Column(
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
          padding: const pw.EdgeInsets.all(0.5),
          margin: const pw.EdgeInsets.all(2),
          decoration: pw.BoxDecoration(
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(0.5)),
            border: pw.Border.all(color: PdfColors.black, width: 0.2),
          ),
          child: pw.ListView.builder(
              itemCount: data["order"].length,
              itemBuilder: (context, index) {
                return pw.Container(
                  width: double.infinity,
                  height: 5,
                  decoration: pw.BoxDecoration(
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(10)),
                      color: PdfColor.fromHex("#f4f4f4")),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.Text(
                          "${data["order"][index]["name"]} / ${pricesList[index]}TL",
                          style: pdfRegularBlack18,
                        ),
                        pw.Text("x${data["order"][index]["count"]}",
                            style: pdfRegularBlack18),
                      ]),
                );
              }),
        ),
        pw.Container(
            margin: const pw.EdgeInsets.symmetric(horizontal: 2),
            width: double.infinity,
            child: pw.Text(
              "Toplam:${data["cost"]}TL",
              textAlign: pw.TextAlign.right,
              style: pdfRegularBlack18,
            )),
        pw.SizedBox(height: 10)
      ],
    );
  }

  calculatePaperHeight() {
    pageHeight = data["order"].length * 10.1;
    if (pageHeight <= 90) {
      pageHeight += 90;
    }
  }
}
