import 'package:between_automation/views/authantication/core/models/user_data_model.dart';

class LoginMockServices {
  UserDataModel? getUserData(String mail, String password) {
    Map<String, dynamic>? calledUser;
    try {
      for (int i = 0; i <= dataSet.length - 1; i++) {
        if (mail == dataSet[i]["e_mail"] &&
            password == dataSet[i]["password"]) {
          print(dataSet);
          calledUser = dataSet[i];
        }
      }
      return UserDataModel.fromJson(calledUser!);
    } catch (_) {
      return null;
    }
  }

  static List<Map<String, dynamic>> dataSet = [
    {
      "e_mail": "ocakirsaz@gmail.com",
      "password": "deneme123",
      "token": "UFC123JAOKF0P0ICJOJFOĞ0Q0J03UJVPOAS",
      "name": "Volkan Konak",
      "phoneNumber": "0532 134 32 00"
    },
  ];
}
