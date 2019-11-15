import 'dart:convert';

import 'package:farm_lab_mobile/models/node_actuators.dart';
import 'package:farm_lab_mobile/models/node_member.dart';
import 'package:farm_lab_mobile/models/node_sensors.dart';

Node nodeFromJson(String str) => Node.fromJson(json.decode(str));

String nodeToJson(Node data) => json.encode(data.toJson());

List<Node> nodesFromJson(String str) =>
    List<Node>.from(json.decode(str).map((x) => Node.fromJson(x)));

String nodesToJson(List<Node> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Node {
  Sensors sensors;
  Actuators actuators;
  bool status;
  bool allowPublicStats;
  List<Member> members;
  List<dynamic> actions;
  String id;
  String label;
  String macAddress;
  DateTime liveSince;

  Node({
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

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        sensors: Sensors.fromJson(json["sensors"]),
        actuators: Actuators.fromJson(json["actuators"]),
        status: json["status"],
        allowPublicStats: json["allowPublicStats"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
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
