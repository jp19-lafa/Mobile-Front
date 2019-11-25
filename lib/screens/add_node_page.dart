import 'package:farm_lab_mobile/screens/add_node_page/step1.dart';
import 'package:farm_lab_mobile/screens/add_node_page/step2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class AddNodePage extends StatefulWidget {
  @override
  _AddNodePageState createState() => _AddNodePageState();
}

class _AddNodePageState extends State<AddNodePage>
    with SingleTickerProviderStateMixin {
  Widget page;
  List<Widget> buttons;
  int activeStep = 0;
  int totalSteps = 3;
  FlutterBlue _flutterBlue;
  AddNodeStep1 addNodeStep1;
  AddNodeStep2 addNodeStep2;
  List<BluetoothDevice> bluetoothDevices = [];

  @override
  void initState() {
    super.initState();
    _flutterBlue = FlutterBlue.instance;
    addNodeStep1 = AddNodeStep1(_flutterBlue);
    addNodeStep2 = AddNodeStep2(_flutterBlue);
    buildBody();
    buildButtons();
  }

  runTask(var nodeStep) {
    nodeStep.task().then((skip) {
      setState(() {});
      if (skip is bool && skip) {
        nextStep();
      }
    });
  }

  buildStep() {
    buildBody();
    buildButtons();
  }

  buildBody() {
    switch (activeStep) {
      case 0:
        runTask(addNodeStep1);
        page = addNodeStep1.build();
        break;
      case 1:
        runTask(addNodeStep2);
        page = addNodeStep2.buildBody();
        break;
      case 2:
        page = Text('2');
        break;
      case 3:
        page = Text('3');
        break;
      default:
        page = Text('default');
        break;
    }
  }

  buildButtons({bool previous = true}) {
    List<Widget> list = [];
    if (activeStep != 0 && previous) {
      list.add(
        RaisedButton(
          child: Text('Previous Step'),
          onPressed: () => previousStep(),
        ),
      );
    }
    if (activeStep != totalSteps) {
      list.add(
        RaisedButton(
          child: Text('Next Step'),
          color: Colors.green,
          textColor: Colors.white,
          disabledColor: Colors.grey[200],
          disabledTextColor: Colors.black,
          onPressed: () => nextStep(),
        ),
      );
    } else {
      list.add(
        RaisedButton(
          child: Text('Finish'),
          color: Colors.green,
          textColor: Colors.white,
          disabledColor: Colors.grey[200],
          disabledTextColor: Colors.black,
          onPressed: () => nextStep(),
        ),
      );
    }
    buttons = list;
  }

  nextStep() {
    setState(() {
      activeStep++;
    });
  }

  previousStep() {
    setState(() {
      activeStep--;
    });
  }

  @override
  Widget build(BuildContext context) {
    buildStep();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Node'),
      ),
      body: Center(
        child: page,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: BorderDirectional(
            top: BorderSide(
              color: Colors.grey[300],
              width: 1,
            ),
          ),
        ),
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: buttons,
        ),
      ),
    );
  }
}
