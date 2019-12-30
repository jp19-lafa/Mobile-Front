import 'package:farm_lab_mobile/components/step_button.dart';
import 'package:farm_lab_mobile/components/step_button_bar.dart';
import 'package:farm_lab_mobile/screens/add_node_page/add_node_step1.dart';
import 'package:farm_lab_mobile/screens/add_node_page/add_node_step2.dart';
import 'package:farm_lab_mobile/screens/add_node_page/add_node_step3.dart';
import 'package:farm_lab_mobile/screens/add_node_page/add_node_step4.dart';
import 'package:farm_lab_mobile/screens/add_node_page/add_node_step5.dart';
import 'package:farm_lab_mobile/services/step_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class AddNodePage extends StatefulWidget {
  @override
  _AddNodePageState createState() => _AddNodePageState();
}

class _AddNodePageState extends State<AddNodePage> {
  Widget page;
  List<StepButton> buttons = [];
  int activeStep = 0;
  FlutterBluetoothSerial _bluetooth;
  AddNodeStep1 addNodeStep1;
  AddNodeStep2 addNodeStep2;
  AddNodeStep3 addNodeStep3;
  AddNodeStep4 addNodeStep4;
  AddNodeStep5 addNodeStep5;
  StepController stepController;
  List<BluetoothDevice> bluetoothDevices = [];

  @override
  void initState() {
    super.initState();
    _bluetooth = FlutterBluetoothSerial.instance;
    stepController = StepController(setState);
    addNodeStep1 = AddNodeStep1(_bluetooth, stepController, setState);
    addNodeStep2 = AddNodeStep2(_bluetooth, stepController, setState);
    addNodeStep3 = AddNodeStep3(_bluetooth, stepController, setState);
    addNodeStep4 = AddNodeStep4(stepController, setState);
    addNodeStep5 = AddNodeStep5(context, stepController, setState);
    stepController
      ..addStep(addNodeStep1)
      ..addStep(addNodeStep2)
      ..addStep(addNodeStep3)
      ..addStep(addNodeStep4)
      ..addStep(addNodeStep5);
  }

  @override
  void dispose() {
    addNodeStep1.dispose();
    addNodeStep2.dispose();
    addNodeStep3.dispose();
    addNodeStep4.dispose();
    addNodeStep5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    stepController.runTask();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Node'),
      ),
      body: Center(
        child: stepController.buildBody(),
      ),
      bottomNavigationBar:
          StepButtonBar(buttons: stepController.buildButtons()),
    );
  }
}
