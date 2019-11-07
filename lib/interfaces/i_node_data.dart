class IData {
  double value;
  List<IHistory> history;
  DateTime timestamp;

  IData({
    this.value,
    this.history,
    this.timestamp,
  });

  static List<IHistory> _getHistory(Map<String, dynamic> json) {
    try {
      List<IHistory> x =
          List<IHistory>.from(json["history"].map((x) => IHistory.fromJson(x)));
      return x;
    } catch (e) {
      return [];
    }
  }

  factory IData.fromJson(Map<String, dynamic> json) => IData(
        value: json["value"].toDouble(),
        history: _getHistory(json),
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
        "lastChange": timestamp.toIso8601String(),
      };
}

class IHistory {
  DateTime timestamp;
  double value;

  IHistory({
    this.timestamp,
    this.value,
  });

  factory IHistory.fromJson(Map<String, dynamic> json) => IHistory(
        timestamp: DateTime.parse(json["timestamp"]),
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "value": value,
      };
}
