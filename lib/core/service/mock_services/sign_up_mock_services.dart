import 'package:between_automation/core/service/mock_services/login_mock_services.dart';
import 'package:between_automation/views/authantication/core/models/user_data_model.dart';

class SignUpMockServices {
  post(UserDataModel dataModel) {
    LoginMockServices.dataSet.add(dataModel.toJson());
  }
}
