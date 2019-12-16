import 'package:farm_lab_mobile/models/node.dart';
import 'package:farm_lab_mobile/services/network_helper.dart';

class NodeHelper {
  NetworkHelper _networkHelper;
  NodeHelper(NetworkHelper networkHelper){
    this._networkHelper = networkHelper;
  }

  Future<dynamic> getNodes() async{
    String nodeJson = await _networkHelper.getRequest("/nodes");
    List<Node> nodeData = nodesFromJson(nodeJson);
    return nodeData;
  }

  Future<dynamic> getNode(String id) async{
    String nodeJson = await _networkHelper.getRequest("/nodes/" + id);
    Node nodeData = nodeFromJson(nodeJson);
    return nodeData;
  }
}
