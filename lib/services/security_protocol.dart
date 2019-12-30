import 'package:enum_to_string/enum_to_string.dart';

enum SecurityProtocol {
  WPA2,
  WPA2_Enterprise,
}

extension SecurityProtocolFunctions on SecurityProtocol {
  String getString() {
    return EnumToString.parse(this);
  }

  String getParsedString() {
    return this.getString().replaceAll(RegExp(r'_'), ' ');
  }
}
