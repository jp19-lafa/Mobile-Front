import 'dart:convert';

import 'package:farm_lab_mobile/interfaces/i_node_actuators.dart';
import 'package:farm_lab_mobile/interfaces/i_node_member.dart';
import 'package:farm_lab_mobile/interfaces/i_node_sensors.dart';

INode nodeFromJson(String str) => INode.fromJson(json.decode(str));

String nodeToJson(INode data) => json.encode(data.toJson());

List<INode> nodesFromJson(String str) =>
    List<INode>.from(json.decode(str).map((x) => INode.fromJson(x)));

String nodesToJson(List<INode> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class INode {
  ISensors sensors;
  IActuators actuators;
  bool status;
  bool allowPublicStats;
  List<IMember> members;
  List<dynamic> actions;
  String id;
  String label;
  String macAddress;
  DateTime liveSince;

  INode({
    this.sensors,
    this.actuators,
    this.status,
    this.allowPublicStats,
    this.members,
    this.actions,
    this.id,
    this.label,
    this.macAddress,
    this.liveSince,
  });

  factory INode.fromJson(Map<String, dynamic> json) => INode(
        sensors: ISensors.fromJson(json["sensors"]),
        actuators: IActuators.fromJson(json["actuators"]),
        status: json["status"],
        allowPublicStats: json["allowPublicStats"],
        members:
            List<IMember>.from(json["members"].map((x) => IMember.fromJson(x))),
        actions: List<dynamic>.from(json["actions"].map((x) => x)),
        id: json["_id"],
        label: json["label"],
        macAddress: json["macAddress"],
        liveSince: DateTime.parse(json["liveSince"]),
      );

  Map<String, dynamic> toJson() => {
        "sensors": sensors.toJson(),
        "actuators": actuators.toJson(),
        "status": status,
        "allowPublicStats": allowPublicStats,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "actions": List<dynamic>.from(actions.map((x) => x)),
        "_id": id,
        "label": label,
        "macAddress": macAddress,
        "liveSince": liveSince.toIso8601String(),
      };
}
