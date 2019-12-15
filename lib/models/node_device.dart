class Device {
  double value;
  DeviceType type;
  String id;
  DateTime timestamp;

  Device({
    this.value,
    this.type,
    this.id,
    this.timestamp,
  });

  static DeviceType _deviceTypeFromJson(Map<String, dynamic> json) {
    switch (json["type"]) {
      case "airtemp":
        return DeviceType.AirTemperature;
      case "airhumidity":
        return DeviceType.AirHumidity;
      case "watertemp":
        return DeviceType.WaterTemperature;
      case "waterph":
        return DeviceType.WaterPh;
      case "lightstr":
        return DeviceType.LightSensor;
      case "lightint":
        return DeviceType.Light;
      case "flowpump":
        return DeviceType.FlowPump;
      case "foodpump":
        return DeviceType.FoodPump;
      default:
        return null;
    }
  }

  static String _deviceTypetoJson(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.AirTemperature:
        return "airtemp";
      case DeviceType.AirHumidity:
        return "airhumidity";
      case DeviceType.WaterTemperature:
        return "watertemp";
      case DeviceType.WaterPh:
        return "waterph";
      case DeviceType.LightSensor:
        return "lightstr";
      case DeviceType.Light:
        return "lightint";
      case DeviceType.FlowPump:
        return "flowpump";
      case DeviceType.FoodPump:
        return "foodpump";
      default:
        return null;
    }
  }

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        value: double.parse(json["value"].toString()),
        type: _deviceTypeFromJson(json),
        id: json["_id"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "type": _deviceTypetoJson(type),
        "_id": id,
        "timestamp": timestamp.toIso8601String(),
      };
}

enum DeviceType {
  AirTemperature,
  AirHumidity,
  WaterTemperature,
  WaterPh,
  LightSensor,
  Light,
  FlowPump,
  FoodPump,
}
