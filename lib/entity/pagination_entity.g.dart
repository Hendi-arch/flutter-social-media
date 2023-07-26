// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationEntity<T> _$PaginationEntityFromJson<T>(Map<String, dynamic> json) =>
    PaginationEntity<T>(
      total: json['total'] as int,
      page: json['page'] as int,
      limit: json['limit'] as int,
      data: PaginationEntity._dataFromJson(json['data'] as Object),
    );
