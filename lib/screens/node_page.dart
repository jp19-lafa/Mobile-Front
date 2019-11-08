import 'package:farm_lab_mobile/components/custom_grid.dart';
import 'package:farm_lab_mobile/components/floating_value_box.dart';
import 'package:farm_lab_mobile/interfaces/i_node.dart';
import 'package:farm_lab_mobile/services/node_helper.dart';
import 'package:flutter/material.dart';

class NodePage extends StatefulWidget {
  NodePage({@required this.node});

  final INode node;

  @override
  _NodePageState createState() => _NodePageState();
}

class _NodePageState extends State<NodePage> {
  NodeHelper nodeHelper = NodeHelper(
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWRpZW5jZSI6ImF1ZDoqIiwiaXNzdWVyIjoiRmFybUxhYlRlYW0iLCJzdWIiOiI1ZGM0MjJkNTNiMWUyMjAwMTRhZDNhNmEiLCJpYXQiOjE1NzMxMzUxMTMsImV4cCI6MTU3MzIyMTUxM30.CQgJzp9smCY5HQZtZk0uzO4DBzkCFwxJpq-aNsfcEqc");

  INode node;

  Future<void> reloadNode() async {
    INode nodeData = await nodeHelper.getNode(widget.node.id);
    setState(() {
      node = nodeData;
    });
  }

  @override
  void initState() {
    super.initState();
    node = widget.node;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(node.label),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: RefreshIndicator(
              onRefresh: reloadNode,
              child: ListView(
                children: <Widget>[
                  CustomGrid(
                    padding: 10,
                    children: <Widget>[
                      FloatingValueBox(
                        title: 'Air Temp',
                        value: node.sensors.airtemp.value.toString(),
                        suffix: '°C',
                      ),
                      FloatingValueBox(
                        title: 'Air Hum',
                        value: node.sensors.airhumidity.value.toString(),
                        suffix: '%',
                      ),
                      FloatingValueBox(
                        title: 'Water Temp',
                        value: node.sensors.watertemp.value.toString(),
                        suffix: '°C',
                      ),
                      FloatingValueBox(
                        title: 'Water pH',
                        value: node.sensors.waterph.value.toString(),
                      ),
                      FloatingValueBox(
                        title: 'Enviromental Light',
                        value: node.sensors.lightstr.value.toString(),
                        suffix: 'lm',
                      ),
                      FloatingValueBox(
                        title: 'Water Flow',
                        value: node.actuators.flowpump.value.toString(),
                        suffix: '%',
                      ),
                      FloatingValueBox(
                        title: 'Food Flow',
                        value: node.actuators.foodpump.value.toString(),
                        suffix: 'ml/d',
                      ),
                      FloatingValueBox(
                        title: 'Light',
                        value: node.actuators.lightint.value.toString(),
                        suffix: '%',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
