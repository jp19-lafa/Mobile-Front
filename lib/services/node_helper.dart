import 'package:farm_lab_mobile/models/node.dart';
import 'package:farm_lab_mobile/services/network_helper.dart';

class NodeHelper {
  NetworkHelper _networkHelper;
  NodeHelper(NetworkHelper networkHelper){
    this._networkHelper = networkHelper;
  }

  Future<dynamic> getNodes() async{
    String returnData = await _networkHelper.getRequest("/nodes");
    if (returnData is String) {
      List<Node> nodeData = nodesFromJson(returnData);
      return nodeData;
    } else {
      return returnData;
    }
  }

  Future<dynamic> getNode(String id) async{
    String returnData = await _networkHelper.getRequest("/nodes/" + id);
    if (returnData is String) {
      Node nodeData = nodeFromJson(returnData);
      return nodeData;
    } else {
      return returnData;
    }
  }
}
