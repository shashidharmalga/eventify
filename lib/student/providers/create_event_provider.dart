import 'package:project_duel_role/student/models/create_event_model.dart';
import 'package:project_duel_role/student/services/create_event_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_event_provider.g.dart';

@riverpod
class CreateEventItem extends _$CreateEventItem {
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
  
  @override
  FutureOr<List<CreateEventModel>> build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}

@riverpod
Future<List<CreateEventModel>> CreateStudentEventItem(CreateStudentEventItemRef ref) {
  return CreateEventService.fetchStudentEventItems();
}