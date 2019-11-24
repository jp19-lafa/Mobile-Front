import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';

class AddNodePage extends StatefulWidget {
  @override
  _AddNodePageState createState() => _AddNodePageState();
}

class _AddNodePageState extends State<AddNodePage>
    with SingleTickerProviderStateMixin {
  int activeStep = 0;
  int totalSteps = 3;

  List<Widget> loadPage(){
    stepAction();
    return getContent();
  }

  List<Widget> getContent() {
    switch (activeStep) {
      case 0:
        return [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Open Bluetooth settings\n\nConnect to the FarmLab',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          RaisedButton(
            child: Text('Open Bluetooth settings'),
            onPressed: () => OpenSettings.openBluetoothSetting(),
          ),
        ];
      case 1:
        return [
          Text('1'),
        ];
      case 2:
        return [
          Text('2'),
        ];
      case 3:
        return [
          Text('3'),
        ];
      default:
        return [Text('default')];
    }
  }

    stepAction() {
    switch (activeStep) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      default:
        break;
    }
  }

  List<Widget> getButtons() {
    List<Widget> list = [];
    if (activeStep != 0) {
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
    return list;
  }

  nextStep() {
    if (activeStep != totalSteps) {
      setState(() {
        activeStep++;
      });
    }
  }

  previousStep() {
    if (activeStep != 0) {
      setState(() {
        activeStep--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Node'),
      ),
      body: Center(
        child: Column(
          children: loadPage(),
        ),
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
          children: getButtons(),
        ),
      ),
    );
  }
}
