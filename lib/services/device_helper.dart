import 'package:farm_lab_mobile/models/device_history.dart';
import 'package:farm_lab_mobile/models/device_patch.dart';
import 'package:farm_lab_mobile/models/node_device.dart';
import 'package:farm_lab_mobile/services/networking.dart';

class DeviceHelper {
  String token;
  NetworkHelper _networkHelper;
  DeviceHelper(String token) {
    this.token = token;
    this._networkHelper = NetworkHelper(this.token);
  }

  Future<dynamic> getDeviceHistory(Device device, {int limit = 5}) async {
    String endpoint;
    if (device.type == DeviceType.Light ||
        device.type == DeviceType.FlowPump ||
        device.type == DeviceType.FoodPump) {
      endpoint = "/actuators/";
    } else {
      endpoint = "/sensors/";
    }
    endpoint += device.id;
    endpoint += "?limit=$limit";

    String returnData = await _networkHelper.getRequest(endpoint + device.id);
    if (returnData is DeviceHistory) {
      DeviceHistory deviceData = deviceHistoryFromJson(returnData);
      return deviceData;
    } else {
      return returnData;
    }
  }

  Future<dynamic> updateActuator(Device device, int value) async {
    if (device.type == DeviceType.Light ||
        device.type == DeviceType.FlowPump ||
        device.type == DeviceType.FoodPump) {
      String data =
          deviceToJson(Device(value: double.parse(value.toStringAsFixed(0))));
      String returnData = await _networkHelper.patchRequest(
        "/actuators/" + device.id,
        data,
      );
      if (returnData is DevicePatch) {
        DevicePatch deviceData = devicePatchFromJson(returnData);
        return deviceData;
      }
      else{
        return returnData;
      }
    } else {
      return Future(() {
        return 422;
      });
    }
  }
}
