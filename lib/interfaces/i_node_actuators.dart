import 'package:farm_lab_mobile/interfaces/i_node_data.dart';

class IActuators {
  IData lightint;
  IData flowpump;
  IData foodpump;

  IActuators({
    this.lightint,
    this.flowpump,
    this.foodpump,
  });

  factory IActuators.fromJson(Map<String, dynamic> json) => IActuators(
        lightint: IData.fromJson(json["lightint"]),
        flowpump: IData.fromJson(json["flowpump"]),
        foodpump: IData.fromJson(json["foodpump"]),
      );

  Map<String, dynamic> toJson() => {
        "lightint": lightint.toJson(),
        "flowpump": flowpump.toJson(),
        "foodpump": foodpump.toJson(),
      };
}
