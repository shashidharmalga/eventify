import 'package:project_duel_role/student/student_status/models/student_status_model.dart';
import 'package:project_duel_role/student/student_status/services/student_status_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'student_status_provider.g.dart';

@riverpod
Future<List<StudentStatusModel>> StudentStatusList(StudentStatusListRef ref){
  return StudentStatusService.fetchStatus();
}