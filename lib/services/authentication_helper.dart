import 'package:farm_lab_mobile/models/authentication.dart';
import 'package:farm_lab_mobile/services/network_helper.dart';

class AuthenticationHelper {
  NetworkHelper _networkHelper;
  AuthenticationHelper(NetworkHelper networkHelper) {
    this._networkHelper = networkHelper;
  }

  Future<dynamic> login(UserDetails loginDetails) async {
    String loginJson = userDetailsToLoginJson(loginDetails);
    dynamic returnData =
        await _networkHelper.postRequest("/auth/login", loginJson);
    if (returnData is String) {
      Token tokenData = tokenFromJson(returnData);
      return tokenData;
    } else {
      return returnData;
    }
  }

  Future<dynamic> register(UserDetails registerDetails) async {
    String registerJson = userDetailsToRegisterJson(registerDetails);
    dynamic returnData =
        await _networkHelper.postRequest("/auth/register", registerJson);
    if (returnData is String) {
      Token tokenData = tokenFromJson(returnData);
      return tokenData;
    } else {
      return returnData;
    }
  }
}
