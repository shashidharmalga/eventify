import 'package:json_annotation/json_annotation.dart';
part 'student_status_model.g.dart';

@JsonSerializable()

class StudentStatusModel {
  final String? id;
  final String? event_id;
  final String? user_id;

  final String? name;

  final String? image;
  final String? club;
  final String? location;
  final DateTime? date;
  final String? status;

  StudentStatusModel({required this.id, required this.event_id, required this.user_id, required this.name, required this.image, required this.club, required this.location, required this.date, required this.status});

  factory StudentStatusModel.fromJson(Map<String,dynamic>json)=>_$StudentStatusModelFromJson(json);
  Map<String,dynamic>toJson()=>_$StudentStatusModelToJson(this);
}