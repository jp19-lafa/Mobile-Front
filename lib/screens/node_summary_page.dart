import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NodeSummaryPage extends StatefulWidget {
  @override
  _NodeSummaryPageState createState() => _NodeSummaryPageState();
}

class _NodeSummaryPageState extends State<NodeSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView(
        children: <Widget>[
          NodeSummary(
            name: "Node 1",
            status: Status.online,
            onPressed: () {},
          ),
          NodeSummary(
            name: "Node 2",
            status: Status.offline,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

enum Status { online, offline, unavailable }

class NodeSummary extends StatelessWidget {
  const NodeSummary({
    @required this.name,
    @required this.status,
    @required this.onPressed,
  });

  final String name;
  final Status status;
  final Function onPressed;

  Icon getIcon() {
    switch (status) {
      case Status.online:
        return Icon(
          Icons.check_circle,
          color: Colors.green,
        );
        break;
      case Status.offline:
        return Icon(
          Icons.remove_circle,
          color: Colors.red,
        );
        break;
      case Status.unavailable:
        return Icon(
          Icons.block,
          color: Colors.grey,
        );
        break;
      default:
        return Icon(
          Icons.block,
          color: Colors.grey,
        );
        break;
    }
  }

  String getStatus() {
    switch (status) {
      case Status.online:
        return "Online";
        break;
      case Status.offline:
        return "Offline";
        break;
      case Status.unavailable:
        return "Unavailable";
        break;
      default:
        return "Unknown";
        break;
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
