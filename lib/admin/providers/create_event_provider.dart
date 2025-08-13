import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_duel_role/admin/models/create_event_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'create_event_provider.g.dart';

@riverpod
class CreateEventNotifier extends _$CreateEventNotifier {
  final supabase = Supabase.instance.client;

  @override
  Future<List<CreateEventModel>> build() async {
    return await _fetchCreateEvents();
  }

  Future<List<CreateEventModel>>  _fetchCreateEvents() async {
    final userId = supabase.auth.currentUser!.id;
    final response = await supabase
        .from('events')
        .select()
        .eq('created_by', userId);
    return response.map((e) => CreateEventModel.fromJson(e)).toList();
  }


}

