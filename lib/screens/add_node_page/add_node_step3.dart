import 'package:farm_lab_mobile/components/step_button.dart';
import 'package:farm_lab_mobile/screens/add_node_page/add_node_step.dart';
import 'package:farm_lab_mobile/services/step_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class AddNodeStep3 implements AddNodeStep {
  AddNodeStep3(this._bluetooth, this.stepController, this.setState);
  FlutterBluetoothSerial _bluetooth;
  StepController stepController;
  Function setState;
  String address = "";
  bool connected;
  bool run = true;

  void dispose(){
    
  }

  Function nextOnPressed() {
    if (connected != null && connected) {
      return () => stepController.nextStep(dataForNextStep: address);
    } else {
      return null;
    }
  }

  @override
  void task({var dataFromPreviousStep}) {
    if (address != dataFromPreviousStep) {
      run = true;
      connected = null;
    }
    address = dataFromPreviousStep;
    print(address);
    if (run) {
      run = false;
      _bluetooth.getBondedDevices().then(
        (bondedDevices) {
          for (BluetoothDevice x in bondedDevices) {
            if (x.address == address) {
              print('already connected');
              setState(() {
                connected = true;
              });
            }
          }
          if (connected == null || !connected) {
            _bluetooth.bondDeviceAtAddress(address).then((_) {
              for (BluetoothDevice x in bondedDevices) {
                if (x.address == address) {
                  print('connected');
                  setState(() {
                    connected = true;
                  });
                } else {
                  print('not connected');
                  setState(() {
                    connected = false;
                  });
                }
              }
            });
          }
        },
      );
    }
  }

  @override
  Widget buildPage() {
    List<Widget> list = [];
    if (connected == null) {
      list.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'Connecting...',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ));
      list.add(CircularProgressIndicator());
    } else {
      if (connected) {
        list.add(Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Succesfully connected!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ));
      } else {
        list.add(Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Failed to connect',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ));
        list.add(RaisedButton(
          child: Text('Retry'),
          onPressed: () {
            setState(() {
              connected = null;
              run = true;
            });
          },
        ));
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
        text: 'Next Step',
        onPressed: nextOnPressed(),
      ),
    ];
  }
}
