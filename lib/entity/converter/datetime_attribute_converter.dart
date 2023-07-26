import 'package:json_annotation/json_annotation.dart';

class DateTimeAttributeConverter implements JsonConverter<DateTime, String> {
  const DateTimeAttributeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.toIso8601String();
}
