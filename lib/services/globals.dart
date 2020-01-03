library farm_lab_mobile.globals;

import 'package:farm_lab_mobile/services/network_helper.dart';
import 'package:farm_lab_mobile/services/node_helper.dart';

String token = '';
String refreshToken = '';
NetworkHelper networkHelper = NetworkHelper(token);
NodeHelper nodeHelper = NodeHelper(networkHelper);