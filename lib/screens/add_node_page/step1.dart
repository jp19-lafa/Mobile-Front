import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:open_settings/open_settings.dart';

class AddNodeStep1 {
  AddNodeStep1(this._flutterBlue);
  FlutterBlue _flutterBlue;
  bool _bluetoothOn;
  bool run = false;

  Future<dynamic> task() {
    if (!run) {
      run = true;
      return _flutterBlue.isOn.then((value) {
        return _bluetoothOn = value;
      });
    } else {
      return Future(() {
        return false;
      });
    }
  }

  Widget build() {
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
}
