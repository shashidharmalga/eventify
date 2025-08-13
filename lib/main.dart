import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_duel_role/admin/routing_screen.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://pdogbslwbpnorvsbfify.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBkb2dic2x3YnBub3J2c2JmaWZ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMyNjE5NDgsImV4cCI6MjA2ODgzNzk0OH0.J1GVWdFwsnOE3ekVigs4OthMcPu-UI_KLQWQkcQONfY',
  );

  runApp(ProviderScope(child:  MyApp()));

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: eventrouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      
    );
  }
}

