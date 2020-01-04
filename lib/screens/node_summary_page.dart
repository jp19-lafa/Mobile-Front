import 'package:farm_lab_mobile/models/authentication.dart';
import 'package:farm_lab_mobile/models/node.dart';
import 'package:farm_lab_mobile/screens/add_node_page.dart';
import 'package:farm_lab_mobile/screens/login_page.dart';
import 'package:farm_lab_mobile/screens/node_page.dart';
import 'package:farm_lab_mobile/services/globals.dart' as global;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NodeSummaryPage extends StatefulWidget {
  @override
  _NodeSummaryPageState createState() => _NodeSummaryPageState();
}

class _NodeSummaryPageState extends State<NodeSummaryPage> {
  List<Widget> nodeList = [Text('LOADING...')];

  Future<void> buildNode() async {
    await global.networkHelper.isLoaded();
    dynamic nodesData = await global.nodeHelper.getNodes();
    if (nodesData is List<Node>) {
      nodeList.clear();
      setState(
        () {
          for (Node nodeData in nodesData) {
            nodeList.add(
              NodeSummary(
                name: nodeData.label,
                status: nodeData.status,
                onPressed: () async {
                  Node node = await global.nodeHelper.getNode(nodeData.id);
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
        },
      );
    }
    else{
      print(nodesData);
    }
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
        actions: <Widget>[
          PopupMenuButton<PopupOptions>(
            onSelected: (PopupOptions result) {
              switch (result) {
                case PopupOptions.logout:
                  Token token = Token();
                  token.clear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<PopupOptions>>[
              const PopupMenuItem<PopupOptions>(
                value: PopupOptions.logout,
                child: Text('Logout'),
              ),
            ],
          )
        ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNodePage(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
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

enum PopupOptions {
  logout,
}
