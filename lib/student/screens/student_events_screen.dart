import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_duel_role/student/student_status/provider/student_status_provider.dart';
import 'package:project_duel_role/student/student_status/services/student_status_service.dart';

class StudentEventsScreen extends ConsumerStatefulWidget {
  const StudentEventsScreen({super.key});

  @override
  ConsumerState<StudentEventsScreen> createState() =>
      _StudentEventsScreenState();
}

class _StudentEventsScreenState extends ConsumerState<StudentEventsScreen> {
  final List<String> statusTabs = ['Interested', 'Going'];

  @override
  Widget build(BuildContext context) {
    final eventAsync = ref.watch(studentStatusListProvider);

    return DefaultTabController(
      length: statusTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Events",
            style: TextStyle(fontSize: 28),
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.blue,
            tabs: statusTabs.map((s) => Tab(text: s)).toList(),
          ),
        ),
        body: eventAsync.when(
          data: (events) {
            return TabBarView(
              children: statusTabs.map((tabStatus) {
                final filteredEvents = events
                    .where((e) =>
                        (e.status ?? '').toLowerCase() ==
                        tabStatus.toLowerCase())
                    .toList();

                if (filteredEvents.isEmpty) {
                  return Center(child: Text("No $tabStatus events"));
                }

                return ListView.builder(
                  itemCount: filteredEvents.length,
                  itemBuilder: (context, index) {
                    final event = filteredEvents[index];

                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: event.image != null
                                ? ClipRRect(
                                 borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                  event.image!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.event, size: 40);
                                       },
                                        ),
                                      )
                                : const Icon(Icons.event, size: 40),

                        title: Text(event.name ?? "No Title"),
                        subtitle: Text(
                          "${event.club ?? "Unknown Club"} • ${event.location ?? "No Location"}",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(event.status ?? ""),
                            const SizedBox(width: 5),
                            IconButton(onPressed: () async{
                              if (event.event_id!=null){
                                await StudentStatusService.deleteStatus(event_id: '${event.event_id}', status: '${event.status}');
                              }

                            }, icon: Icon(Icons.cancel))
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          },
          error: (err, _) => Center(
            child: Text("Error man: $err"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
