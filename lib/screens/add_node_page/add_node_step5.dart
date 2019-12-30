import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:farm_lab_mobile/components/step_button.dart';
import 'package:farm_lab_mobile/models/wifi_connection_data.dart';
import 'package:farm_lab_mobile/screens/add_node_page/add_node_step.dart';
import 'package:farm_lab_mobile/services/security_protocol.dart';
import 'package:farm_lab_mobile/services/step_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class AddNodeStep5 implements AddNodeStep {
  AddNodeStep5(this.context, this.stepController, this.setState);
  BuildContext context;
  StepController stepController;
  Function setState;
  BluetoothConnection connection;
  StreamSubscription<Uint8List> responseListener;
  String dataResponse;
  WifiConnectionData wifiConnectionData;
  String securityProtocolString;
  bool run = true;

  void dispose() {
    if (responseListener != null) {
      responseListener.cancel();
    }
    if (connection != null) {
      connection.dispose();
    }
  }

  Function nextOnPressed() {
    if (dataResponse != null && dataResponse.startsWith('SUCCESS')) {
      return () {
        Navigator.pop(context);
      };
    }
    return null;
  }

  void sendData() async {
    connection.output.add(utf8.encode('TYPE:$securityProtocolString\r\n'));
    await connection.output.allSent;
    connection.output
        .add(utf8.encode('SSID:${wifiConnectionData.address}\r\n'));
    await connection.output.allSent;
    connection.output
        .add(utf8.encode('PWD:${wifiConnectionData.password}\r\n'));
    await connection.output.allSent;
    if (wifiConnectionData.username != '') {
      connection.output
          .add(utf8.encode('USER:${wifiConnectionData.username}}\r\n'));
      await connection.output.allSent;
    }
    connection.output.add(utf8.encode('TRY:1\r\n'));
    await connection.output.allSent;
  }

  @override
  void task({var dataFromPreviousStep}) {
    if (dataFromPreviousStep != null) {
      if (wifiConnectionData != dataFromPreviousStep) {
        run = true;
        wifiConnectionData = dataFromPreviousStep;
      }
    }
    if (run) {
      run = false;
      switch (wifiConnectionData.securityProtocol) {
        case SecurityProtocol.WPA2:
          securityProtocolString = 'wpa2';
          break;
        case SecurityProtocol.WPA2_Enterprise:
          securityProtocolString = 'mchap';
          break;
      }

      if (connection != null) {
        BluetoothConnection.toAddress(wifiConnectionData.address)
            .then((_connection) {
          connection = _connection;
        }).catchError((error) {
          print(error);
        });
      }
      if (responseListener != null && connection != null) {
        responseListener = connection.input.listen((data) {
          print(utf8.decode(data));
          dataResponse = utf8.decode(data);
        });
      }
    }
  }

  @override
  Widget buildPage() {
    List<Widget> list = [];
    if (dataResponse == null) {
      list.add(Padding(
        padding: const EdgeInsets.all(25.0),
        child: CircularProgressIndicator(),
      ));
    } else {
      if (dataResponse.startsWith('ERROR')) {
        if (dataResponse.contains(RegExp('3'))) {
          list.add(
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'The password was incorrect or the selected FarmLab device is unable to connect to the network.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        } else {
          list.add(
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'An error has occured! Please retry and/or restart the app.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
        list.add(RaisedButton(
          child: Text('Retry'),
          onPressed: () {
            setState(() {
              run = true;
              dispose();
            });
          },
        ));
      } else {
        list.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Sucsessfully connected!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      }
    }

    return Column(
      children: list,
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
        text: 'Finish',
        onPressed: nextOnPressed(),
      ),
    ];
  }
}
