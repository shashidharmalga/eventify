import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  Map<String, dynamic>? _adminData;

  @override
  void initState() {
    super.initState();
    _fetchAdminData();
  }

  Future<void> _fetchAdminData() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;

      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not authenticated")),
        );
        return;
      }

      final response = await Supabase.instance.client
          .from('profile')
          .select()
          .eq('id', userId)
          .single();

      setState(() {
        _adminData = response;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching profile: $e")),
      );
    }
  }

  Future<void> _logout() async {
    try {
      await Supabase.instance.client.auth.signOut();

      if (!mounted) return;
      context.go('/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed: $e")),
      );
    }
     
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Profile'),
      ),
      body: _adminData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      _adminData!['profile_picture'] ??
                          'https://res.cloudinary.com/dw0c83aad/image/upload/v1729139005/dhoni_pnnmrd.webp',
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    _adminData!['username'] ?? '',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    _adminData!['email'] ?? '',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: const [
                          Text("12",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("Events", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Column(
                        children: const [
                          Text("150",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("Attendees",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Column(
                        children: const [
                          Text("4.8",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("Rating", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  ListTile(
                    leading: const Icon(Icons.event),
                    title: const Text('My Events'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Create New Event'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text('Change Password'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _logout,
                  ),
                ],
              ),
            ),
    );
  }
}
