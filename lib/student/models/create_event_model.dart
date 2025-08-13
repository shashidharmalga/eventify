import 'package:json_annotation/json_annotation.dart';
part 'create_event_model.g.dart';
@JsonSerializable()
class CreateEventModel {
  final String? id;
  final String name;
  final String description;
  final String image_url;
  final String club;
  final String location;
  final String date_time;
  final String? created_by;

  CreateEventModel({this.id,required this.name, required this.description, required this.image_url, required this.club, required this.location, required this.date_time, this.created_by});

  factory CreateEventModel.fromJson(Map<String,dynamic>json)=> _$CreateEventModelFromJson(json);
  Map<String,dynamic> toJson()=> _$CreateEventModelToJson(this);

}