// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentStatusModel _$StudentStatusModelFromJson(Map<String, dynamic> json) =>
    StudentStatusModel(
      id: json['id'] as String?,
      event_id: json['event_id'] as String?,
      user_id: json['user_id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      club: json['club'] as String?,
      location: json['location'] as String?,
      date: json['date'] == null
          ? null
          : DateTime.parse(json['date'] as String),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$StudentStatusModelToJson(StudentStatusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.event_id,
      'user_id': instance.user_id,
      'name': instance.name,
      'image': instance.image,
      'club': instance.club,
      'location': instance.location,
      'date': instance.date?.toIso8601String(),
      'status': instance.status,
    };
