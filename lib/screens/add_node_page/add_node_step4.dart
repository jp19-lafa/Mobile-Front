import 'package:farm_lab_mobile/components/step_button.dart';
import 'package:farm_lab_mobile/screens/add_node_page/add_node_step.dart';
import 'package:farm_lab_mobile/services/step_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class AddNodeStep4 implements AddNodeStep {
  AddNodeStep4(this._bluetooth, this.stepController, this.setState);
  FlutterBluetoothSerial _bluetooth;
  StepController stepController;
  Function setState;
  String address = "";
  bool run = true;
  Function nextOnPressed;

  @override
  void task({var dataFromPreviousStep}) {
    if (address != dataFromPreviousStep) {
      run = true;
    }
    address = dataFromPreviousStep;
    if (run) {
      run = false;
    }
  }

  @override
  Widget buildPage() {
    List<Widget> children = [];
    children.add(Text('step4'));
    return Column(
      children: children,
    );
  }

  @override
  List<StepButton> buildButtons() {
    return [
      StepButton(
        text: 'Previous Step',
        onPressed: () => stepController.previousStep(),
        green: false,
      ),
      StepButton(
        text: 'Next Step',
        onPressed: nextOnPressed,
      ),
    ];
  }
}
