import 'dart:convert';

DeviceHistory deviceHistoryFromJson(String str) => DeviceHistory.fromJson(json.decode(str));

String deviceHistoryToJson(DeviceHistory data) => json.encode(data.toJson());

class DeviceHistory {
    List<HistoryData> data;

    DeviceHistory({
        this.data,
    });

    factory DeviceHistory.fromJson(Map<String, dynamic> json) => DeviceHistory(
        data: List<HistoryData>.from(json["data"].map((x) => HistoryData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class HistoryData {
    String parent;
    int value;
    DateTime timestamp;

    HistoryData({
        this.parent,
        this.value,
        this.timestamp,
    });

    factory HistoryData.fromJson(Map<String, dynamic> json) => HistoryData(
        parent: json["parent"],
        value: json["value"],
        timestamp: DateTime.parse(json["timestamp"]),
    );

    Map<String, dynamic> toJson() => {
        "parent": parent,
        "value": value,
        "timestamp": timestamp.toIso8601String(),
    };
}
