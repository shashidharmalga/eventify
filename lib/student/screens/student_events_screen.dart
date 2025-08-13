import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_duel_role/student/student_status/provider/student_status_provider.dart';

class StudentEventsScreen extends ConsumerStatefulWidget{
  const StudentEventsScreen({super.key});

  @override 

  ConsumerState<StudentEventsScreen> createState()=>_StudentEventsScreen();
}
class _StudentEventsScreen extends ConsumerState<StudentEventsScreen>{
  List<String> statusTabs = ['Interested','Going','Past'];
  @override 
  Widget build(BuildContext context){
    final eventAsync = ref.watch(studentStatusListProvider);
    return DefaultTabController(
      length: statusTabs.length,
      child: Scaffold(
        appBar: AppBar(title: Text("My Events", style: TextStyle(fontSize: 28),),
        bottom: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          indicatorColor: Colors.blue,
          tabs: statusTabs.map((s) => Tab(text: s)).toList(),
        ),
        ),
        body: eventAsync.when(
          data: (events){
            return TabBarView(
              children: statusTabs.map((tabStatus) {
                final filteredEvents = events
                    .where((e) => e.status?.toLowerCase() == tabStatus.toLowerCase())
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
                            ? Image.network(event.image!, width: 50, height: 50, fit: BoxFit.cover)
                            : const Icon(Icons.event),
                        title: Text(event.name ?? "No Title"),
                        subtitle: Text("${event.club ?? "Unknown Club"} • ${event.location ?? "No Location"}"),
                        trailing: Text(event.status ?? ""),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          },
          error: (err,_)=>Center(child: Text("Error man: $err"),), 
          loading: ()=>Center(child: CircularProgressIndicator(),))
      ),
    );
    
  }
}