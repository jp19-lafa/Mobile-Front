import 'package:farm_lab_mobile/interfaces/i_node_data.dart';

class ISensors {
  IData airtemp;
  IData watertemp;
  IData lightstr;
  IData airhumidity;
  IData waterph;

  ISensors({
    this.airtemp,
    this.watertemp,
    this.lightstr,
    this.airhumidity,
    this.waterph,
  });

  factory ISensors.fromJson(Map<String, dynamic> json) => ISensors(
        airtemp: IData.fromJson(json["airtemp"]),
        watertemp: IData.fromJson(json["watertemp"]),
        lightstr: IData.fromJson(json["lightstr"]),
        airhumidity: IData.fromJson(json["airhumidity"]),
        waterph: IData.fromJson(json["waterph"]),
      );

  Map<String, dynamic> toJson() => {
        "airtemp": airtemp.toJson(),
        "watertemp": watertemp.toJson(),
        "lightstr": lightstr.toJson(),
        "airhumidity": airhumidity.toJson(),
        "waterph": waterph.toJson(),
      };
}