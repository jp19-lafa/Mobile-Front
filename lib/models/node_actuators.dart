import 'package:farm_lab_mobile/models/node_data.dart';

class Actuators {
  Data lightint;
  Data flowpump;
  Data foodpump;

  Actuators({
    this.lightint,
    this.flowpump,
    this.foodpump,
  });

  factory Actuators.fromJson(Map<String, dynamic> json) => Actuators(
        lightint: Data.fromJson(json["lightint"]),
        flowpump: Data.fromJson(json["flowpump"]),
        foodpump: Data.fromJson(json["foodpump"]),
      );

  Map<String, dynamic> toJson() => {
        "lightint": lightint.toJson(),
        "flowpump": flowpump.toJson(),
        "foodpump": foodpump.toJson(),
      };
}
