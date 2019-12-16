import 'package:farm_lab_mobile/models/authentication.dart';
import 'package:farm_lab_mobile/services/network_helper.dart';

class NodeHelper {
  NetworkHelper _networkHelper;
  NodeHelper(NetworkHelper networkHelper) {
    this._networkHelper = networkHelper;
  }

  Future<dynamic> login(Login login) async {
    String loginJson = loginToJson(login);
    String returnData = await _networkHelper.postRequest("/auth/login", loginJson);
    if (returnData is Login) {
      Login loginData = loginFromJson(returnData);
      return loginData;
    } else {
      return returnData;
    }
  }

  Future<dynamic> refrech(Refrech refrech) async {
    String refrechJson = refrechToJson(refrech);
    String returnData = await _networkHelper.postRequest("/auth/refrech", refrechJson);
    if (returnData is Refrech) {
      Refrech loginData = refrechFromJson(returnData);
      return loginData;
    } else {
      return returnData;
    }
  }
}
