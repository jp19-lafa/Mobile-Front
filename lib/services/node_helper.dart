import 'package:farm_lab_mobile/interfaces/i_node.dart';
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
    List<INode> nodeData = nodesFromJson(nodeJson);
    return nodeData;
  }

  Future<dynamic> getNode(String id) async{
    String nodeJson = await _networkHelper.getRequest("/nodes/" + id);
    INode nodeData = nodeFromJson(nodeJson);
    return nodeData;
  }
}
