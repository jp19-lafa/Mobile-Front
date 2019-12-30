import 'package:farm_lab_mobile/components/step_button.dart';
import 'package:flutter/material.dart';

class StepButtonBar extends StatelessWidget {
  const StepButtonBar({@required this.buttons});

  final List<StepButton> buttons;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
