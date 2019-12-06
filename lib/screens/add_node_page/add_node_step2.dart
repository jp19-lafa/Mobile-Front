import 'dart:async';

import 'package:farm_lab_mobile/components/step_button.dart';
import 'package:farm_lab_mobile/screens/add_node_page/add_node_step.dart';
import 'package:farm_lab_mobile/services/step_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class AddNodeStep2 implements AddNodeStep {
  AddNodeStep2(this._bluetooth, this.stepController, this.setState);
  FlutterBluetoothSerial _bluetooth;
  StepController stepController;
  Function setState;
  List<BluetoothDevice> nodeDevices = [];
  bool run = true;
  bool scanRunning = false;
  String _radioValue;
  String choice;
  Function nextOnPressed;
  StreamSubscription<BluetoothDiscoveryResult> deviceSearch;

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      nextOnPressed = () => stepController.nextStep();
    });
  }

  Future<void> task() {
    if (run) {
      run = false;
      nextOnPressed = null;
      _radioValue = null;
      nodeDevices = [];

      deviceSearch = _bluetooth.startDiscovery().listen(
        (r) {
          scanRunning = true;
          RegExp exp = RegExp(r"FARMLAB-[a-z0-9]{11}");
          //RegExp exp = RegExp(r"LE-Bose QuietComfort \d{2} Se");
          if (r.device.name != null && exp.hasMatch(r.device.name)) {
            nodeDevices.add(r.device);
          }
          setState(() {});
        },
      );

      deviceSearch.onDone(() {
        scanRunning = false;
        setState(() {});
        //deviceSearch.cancel();
      });

      return Future(() {});
    } else {
      return Future(() {});
    }
  }

  Widget buildPage() {
    List<Widget> children = [];
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
    if (nodeDevices.length != 0) {
      if (nodeDevices.length == 0) {
        children.add(Text('No FarmLab devices were found'));
      } else {
        List<Widget> devicesList = [];
        for (BluetoothDevice device in nodeDevices) {
          if (device.name != null) {
            devicesList.add(
              RadioListTile(
                title: Text(device.name),
                value: device.address.toString(),
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
    }

    if (scanRunning) {
      children.add(CircularProgressIndicator());
    }
    children.add(
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            child: Text('Scan again'),
            onPressed: () {
              setState(() {
                deviceSearch.cancel();
                run = true;
                nodeDevices = null;
              });
            },
          ),
        ],
      ),
    );

    return Column(
      children: children,
    );
  }

  List<StepButton> buildButtons() {
    return [
      StepButton(
        text: 'Previous Step',
        onPressed: () {
          deviceSearch.cancel();
          stepController.previousStep();
        },
        green: false,
      ),
      StepButton(
        text: 'Next Step',
        onPressed: nextOnPressed,
      ),
    ];
  }
}
