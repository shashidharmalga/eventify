import 'package:project_duel_role/admin/models/create_event_model.dart';
import 'package:project_duel_role/admin/services/create_event_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'create_event_provider.g.dart';

@riverpod
class CreateEventItem extends _$CreateEventItem {
  @override
  Future<List<CreateEventModel>> build() async {
    return await CreateEventService.fetchEventItems();
  }

  Future<void> updateEvent(CreateEventModel updatedEvent) async {
    await CreateEventService.updateEventItem(updatedEvent);
    state = AsyncData([
      for (final item in state.value ?? [])
        if (item.id == updatedEvent.id) updatedEvent else item,
    ]);
  }

  Future<void> deleteEvent(String id) async {
    await CreateEventService.deleteEventItem(id);
    state = AsyncData([
      for (final item in state.value ?? [])
        if (item.id != id) item,
    ]);
  }
}

@riverpod
Future<List<CreateEventModel>> CreateStudentEventItem(CreateStudentEventItemRef ref) {
  return CreateEventService.fetchStudentEventItems();
}