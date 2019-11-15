class Data {
  double value;
  List<History> history;
  DateTime timestamp;

  Data({
    this.value,
    this.history,
    this.timestamp,
  });

  static List<History> _getHistory(Map<String, dynamic> json) {
    try {
      List<History> x =
          List<History>.from(json["history"].map((x) => History.fromJson(x)));
      return x;
    } catch (e) {
      return [];
    }
  }

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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

class History {
  DateTime timestamp;
  double value;

  History({
    this.timestamp,
    this.value,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        timestamp: DateTime.parse(json["timestamp"]),
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "value": value,
      };
}
