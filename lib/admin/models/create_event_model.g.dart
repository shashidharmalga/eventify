// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEventModel _$CreateEventModelFromJson(Map<String, dynamic> json) =>
    CreateEventModel(
      name: json['name'] as String,
      club: json['club'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      dateTime: json['date_time'] as String,
      imageUrl: json['image_url'] as String,
      registrationLink: json['registration_link'] as String?,
      createdBy: json['created_by'] as String?,
      id: json['id'] as String,
    );

Map<String, dynamic> _$CreateEventModelToJson(CreateEventModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'club': instance.club,
      'location': instance.location,
      'description': instance.description,
      'id': instance.id,
      'created_by': instance.createdBy,
      'date_time': instance.dateTime,
      'image_url': instance.imageUrl,
      'registration_link': instance.registrationLink,
    };
