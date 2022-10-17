// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MediaModel _$$_MediaModelFromJson(Map<String, dynamic> json) =>
    _$_MediaModel(
      id: json['id'] as int?,
      name: json['title']['romaji'] as String?,
      type: json['type'] as String?,
      image: json['coverImage']['large'] as String?,
    );

Map<String, dynamic> _$$_MediaModelToJson(_$_MediaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'image': instance.image,
    };
