import 'dart:convert';

INode nodeFromJson(String str) => INode.fromJson(json.decode(str));

String nodeToJson(INode data) => json.encode(data.toJson());

List<INode> nodesFromJson(String str) => List<INode>.from(json.decode(str).map((x) => INode.fromJson(x)));

String nodesToJson(List<INode> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class INode {
    Sensors sensors;
    Actuators actuators;
    bool status;
    bool allowPublicStats;
    List<Member> members;
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
        this.id,
        this.label,
        this.macAddress,
        this.liveSince,
    });

    factory INode.fromJson(Map<String, dynamic> json) => INode(
        sensors: Sensors.fromJson(json["sensors"]),
        actuators: Actuators.fromJson(json["actuators"]),
        status: json["status"],
        allowPublicStats: json["allowPublicStats"],
        members: List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
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
        "_id": id,
        "label": label,
        "macAddress": macAddress,
        "liveSince": liveSince.toIso8601String(),
    };
}

class Actuators {
    Flowpump lightint;
    Flowpump flowpump;
    Flowpump foodpump;

    Actuators({
        this.lightint,
        this.flowpump,
        this.foodpump,
    });

    factory Actuators.fromJson(Map<String, dynamic> json) => Actuators(
        lightint: Flowpump.fromJson(json["lightint"]),
        flowpump: Flowpump.fromJson(json["flowpump"]),
        foodpump: Flowpump.fromJson(json["foodpump"]),
    );

    Map<String, dynamic> toJson() => {
        "lightint": lightint.toJson(),
        "flowpump": flowpump.toJson(),
        "foodpump": foodpump.toJson(),
    };
}

class Flowpump {
    int value;
    DateTime lastChange;

    Flowpump({
        this.value,
        this.lastChange,
    });

    factory Flowpump.fromJson(Map<String, dynamic> json) => Flowpump(
        value: json["value"],
        lastChange: DateTime.parse(json["lastChange"]),
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "lastChange": lastChange.toIso8601String(),
    };
}

class Member {
    String id;
    String firstname;
    String lastname;

    Member({
        this.id,
        this.firstname,
        this.lastname,
    });

    factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
    };
}

class Sensors {
    List<Airhumidity> airtemp;
    List<Airhumidity> watertemp;
    List<Airhumidity> lightstr;
    List<Airhumidity> airhumidity;
    List<Airhumidity> waterph;

    Sensors({
        this.airtemp,
        this.watertemp,
        this.lightstr,
        this.airhumidity,
        this.waterph,
    });

    factory Sensors.fromJson(Map<String, dynamic> json) => Sensors(
        airtemp: List<Airhumidity>.from(json["airtemp"].map((x) => Airhumidity.fromJson(x))),
        watertemp: List<Airhumidity>.from(json["watertemp"].map((x) => Airhumidity.fromJson(x))),
        lightstr: List<Airhumidity>.from(json["lightstr"].map((x) => Airhumidity.fromJson(x))),
        airhumidity: List<Airhumidity>.from(json["airhumidity"].map((x) => Airhumidity.fromJson(x))),
        waterph: List<Airhumidity>.from(json["waterph"].map((x) => Airhumidity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "airtemp": List<dynamic>.from(airtemp.map((x) => x.toJson())),
        "watertemp": List<dynamic>.from(watertemp.map((x) => x.toJson())),
        "lightstr": List<dynamic>.from(lightstr.map((x) => x.toJson())),
        "airhumidity": List<dynamic>.from(airhumidity.map((x) => x.toJson())),
        "waterph": List<dynamic>.from(waterph.map((x) => x.toJson())),
    };
}

class Airhumidity {
    DateTime timestamp;
    int value;

    Airhumidity({
        this.timestamp,
        this.value,
    });

    factory Airhumidity.fromJson(Map<String, dynamic> json) => Airhumidity(
        timestamp: DateTime.parse(json["timestamp"]),
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "value": value,
    };
}
