import 'package:project_duel_role/admin/models/create_event_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateEventService {
  static final supabase = Supabase.instance.client;

  static Future<List<CreateEventModel>> fetchEventItems() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("No logged-in user");

    final response = await supabase
        .from("events")
        .select()
        .eq("created_by", user.id);

    if (response is! List) {
      throw Exception("Unexpected response format");
    }

    return response
        .map((e) => CreateEventModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<List<CreateEventModel>> fetchStudentEventItems() async {
    final response = await supabase.from("events").select();
    if (response is! List) {
      throw Exception("Unexpected response format");
    }
    return response
        .map((e) => CreateEventModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<void> deleteEventItem(String id) async {
    await supabase.from("events").delete().eq("id", id);
  }

  static Future<void> updateEventItem(CreateEventModel event) async {
    try {
      final response = await supabase
          .from("events")
          .update(event.toJson())
          .eq("id", event.id)
          .select();

      if (response is! List) {
        throw Exception("Unexpected response format: $response");
      }
    } catch (e) {
      throw Exception("Failed to update event: $e");
    }
  }
}
