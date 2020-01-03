import 'package:http/http.dart' as http;
import 'package:farm_lab_mobile/services/globals.dart' as global;

class NetworkHelper {
  NetworkHelper(this.token);
  String token;
  final String url = "https://api.farmlab.team";

  void getToken() async{
    token = global.token;
  }

  Future getRequest(String endPoint) async {
    getToken();
    String bearerToken = "bearer " + token;
    http.Response response = await http.get(
      url + endPoint,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": bearerToken
      },
    );
    if (response.statusCode.toString()[0] == '2') {
      String data = response.body;
      return data;
    } else {
      print(response.statusCode);
    }
  }

  Future postRequest(String endPoint, String data) async {
    getToken();
    String bearerToken = "bearer " + token;
    http.Response response = await http.post(
      url + endPoint,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": bearerToken
      },
      body: data,
    );
    if (response.statusCode.toString()[0] == "2") {
      String data = response.body;
      return data;
    } else {
      print(response.statusCode);
    }
  }

  Future patchRequest(String endPoint, String data) async {
    getToken();
    String bearerToken = "bearer " + token;
    http.Response response = await http.patch(
      url + endPoint,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": bearerToken
      },
      body: data,
    );
    if (response.statusCode.toString()[0] == "2") {
      String data = response.body;
      return data;
    } else {
      print(response.statusCode);
    }
  }
}
