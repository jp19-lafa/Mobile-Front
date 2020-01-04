import 'package:farm_lab_mobile/models/authentication.dart';
import 'package:http/http.dart' as http;
import 'package:farm_lab_mobile/services/globals.dart' as global;

class NetworkHelper {
  NetworkHelper() {
    this.token = global.token;
    this.isLoaded();
  }

  Future isLoaded() async {
    if (this._isLoaded) {
      return this;
    }
    await setHeader();
    this._isLoaded = true;
    return this;
  }

  Token token;
  Map<String, String> headers;
  int attempt = 0;
  int maxAttempts = 3;
  bool _isLoaded = false;
  final String url = "https://api.farmlab.team";

  Future setHeader() async {
    await token.load();
    headers = {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": 'bearer ${token.jwt}'
    };
  }

  Future refreshToken() async {
    String data = tokenToRefreshJson(token);
    http.Response response = await http.post(
      url + '/auth/refresh',
      headers: {
        "content-type": "application/json"
      },
      body: data,
    );
    if (response.statusCode.toString()[2] == '2') {
      token = tokenFromJson(response.body);
      await token.store();
      setHeader();
    }
  }

  Future getRequest(String endPoint) async {
    await setHeader();
    attempt = 0;
    while (attempt < maxAttempts) {
      attempt++;
      http.Response response = await http.get(
        url + endPoint,
        headers: headers,
      );
      if (response.statusCode.toString()[0] == '2') {
        return response.body;
      } else if (response.statusCode == 401) {
        if (response.headers['token-expired'] == true.toString()) {
          await refreshToken();
          continue;
        } else {
          continue;
        }
      }
      return response.statusCode;
    }
    return 401;
  }

  Future postRequest(String endPoint, String data) async {
    await setHeader();
    attempt = 0;
    while (attempt < maxAttempts) {
      attempt++;
      http.Response response = await http.post(
        url + endPoint,
        headers: headers,
        body: data,
      );
      if (response.statusCode.toString()[0] == '2') {
        return response.body;
      } else if (response.statusCode == 401) {
        if (response.headers['token-expired'] == true.toString()) {
          await refreshToken();
          continue;
        } else {
          continue;
        }
      }
      return response.statusCode;
    }
    return 401;
  }

  Future patchRequest(String endPoint, String data) async {
    await setHeader();
    attempt = 0;
    while (attempt < maxAttempts) {
      attempt++;
      http.Response response = await http.patch(
        url + endPoint,
        headers: headers,
        body: data,
      );
      if (response.statusCode.toString()[0] == '2') {
        return response.body;
      } else if (response.statusCode == 401) {
        if (response.headers['token-expired'] == true.toString()) {
          await refreshToken();
          continue;
        } else {
          continue;
        }
      }
      return response.statusCode;
    }
    return 401;
  }
}
