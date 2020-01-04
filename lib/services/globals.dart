library farm_lab_mobile.globals;

import 'package:farm_lab_mobile/models/authentication.dart';
import 'package:farm_lab_mobile/services/network_helper.dart';
import 'package:farm_lab_mobile/services/node_helper.dart';

Token token = Token();
NetworkHelper networkHelper = NetworkHelper();
NodeHelper nodeHelper = NodeHelper(networkHelper);
