import 'dart:async';

import 'package:farm_lab_mobile/components/step_button.dart';
import 'package:farm_lab_mobile/screens/add_node_page/add_node_step.dart';
import 'package:farm_lab_mobile/services/step_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class AddNodeStep2 implements AddNodeStep {
  AddNodeStep2(this._flutterBlue, this.stepController, this.setState);
  FlutterBlue _flutterBlue;
  StepController stepController;
  Function setState;
  List<BluetoothDevice> nodeDevices;
  bool run = false;
  String _radioValue;
  String choice;
  Function nextOnPressed;

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      nextOnPressed = () => stepController.nextStep();
    });
  }

  Future<void> task() {
    if (!run) {
      run = true;
      nextOnPressed = null;
      _radioValue = null;
      return _flutterBlue.startScan(timeout: Duration(seconds: 5)).then(
        (scanList) {
          if (scanList is List<ScanResult>) {
            scanList.sort((a, b) => b.rssi.compareTo(a.rssi));
            nodeDevices = [];
            for (ScanResult scanResult in scanList) {
              print(scanResult.device.id.toString());
              //RegExp exp = RegExp(r"FARMLAB-[a-z0-9]{11}");
              RegExp exp = RegExp(r"LE-Bose QuietComfort \d{2} Se");
              if (exp.hasMatch(scanResult.device.name)) {
                nodeDevices.add(scanResult.device);
              }
            }
            setState(() {});
          }
        },
      );
    } else {
      return Future(() {});
    }
  }

  Widget buildPage() {
    List<Widget> children = [];
    if (nodeDevices == null) {
      children.add(CircularProgressIndicator());
    } else {
      children.add(
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Select the FarmLab device you want to connect with',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
      if (nodeDevices.length == 0) {
        children.add(Text('No FarmLab devices were found'));
      } else if (nodeDevices.length >= 1) {
        List<Widget> devicesList = [];
        for (BluetoothDevice device in nodeDevices) {
          if (device.name != 'w') {
            devicesList.add(
              RadioListTile(
                title: Text(device.name),
                value: device.id.toString(),
                groupValue: _radioValue,
                onChanged: radioButtonChanges,
              ),
            );
          }
        }
        children.add(
          Expanded(
            child: ListView(
              children: devicesList,
            ),
          ),
        );
      }
      children.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            RaisedButton(
              child: Text('Scan again'),
              onPressed: () {
                setState(() {
                  run = false;
                  nodeDevices = null;
                });
              },
            ),
          ],
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
