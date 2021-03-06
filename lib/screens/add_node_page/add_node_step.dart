import 'package:farm_lab_mobile/components/step_button.dart';
import 'package:farm_lab_mobile/services/step_controller.dart';
import 'package:flutter/material.dart';

abstract class AddNodeStep{
  StepController stepController;
  void dispose();
  void task({var dataFromPreviousStep});
  Widget buildPage();
  List<StepButton> buildButtons();
}