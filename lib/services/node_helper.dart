import 'package:farm_lab_mobile/models/node.dart';
import 'package:farm_lab_mobile/services/networking.dart';

class NodeHelper {
  String token;
  NetworkHelper _networkHelper;
  NodeHelper(String token){
    this.token = token;
    this._networkHelper = NetworkHelper(this.token);
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
