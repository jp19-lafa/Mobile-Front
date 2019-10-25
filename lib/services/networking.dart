import 'package:http/http.dart' as http;

class NetworkHelper {

  final String url = "http://flappy.tf:3000";

  Future getRequest(String endPoint) async {
    http.Response response = await http.get(url + endPoint);
    if (response.statusCode == 200) {
      String data = response.body;

      return data;
    } else {
      print(response.statusCode);
    }
  }
}
