import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  Map<String,dynamic>? userData;
  bool isLoading = true;
  final supabase= Supabase.instance.client.auth.currentUser?.id;
  @override
  void initState(){
    super.initState();
    fetchUserData();
  }
  void signOut() async{
   await Supabase.instance.client.auth.signOut();
   if (mounted){
      context.go('/login');
   }
  }

  Future<void> fetchUserData()async {
    try{
      final userId = await Supabase.instance.client.auth.currentUser?.id;
      if(userId != null){
        final response = await Supabase.instance.client.from("profile").select().eq('id', userId).maybeSingle();
        if(response != null){
          setState(() {
            userData = Map<String, dynamic>.from(response);
            isLoading =false;
          });
        }
        else{
          setState(() {
            userData = null;
            isLoading = false;
          });
        }
      }
    }
    catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
            ? const Center(child: Text("No user data found."))
            : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/Student.webp'),
                          backgroundColor: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          userData!['username'] ?? 'No Name',
                          style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userData!['email'] ?? '',
                          style: const TextStyle(
                            fontSize: 14, color: Color.fromARGB(255, 101, 100, 100)),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Chip(
                              label: Text("Role: ${userData!['role']}"),
                              backgroundColor: Colors.blue[100],
                            ),
                            Chip(
                              label: Text("Year: ${userData!['year']}"),
                              backgroundColor: Colors.green[100],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                          label: const Text("Edit Profile",style: TextStyle(color: Colors.white),),
                          
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,  
                          ),
                        ),
                        ElevatedButton(onPressed: signOut, child: Text("Log out"))
                      ],
                  ),
                ),
              ),
            ),
    );
  }
}