import 'package:project_duel_role/student/student_status/models/student_status_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentStatusService {
  static Future<List<StudentStatusModel>> fetchStatus() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;

    final response = await supabase.from("event_status").select(", events()").eq("user_id", userId);

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

  await supabase.from('event_status').upsert({
    'user_id': userId,
    'event_id': eventId,
    'status': status,
  });
}

}