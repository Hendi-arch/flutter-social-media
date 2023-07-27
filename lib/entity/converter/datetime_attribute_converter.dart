import 'package:json_annotation/json_annotation.dart';

class DateTimeAttributeConverter implements JsonConverter<DateTime?, String?> {
  const DateTimeAttributeConverter();

  @override
  DateTime? fromJson(String? json) =>
      json != null ? DateTime.parse(json) : null;

  @override
  String? toJson(DateTime? object) => object?.toIso8601String();
}
