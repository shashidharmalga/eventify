import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentBottomBar extends StatelessWidget {
  final Widget child;
  const StudentBottomBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    int currentIndex = _calculatecurrentIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/student/home');
              break;
            case 1:
              context.go('/student/events'); 
              break;
            case 2:
              context.go('/student/clubs');
              break;
            case 3:
              context.go('/student/profile');
              break;
          }
        },
        backgroundColor: Colors.purple,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: "Events"),
          BottomNavigationBarItem(icon: Icon(Icons.content_paste_outlined), label: "Clubs"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

int _calculatecurrentIndex(String location) {
  if (location.contains('/student/home')) return 0;
  if (location.contains('/student/events')) return 1;
  if (location.contains('/student/clubs')) return 2;
  if (location.contains('/student/profile')) return 3;
  return 0;
}
