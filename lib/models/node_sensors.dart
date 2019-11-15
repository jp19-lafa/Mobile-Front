import 'package:farm_lab_mobile/models/node_data.dart';

class Sensors {
  Data airtemp;
  Data watertemp;
  Data lightstr;
  Data airhumidity;
  Data waterph;

  Sensors({
    this.airtemp,
    this.watertemp,
    this.lightstr,
    this.airhumidity,
    this.waterph,
  });

  factory Sensors.fromJson(Map<String, dynamic> json) => Sensors(
        airtemp: Data.fromJson(json["airtemp"]),
        watertemp: Data.fromJson(json["watertemp"]),
        lightstr: Data.fromJson(json["lightstr"]),
        airhumidity: Data.fromJson(json["airhumidity"]),
        waterph: Data.fromJson(json["waterph"]),
      );

  Map<String, dynamic> toJson() => {
        "airtemp": airtemp.toJson(),
        "watertemp": watertemp.toJson(),
        "lightstr": lightstr.toJson(),
        "airhumidity": airhumidity.toJson(),
        "waterph": waterph.toJson(),
      };
}