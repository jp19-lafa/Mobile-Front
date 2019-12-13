import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:farm_lab_mobile/components/step_button.dart';
import 'package:farm_lab_mobile/screens/add_node_page/add_node_step.dart';
import 'package:farm_lab_mobile/services/step_controller.dart';
import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';

class AddNodeStep4 implements AddNodeStep {
  AddNodeStep4(this.stepController, this.setState);
  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> networkScan;
  StepController stepController;
  Function setState;
  bool run = true;
  bool runOnlyOnce = true;
  ConnectivityResult connectionStatus;
  String address = '';
  String wifiSSID;
  String wifiName;
  String password = '';
  String securityProtocol = 'WPA2';
  TextEditingController unsernameTextEditingController =
      TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  void dispose() {
    if (networkScan != null) {
      networkScan.cancel();
    }
  }

  Function nextOnPressed() {
    if (password.length >= 8) {
      return () => stepController.nextStep(dataForNextStep: [wifiSSID, unsernameTextEditingController.text, password]);
    } else {
      return null;
    }
  }

  @override
  void task({var dataFromPreviousStep}) {
    if (address != dataFromPreviousStep) {
      run = true;
    }
    address = dataFromPreviousStep;
    if (runOnlyOnce) {
      networkScan = connectivity.onConnectivityChanged.listen((result) {
        setState(() {
          run = true;
        });
      });
    }
    if (run) {
      run = false;
      connectivity.checkConnectivity().then((status) {
        connectionStatus = status;
        if (connectionStatus == ConnectivityResult.wifi) {
          connectivity.getWifiBSSID().then((ssid) {
            wifiSSID = ssid;
          });
          connectivity.getWifiName().then((name) {
            wifiName = name;
          });
        }
        setState(() {});
      });
    }
  }

  @override
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

    if (connectionStatus == null) {
      children.add(CircularProgressIndicator());
    } else if (connectionStatus == ConnectivityResult.wifi) {
      children.add(Text('Network: $wifiName'));
      if (securityProtocol == "WPA2 Enterprise") {
        children.add(
          TextField(
            controller: unsernameTextEditingController,
            decoration: InputDecoration(
              hintText: 'Username',
            ),
            onChanged: (value) {
              setState(() {
                password = unsernameTextEditingController.text;
              });
            },
          ),
        );
      }
      children.add(
        TextField(
          controller: passwordTextEditingController,
          decoration: InputDecoration(
            hintText: 'Password',
          ),
          onChanged: (value) {
            setState(() {
              password = passwordTextEditingController.text;
            });
          },
        ),
      );
      children.add(
        DropdownButton<String>(
          value: securityProtocol,
          items: <String>['WPA2', 'WPA2 Enterprise'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              securityProtocol = value;
            });
          },
        ),
      );
    } else {
      children.add(Text(
          'You are currently not connected to any WiFi network. Please connect to a network'));
      children.add(RaisedButton(
        child: Text('Open WiFi settings'),
        onPressed: () => OpenSettings.openWIFISetting(),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        onPressed: nextOnPressed(),
      ),
    ];
  }
}
