import 'package:farm_lab_mobile/interfaces/i_node.dart';
import 'package:farm_lab_mobile/screens/node_page.dart';
import 'package:farm_lab_mobile/services/node_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NodeSummaryPage extends StatefulWidget {
  @override
  _NodeSummaryPageState createState() => _NodeSummaryPageState();
}

class _NodeSummaryPageState extends State<NodeSummaryPage> {
  NodeHelper nodeHelper = NodeHelper("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWRpZW5jZSI6ImF1ZDoqIiwiaXNzdWVyIjoiRmFybUxhYlRlYW0iLCJzdWIiOiI1ZGM0MjJkNTNiMWUyMjAwMTRhZDNhNmEiLCJpYXQiOjE1NzMxMzUxMTMsImV4cCI6MTU3MzIyMTUxM30.CQgJzp9smCY5HQZtZk0uzO4DBzkCFwxJpq-aNsfcEqc");
  List<Widget> nodeList = [Text('LOADING...')];

  Future<void> buildNode() async {
    List<INode> nodesData = await nodeHelper.getNodes();
    nodeList.clear();
    setState(() {
      for (INode nodeData in nodesData) {
        nodeList.add(
          NodeSummary(
            name: nodeData.label,
            status: nodeData.status,
            onPressed: () async{
              INode node = await nodeHelper.getNode(nodeData.id);
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
          )
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
