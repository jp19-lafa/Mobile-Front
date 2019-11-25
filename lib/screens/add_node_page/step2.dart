import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class AddNodeStep2 {
  AddNodeStep2(this._flutterBlue);
  final FlutterBlue _flutterBlue;
  List<BluetoothDevice> nodeDevices;
  bool run = false;
  String _radioValue;
  String choice;

  void radioButtonChanges(String value) {
    _radioValue = value;
    print(value);
  }

  Future<dynamic> task() {
    if (!run) {
      run = true;
      return _flutterBlue.startScan(timeout: Duration(seconds: 5)).then(
        (scanList) {
          if (scanList is List<ScanResult>) {
            scanList.sort((a, b) => b.rssi.compareTo(a.rssi));
            nodeDevices = [];
            for (ScanResult scanResult in scanList) {
              RegExp exp = RegExp(r"FarmLab#\d{4}");
              if (exp.hasMatch(scanResult.device.name)) {
                nodeDevices.add(scanResult.device);
              }
            }
          }
        },
      );
    } else {
      return Future(() {});
    }
  }

  Widget buildBody() {
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
                run = false;
                nodeDevices = null;
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
}
