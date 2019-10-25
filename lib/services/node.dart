import 'package:farm_lab_mobile/services/networking.dart';
import 'package:farm_lab_mobile/interfaces/i_node.dart';

class NodeHelper {
  NetworkHelper networkHelper = NetworkHelper();
  
  Future<dynamic> getNodes() async{
    String nodeJson = await networkHelper.getRequest("/nodes");
    List<INode> nodeData = nodesFromJson(nodeJson);
    return nodeData;
  }
}
