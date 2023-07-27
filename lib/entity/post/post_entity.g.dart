// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostEntity _$PostEntityFromJson(Map<String, dynamic> json) => PostEntity(
      id: json['id'] as String,
      text: json['text'] as String,
      image: json['image'] as String,
      likes: json['likes'] as int,
      link: json['link'] as String?,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      publishDate: const DateTimeAttributeConverter()
          .fromJson(json['publishDate'] as String?),
      owner: UserEntity.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostEntityToJson(PostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'image': instance.image,
      'likes': instance.likes,
      'link': instance.link,
      'tags': instance.tags,
      'publishDate':
          const DateTimeAttributeConverter().toJson(instance.publishDate),
      'owner': instance.owner,
    };
