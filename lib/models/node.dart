import 'dart:convert';

import 'package:farm_lab_mobile/models/node_device.dart';
import 'package:farm_lab_mobile/models/node_member.dart';

Node nodeFromJson(String str) => Node.fromJson(json.decode(str));

String nodeToJson(Node data) => json.encode(data.toJson());

List<Node> nodesFromJson(String str) =>
    List<Node>.from(json.decode(str).map((x) => Node.fromJson(x)));

String nodesToJson(List<Node> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Node {
  bool status;
  bool allowPublicStats;
  List<Member> members;
  List<Device> sensors;
  List<Device> actuators;
  String id;
  String label;
  DateTime liveSince;

  Node({
    this.status,
    this.allowPublicStats,
    this.members,
    this.sensors,
    this.actuators,
    this.id,
    this.label,
    this.liveSince,
  });

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        status: json["status"],
        allowPublicStats: json["allowPublicStats"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        sensors:
            List<Device>.from(json["sensors"].map((x) => Device.fromJson(x))),
        actuators:
            List<Device>.from(json["actuators"].map((x) => Device.fromJson(x))),
        id: json["_id"],
        label: json["label"],
        liveSince: DateTime.parse(json["liveSince"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "allowPublicStats": allowPublicStats,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "sensors": List<dynamic>.from(sensors.map((x) => x.toJson())),
        "actuators": List<dynamic>.from(actuators.map((x) => x.toJson())),
        "_id": id,
        "label": label,
        "liveSince": liveSince.toIso8601String(),
      };
}
