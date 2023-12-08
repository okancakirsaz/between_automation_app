import 'package:between_automation/core/base/view/base_view.dart';
import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:between_automation/core/consts/radius_consts.dart';
import 'package:between_automation/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:between_automation/core/widgets/custom_scaffold.dart';
import 'package:between_automation/core/widgets/logo.dart';
import 'package:between_automation/views/print/viewmodel/print_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

import '../../../core/widgets/error_dialog.dart';

class PrintView extends StatelessWidget {
  final Map<String, dynamic> data;
  const PrintView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BaseView<PrintViewModel>(
      viewModel: PrintViewModel(),
      onPageBuilder: (context, model) {
        return CustomScaffold(
          appBar: CustomAppBar(title: const Logo()).build(),
          body: Column(
            children: <Widget>[
              Expanded(
                child: PdfPreview(
                    maxPageWidth: 650,
                    initialPageFormat: PdfPageFormat(58, model.pageHeight),
                    loadingWidget: const CircularProgressIndicator(),
                    useActions: true,
                    pdfFileName: "${model.getCurrentDate()}/Adisyon Fişi",
                    onPrintError: (context, error) => showErrorDialog(
                        "Bir sorun oluştu. Tekrar deneyiniz.", context),
                    pdfPreviewPageDecoration: BoxDecoration(
                        borderRadius: RadiusConsts.instance.circularAll10,
                        color: ColorConsts.instance.lightGray,
                        boxShadow: ColorConsts.instance.shadow),
                    allowSharing: false,
                    canDebug: false,
                    canChangePageFormat: false,
                    canChangeOrientation: false,
                    dpi: 400,
                    build: (format) {
                      return model.fetchPdf(format);
                    }),
              ),
            ],
          ),
        );
      },
      onModelReady: (model) {
        model.data = data;
        model.setContext(context);
        model.init();
      },
      onDispose: () {},
    );
  }

  showErrorDialog(String reason, BuildContext context) {
    showDialog(
        context: context, builder: (context) => ErrorDialog(reason: reason));
  }
}
