import 'package:flutter/material.dart';

class NodePage extends StatelessWidget {
  NodePage({@required this.pageName, this.temperature});

  final String pageName;
  final double temperature;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName),
      ),
      body: Column(
        children: <Widget>[
          Text('Temperature: $temperature')
        ],
      ),
    );
  }
}
