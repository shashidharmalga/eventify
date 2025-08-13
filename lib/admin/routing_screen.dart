import 'dart:math';

import 'package:go_router/go_router.dart';
import 'package:project_duel_role/admin/screens/admin_bottom_bar.dart';
import 'package:project_duel_role/admin/screens/admin_profile_screen.dart';
import 'package:project_duel_role/admin/screens/auth/login_screen.dart';
import 'package:project_duel_role/admin/screens/auth/register_page.dart';
import 'package:project_duel_role/admin/screens/create_event_page.dart';
import 'package:project_duel_role/admin/screens/events_page.dart';
import 'package:project_duel_role/admin/screens/home_screen.dart';
import 'package:project_duel_role/admin/screens/students_club_screen.dart';
import 'package:project_duel_role/student/screens/student_events_screen.dart';
import 'package:project_duel_role/student/screens/student_home_screen.dart';
import 'package:project_duel_role/student/screens/student_profile_screen.dart';
import 'package:project_duel_role/student/student_bottom_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
Future<String?> getUserRole() async{
  final userId = Supabase.instance.client.auth.currentUser!.id;
  if(userId==null) return null;
  final response = await Supabase.instance.client.from("profile").select().eq("id", userId).single();
  return response["role"] as String?;
}
final eventrouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final role = getUserRole();
    if (state.uri.toString() == '/' && role == 'Admin') {
      return '/admin/home';
    } else if (state.uri.toString() == '/' && role == 'Student') {
      return '/student/home';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (context, state) => LoginPage(String: String),),
    GoRoute(path: '/admin/myEvents', builder: (context, state) => EventsPage(),),
    GoRoute(path: "/", builder: (context,state)=> LoginPage(String: String)),
    GoRoute(path: "/register", builder:(context, state) => RegisterScreen(),),

    ShellRoute(
      builder: (context, state, child) {
        return AdminBottomBar(child: child);
      },
      routes: [
        GoRoute(path: '/admin/home', builder: (context, state) =>HomeScreen()),
        GoRoute(path: '/admin/createEvent', builder: (context, state) => CreateEventPage()),
        GoRoute(path: '/admin/clubs', builder: (context,state)=>StudentClubsScreen()),
        GoRoute(path: '/admin/profile',builder: (context,state)=> AdminProfileScreen()),

      ],
    ),
    ShellRoute(
      builder: (context, state, child) {
        return StudentBottomBar(child: child); 
      },
      routes: [
        GoRoute(path: '/student/home', builder: (context, state) => StudentHomeScreen()),
        GoRoute(path: '/student/profile', builder: (context, state) => StudentProfileScreen()),
        GoRoute(path: '/student/events', builder: (context,state)=> StudentEventsScreen()),
        GoRoute(path: '/student/clubs',builder: (context,state)=>StudentClubsScreen())
      ],
    ),
  ],
);