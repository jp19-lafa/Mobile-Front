import 'dart:async';

import 'package:farm_lab_mobile/components/step_button.dart';
import 'package:farm_lab_mobile/screens/add_node_page/add_node_step.dart';
import 'package:farm_lab_mobile/services/step_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:open_settings/open_settings.dart';

class AddNodeStep1 implements AddNodeStep {
  AddNodeStep1(FlutterBlue flutterBlue, StepController stepController,
      Function setState) {
    this._flutterBlue = flutterBlue;
    this.stepController = stepController;
    this.setState = setState;
  }

  FlutterBlue _flutterBlue;
  StepController stepController;
  Function setState;
  bool _bluetoothOn = false;
  bool run = false;
  Function onPressed;
  Timer bluetoothChecker;

  Future<void> task() {
    if (bluetoothChecker == null) {
      bluetoothChecker = Timer.periodic(
        Duration(milliseconds: 200),
        (_) {
          setState(() {});
        },
      );
    }

    return _flutterBlue.isOn.then((value) {
      if (value && value != _bluetoothOn) {
        setState(() {
          _bluetoothOn = true;
          onPressed = () {
            bluetoothChecker.cancel();
            bluetoothChecker = null;
            stepController.nextStep();
          };
        });
      } else if (!value && value != _bluetoothOn) {
        setState(() {
          _bluetoothOn = false;
          onPressed = null;
        });
      }
    });
  }

  Widget buildPage() {
    List<Widget> children = [];
    if (_bluetoothOn == null) {
      children.add(
        CircularProgressIndicator(),
      );
    } else {
      children.add(
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Make sure bluetooth is turned on',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
      children.add(
        RaisedButton(
          child: Text('Open Bluetooth settings'),
          onPressed: () => OpenSettings.openBluetoothSetting(),
        ),
      );
    }
    return Column(
      children: children,
    );
  }

  List<StepButton> buildButtons() {
    return [
      StepButton(
        text: 'Next Step',
        onPressed: onPressed,
      ),
    ];
  }
}
