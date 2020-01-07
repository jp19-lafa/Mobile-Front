import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  GradientButton(
    this.text, {
    @required this.onPressed,
    @required this.gradientColors,
    this.padding = const EdgeInsets.fromLTRB(80, 15, 80, 15),
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.gradientBegin = Alignment.centerLeft,
    this.gradientEnd = Alignment.centerRight,
  });

  final String text;
  final VoidCallback onPressed;
  final List<Color> gradientColors;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final EdgeInsets padding;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.transparent,
      elevation: 0,
      highlightElevation: 1,
      onPressed: onPressed,
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: gradientBegin,
            end: gradientEnd,
          ),
          borderRadius: borderRadius,
        ),
        padding: padding,
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
