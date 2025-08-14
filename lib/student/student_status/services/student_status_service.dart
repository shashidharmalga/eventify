import 'package:project_duel_role/student/student_status/models/student_status_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentStatusService {
  static Future<List<StudentStatusModel>> fetchStatus() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;

    final response = await supabase.from("event_status").select("*, events(*)").eq("user_id", userId);

    final data = response as List;
    return data.map((item) {
      final event = item['events'] ?? {};
      return StudentStatusModel(
        id: item['id'],
        event_id: item['event_id'],
        user_id: item['user_id'],
        name: event['name'],
        image: event['image'],
        club: event['club'],
        location: event['location'],
        date: event['date'] != null ? DateTime.parse(event['date']) : null,
        status: item['status'],
      );
    }).toList();
    
  }
  

  static Future<void> markStatus({
    required String eventId,
    required String status,
  }) async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;
    final existing = await supabase
      .from('event_status')
      .select()
      .eq('event_id', eventId)
      .eq('user_id', userId)
      .eq('status', status);

      if (existing.isNotEmpty) {
        return;
      }

    await supabase.from('event_status').upsert({
     'user_id': userId,
     'event_id': eventId,
     'status': status,
   });
  }
  
  static Future<void>deleteStatus({required String event_id, required String status}) async{
    final userId= Supabase.instance.client.auth.currentUser?.id;
    if (userId==null) throw Exception("No Logged in User");
    final supabase=Supabase.instance.client;
    await supabase.from("event_status").delete().eq("event_id", event_id).eq("user_id", userId).eq("status", status);

  }
}
