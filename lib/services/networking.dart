import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.token);
  final String token;
  final String url = "https://api.farmlab.team";

  Future getRequest(String endPoint) async {
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

  Future patchRequest(String endPoint, String data) async {
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
