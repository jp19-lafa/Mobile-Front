import 'package:farm_lab_mobile/models/authentication.dart';
import 'package:farm_lab_mobile/services/network_helper.dart';

class AuthenticationHelper {
  NetworkHelper _networkHelper;
  AuthenticationHelper(NetworkHelper networkHelper) {
    this._networkHelper = networkHelper;
  }

  Future<dynamic> login(UserDetails loginDetails) async {
    String loginJson = userDetailsToJson(loginDetails);
    String returnData = await _networkHelper.postRequest("/auth/login", loginJson);
    if (returnData is String) {
      Token tokenData = tokenFromJson(returnData);
      return tokenData;
    } else {
      return returnData;
    }
  }

  Future<dynamic> register(UserDetails registerDetails) async {
    String registerJson = userDetailsToJson(registerDetails);
    String returnData = await _networkHelper.postRequest("/auth/register", registerJson);
    if (returnData is String) {
      Token tokenData = tokenFromJson(returnData);
      return tokenData;
    } else {
      return returnData;
    }
  }

  Future<dynamic> refresh(Refresh refrech) async {
    String refrechJson = refreshToJson(refrech);
    String returnData = await _networkHelper.postRequest("/auth/refrech", refrechJson);
    if (returnData is String) {
      Token tokenData = tokenFromJson(returnData);
      return tokenData;
    } else {
      return returnData;
    }
  }
}
