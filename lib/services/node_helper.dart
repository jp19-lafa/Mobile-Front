import 'package:farm_lab_mobile/models/node.dart';
import 'package:farm_lab_mobile/services/networking.dart';

class NodeHelper {
  NodeHelper(this._networkHelper);
  NetworkHelper _networkHelper;

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
