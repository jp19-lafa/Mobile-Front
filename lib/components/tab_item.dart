import 'package:flutter/material.dart';

class TabItem extends StatefulWidget {
  TabItem({@required this.text, @required this.onPressed, this.active = false});

  final String text;
  final Function onPressed;
  final bool active;

  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  BorderSide getLine() {
    if (widget.active) {
      return BorderSide(color: Colors.green, width: 2);
    }
    else{
      return BorderSide(color: Colors.transparent, width: 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: getLine(),
        ),
      ),
      child: FlatButton(
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
