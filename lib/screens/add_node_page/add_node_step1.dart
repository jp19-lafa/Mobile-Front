import 'dart:async';

import 'package:farm_lab_mobile/components/step_button.dart';
import 'package:farm_lab_mobile/screens/add_node_page/add_node_step.dart';
import 'package:farm_lab_mobile/services/step_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:open_settings/open_settings.dart';

class AddNodeStep1 implements AddNodeStep {
  AddNodeStep1(FlutterBluetoothSerial bluetooth, StepController stepController,
      Function setState) {
    this._bluetooth = bluetooth;
    this.stepController = stepController;
    this.setState = setState;
  }

  FlutterBluetoothSerial _bluetooth;
  StepController stepController;
  Function setState;
  bool _bluetoothOn = false;
  bool run = false;

  Function nextOnPressed() {
    if (_bluetoothOn) {
      return () {
        stepController.nextStep();
      };
    } else {
      return null;
    }
  }

  void task({var dataFromPreviousStep}) {
    _bluetooth.state.then((state) {
      bool value = state.isEnabled;
      if (value && value != _bluetoothOn) {
        setState(() {
          _bluetoothOn = true;
        });
      } else if (!value && value != _bluetoothOn) {
        setState(() {
          _bluetoothOn = false;
        });
      }
    });

    _bluetooth.onStateChanged().listen((BluetoothState state) {
      setState(() {
        _bluetoothOn = state.isEnabled;
      });
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
        Expanded(
          child: SwitchListTile(
            title: const Text('Enable Bluetooth'),
            value: _bluetoothOn,
            onChanged: (bool value) {
              if (value) {
                _bluetooth.requestEnable().then((_) => setState(() {}));
              } else {
                _bluetooth.requestDisable().then((_) => setState(() {}));
              }
            },
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
        onPressed: nextOnPressed(),
      ),
    ];
  }
}
