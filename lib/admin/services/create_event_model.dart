import 'package:project_duel_role/admin/models/create_event_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateEventService {

  static Future<List<CreateEventModel>> fetchCreateEvents() async{
    final supabase= Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;
    
    final response= await supabase
        .from("events")
        .select()
        .eq("user_id", userId);
    return (response as List).map((item)=>CreateEventModel.fromJson(item)).toList();

  }
    static Future<void> deleteEventItem(String id) async {
    final supabase = Supabase.instance.client;
    await supabase.from("events").delete().eq("id", id);
  }

  static Future<void> updateEventItem(CreateEventModel event) async {
  final supabase = Supabase.instance.client;

  if (event.id == null) {
    throw Exception("Event ID is required for update");
  }
  try{
    await supabase
        .from("events")
        .update(event.toJson())
        .eq("id", event.id).select();
  }

  catch(e) {
    throw Exception("Failed to update event: $e");
}
  }

}