import 'package:farm_lab_mobile/components/step_button.dart';
import 'package:farm_lab_mobile/components/step_button_bar.dart';
import 'package:farm_lab_mobile/screens/add_node_page/add_node_step.dart';
import 'package:flutter/material.dart';

class StepController {
  StepController(this.setState);
  List<AddNodeStep> steps = [];
  int activeStep = 0;
  Widget page;
  StepButtonBar buttons;
  Function setState;

  void addStep(AddNodeStep step) {
    steps.add(step);
  }

  void nextStep() {
    setState(() {
      activeStep++;
    });
  }

  void previousStep() {
    setState(() {
      activeStep--;
    });
  }

  void runTask() {
    return steps[activeStep].task();
  }

  Widget buildBody() {
    return steps[activeStep].buildPage();
  }

  List<StepButton> buildButtons() {
    return steps[activeStep].buildButtons();
  }
}
