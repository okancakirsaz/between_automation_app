import 'package:between_automation/core/models/mail_status_model.dart';

class ForgotPasswordMockService {
  MailStatusModel? getStatus(String mail) {
    try {
      return MailStatusModel.fromJson(alternativeDataSet);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> dataSet = {
    "mailAdress": "ocakirsaz@gmail.com",
    "isMailSended": true,
    "reason": null
  };

  Map<String, dynamic> alternativeDataSet = {
    "mailAdress": "ocakirsaz@g",
    "isMailSended": false,
    "reason": "This mail adress is not valid"
  };
}
