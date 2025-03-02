import 'package:verymemo/common/types/typedef.dart';

class JsonUtil {
  /// 1. Data Json
  static MAP paramsToJson({
    required List<String> keys,
    required List<dynamic> values,
  }) {
    if (keys.length != values.length) {
      throw ArgumentError("Error_paramsToJson_001");
    }

    final paramsJson = <String, dynamic>{};
    for (var i = 0; i < keys.length; i++) {
      paramsJson[keys[i]] = values[i];
    }
    return paramsJson;
  }

  /// 2. String -> Json
  static MAP stringToJson(String jsonStr) {
    jsonStr = jsonStr.replaceAll('{', '').replaceAll('}', '').trim();
    Map<String, dynamic> resultMap = {};

    List<String> keyValuePairs = jsonStr.split(', ');

    for (var pair in keyValuePairs) {
      List<String> keyValue = pair.split(': ');
      if (keyValue.length == 2) {
        String key = keyValue[0].trim();
        String value = keyValue[1].trim();
        resultMap[key] = value;
      } else {
        // log('Invalid pair: $pair');
      }
    }

    return resultMap;
  }
}
