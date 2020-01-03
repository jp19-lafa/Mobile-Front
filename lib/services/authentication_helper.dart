import 'package:farm_lab_mobile/models/authentication.dart';
import 'package:farm_lab_mobile/services/network_helper.dart';

class AuthenticationHelper {
  NetworkHelper _networkHelper;
  AuthenticationHelper(NetworkHelper networkHelper) {
    this._networkHelper = networkHelper;
  }

  Future<dynamic> login(Login login) async {
    String loginJson = loginToJson(login);
    String returnData = await _networkHelper.postRequest("/auth/login", loginJson);
    if (returnData is String) {
      Token loginData = tokenFromJson(returnData);
      return loginData;
    } else {
      return returnData;
    }
  }

  Future<dynamic> refresh(Refresh refrech) async {
    String refrechJson = refreshToJson(refrech);
    String returnData = await _networkHelper.postRequest("/auth/refrech", refrechJson);
    if (returnData is String) {
      Token loginData = tokenFromJson(returnData);
      return loginData;
    } else {
      return returnData;
    }
  }
}
