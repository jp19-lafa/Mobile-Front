import 'package:flutter/material.dart';

class StepButton extends StatefulWidget {
 StepButton({@required this.text, @required this.onPressed, this.green = true});

 final String text;
 final Function onPressed;
 final bool green;

  @override
  _StepButtonState createState() => _StepButtonState();
}

class _StepButtonState extends State<StepButton> {
  Color buttonColor;
  Color buttonTextColor;

  getColors(){
    if(widget.green){
      buttonColor = Colors.green;
      buttonTextColor = Colors.white;
    }
    else{
      buttonColor = Colors.grey[300];
      buttonTextColor = Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    getColors();
    return RaisedButton(
      child: Text(widget.text),
      color: buttonColor,
      textColor: buttonTextColor,
      onPressed: widget.onPressed,
    );
  }
}
