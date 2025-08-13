 import 'package:json_annotation/json_annotation.dart';

part 'create_event_model.g.dart';

@JsonSerializable()

 class CreateEventModel {
    
  final String name;
  final String club;
  final String location;
  final String description;
  final String id;
  @JsonKey(name: "created_by")
  final String? createdBy;

  @JsonKey(name:"date_time")
  final String dateTime;

  @JsonKey(name:"image_url")
  final String imageUrl;

  @JsonKey(name:"registration_link")
  final String? registrationLink;
  
  CreateEventModel({required this.name, required this.club, required this.location, required this.description, required this.dateTime, required this.imageUrl,  this.registrationLink,  this.createdBy,required this.id});
   
  factory CreateEventModel.fromJson(Map<String, dynamic> json) =>
      _$CreateEventModelFromJson(json);

  Map<String, dynamic> toJson() =>_$CreateEventModelToJson(this);
 }
