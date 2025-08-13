// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEventModel _$CreateEventModelFromJson(Map<String, dynamic> json) =>
    CreateEventModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      image_url: json['image_url'] as String,
      club: json['club'] as String,
      location: json['location'] as String,
      date_time: json['date_time'] as String,
      created_by: json['created_by'] as String?,
    );

Map<String, dynamic> _$CreateEventModelToJson(CreateEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image_url': instance.image_url,
      'club': instance.club,
      'location': instance.location,
      'date_time': instance.date_time,
      'created_by': instance.created_by,
    };
