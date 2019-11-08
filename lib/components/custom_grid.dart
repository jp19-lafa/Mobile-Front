import 'package:flutter/material.dart';

class CustomGrid extends StatelessWidget {
  const CustomGrid({@required this.children, this.padding = 0});

  final List<Widget> children;
  final double padding;

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < (children.length.toDouble() / 2).ceil(); i++) {
      if (i == (children.length.toDouble() / 2).ceil() - 1 && children.length.toDouble() % 2 == 1) {
        rows.add(
          Row(
            children: <Widget>[
              children[i * 2],
            ],
          ),
        );
      } else {
        rows.add(
          Row(
            children: <Widget>[
              children[i * 2],
              SizedBox(
                width: padding,
              ),
              children[i * 2 + 1],
            ],
          ),
        );
      }
      rows.add(
        SizedBox(
          height: padding,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        children: rows,
      ),
    );
  }
}