import 'package:farm_lab_mobile/components/custom_grid.dart';
import 'package:farm_lab_mobile/components/floating_value_box.dart';
import 'package:farm_lab_mobile/models/node_device.dart';
import 'package:farm_lab_mobile/services/globals.dart' as global;
import 'package:farm_lab_mobile/models/node.dart';
import 'package:flutter/material.dart';

class NodePage extends StatefulWidget {
  NodePage({@required this.node});

  final Node node;

  @override
  _NodePageState createState() => _NodePageState();
}

class _NodePageState extends State<NodePage> {
  Device airTemperature;
  Device airHumidity;
  Device waterTemperature;
  Device waterPh;
  Device lightSensor;
  Device light;
  Device flowPump;
  Device foodPump;

  void setValues(Node node) {
    for (Device sensor in node.sensors) {
      switch (sensor.type) {
        case DeviceType.AirTemperature:
          airTemperature = sensor;
          break;
        case DeviceType.AirHumidity:
          airHumidity = sensor;
          break;
        case DeviceType.WaterTemperature:
          waterTemperature = sensor;
          break;
        case DeviceType.WaterPh:
          waterPh = sensor;
          break;
        case DeviceType.LightSensor:
          lightSensor = sensor;
          break;
        default:
          break;
      }
    }
    for (Device actuator in node.actuators) {
      switch (actuator.type) {
        case DeviceType.Light:
          light = actuator;
          break;
        case DeviceType.FlowPump:
          flowPump = actuator;
          break;
        case DeviceType.FoodPump:
          foodPump = actuator;
          break;
        default:
          break;
      }
    }
  }

  Future<void> reloadNode() async {
    Node nodeData = await global.nodeHelper.getNode(widget.node.id);
    setState(() {
      setValues(nodeData);
    });
  }

  @override
  void initState() {
    super.initState();
    setValues(widget.node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.node.label),
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
                        value: airTemperature.value.toStringAsFixed(2),
                        suffix: '°C',
                      ),
                      FloatingValueBox(
                        title: 'Air Hum',
                        value: airHumidity.value.toStringAsFixed(1),
                        suffix: '%',
                      ),
                      FloatingValueBox(
                        title: 'Water Temp',
                        value: waterTemperature.value.toStringAsFixed(2),
                        suffix: '°C',
                      ),
                      FloatingValueBox(
                        title: 'Water pH',
                        value: waterPh.value.toStringAsFixed(1),
                      ),
                      FloatingValueBox(
                        title: 'Enviromental Light',
                        value: lightSensor.value.toStringAsFixed(0),
                        suffix: 'lm',
                      ),
                      FloatingValueBox(
                        title: 'Water Flow',
                        value: flowPump.value.toStringAsFixed(0),
                        suffix: '%',
                      ),
                      FloatingValueBox(
                        title: 'Food Flow',
                        value: foodPump.value.toStringAsFixed(1),
                        suffix: 'ml/d',
                      ),
                      FloatingValueBox(
                        title: 'Light',
                        value: light.value.toStringAsFixed(0),
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
