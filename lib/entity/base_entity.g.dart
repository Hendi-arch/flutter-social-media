// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseEntity<T> _$BaseEntityFromJson<T>(Map<String, dynamic> json) =>
    BaseEntity<T>(
      total: json['total'] as int,
      page: json['page'] as int,
      limit: json['limit'] as int,
      data: BaseEntity._dataFromJson(json['data'] as Object),
    );
