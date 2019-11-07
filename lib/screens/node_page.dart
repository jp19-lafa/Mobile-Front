import 'package:farm_lab_mobile/interfaces/i_node.dart';
import 'package:flutter/material.dart';

class NodePage extends StatefulWidget {
  NodePage({@required this.node});

  final INode node;

  @override
  _NodePageState createState() => _NodePageState();
}

class _NodePageState extends State<NodePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.node.label),
      ),
      body: Column(
        children: <Widget>[
          Text('Air temp: ' + widget.node.sensors.airtemp.value.toString()),
          Text('Air hum: ' + widget.node.sensors.airhumidity.value.toString()),
          Text('Water temp: ' + widget.node.sensors.watertemp.value.toString()),
          Text('Water ph: ' + widget.node.sensors.waterph.value.toString()),
          Text('Light str: ' + widget.node.sensors.lightstr.value.toString()),
        ],
      ),
    );
  }
}
