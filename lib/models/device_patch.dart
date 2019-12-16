import 'dart:convert';

DevicePatch devicePatchFromJson(String str) => DevicePatch.fromJson(json.decode(str));

String devicePatchToJson(DevicePatch data) => json.encode(data.toJson());

class DevicePatch {
    Data data;

    DevicePatch({
        this.data,
    });

    factory DevicePatch.fromJson(Map<String, dynamic> json) => DevicePatch(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    int value;
    String type;
    String id;
    DateTime timestamp;

    Data({
        this.value,
        this.type,
        this.id,
        this.timestamp,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        value: json["value"],
        type: json["type"],
        id: json["_id"],
        timestamp: DateTime.parse(json["timestamp"]),
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "type": type,
        "_id": id,
        "timestamp": timestamp.toIso8601String(),
    };
}
