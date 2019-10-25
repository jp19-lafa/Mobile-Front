import 'package:farm_lab_mobile/interfaces/i_node.dart';
import 'package:farm_lab_mobile/screens/node_page.dart';
import 'package:farm_lab_mobile/services/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NodeSummaryPage extends StatefulWidget {
  @override
  _NodeSummaryPageState createState() => _NodeSummaryPageState();
}

class _NodeSummaryPageState extends State<NodeSummaryPage> {
  NodeHelper nodeModel = NodeHelper();
  List<Widget> nodeList = [Text('LOADING...')];

  Future<void> buildNode() async {
    List<INode> nodeData = await nodeModel.getNodes();
    nodeList.clear();
    setState(() {
      for (var node in nodeData) {
        nodeList.add(
          NodeSummary(
            name: node.label,
            status: node.status,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NodePage(
                    node: node,
                  ),
                ),
              );
            },
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    buildNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: RefreshIndicator(
        onRefresh: buildNode,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Column(
              children: nodeList,
            ),
          ],
        ),
      ),
    );
  }
}

class NodeSummary extends StatelessWidget {
  const NodeSummary({
    @required this.name,
    @required this.status,
    @required this.onPressed,
  });

  final String name;
  final bool status;
  final Function onPressed;

  Icon getIcon() {
    if (status) {
      return Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    } else {
      return Icon(
        Icons.remove_circle,
        color: Colors.red,
      );
    }
  }

  String getStatus() {
    if (status) {
      return "Online";
    } else {
      return "Offline";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 5),
        ],
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(name),
              Row(
                children: <Widget>[
                  getIcon(),
                  Text(
                    getStatus(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
