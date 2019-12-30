import 'package:farm_lab_mobile/services/security_protocol.dart';

class WifiConnectionData{
  WifiConnectionData({this.address, this.wifiName, this.securityProtocol, this.username, this.password});
  String address;
  String wifiName;
  SecurityProtocol securityProtocol;
  String username;
  String password;
}