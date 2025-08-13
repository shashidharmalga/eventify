import 'package:flutter/material.dart';

class StudentClubsScreen extends StatefulWidget {
  const StudentClubsScreen({super.key});
   
  @override
  State<StudentClubsScreen> createState() => _StudentClubsScreenState();

}

class _StudentClubsScreenState extends State<StudentClubsScreen> {
  final List<Map<String, String>> clubs = [
    {
      'name': 'Tech Club',
      'description': 'Fosters innovation with coding, tech talks, and hands-on sessions.',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/c/cb/Club_Tech%27s_logo.png',
    },
    {
      'name': 'Cultural Club',
      'description':'Celebrates diversity with dance, music, and traditional festivals.',
      'image':'https://cdn-icons-png.flaticon.com/512/4290/4290854.png',
    },
    {
      'name': 'Sports Club',
      'description':'Promotes fitness with tournaments and sporting events.',
      'image':'https://cdn-icons-png.flaticon.com/512/5342/5342060.png',
    },
    {
      'name': 'Music Club',
      'description':'Unites music lovers with open mics and jam sessions.',
      'image':'https://cdn-icons-png.flaticon.com/512/609/609361.png',
    },
    {
      'name': 'Photography Club',
      'description':'Captures moments through lenses and photo walks.',
      'image':'https://cdn-icons-png.flaticon.com/512/2659/2659360.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Clubs"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: clubs.length,
        itemBuilder: (context, index) {
          final club = clubs[index];
          return Card(
            elevation: 6,
            margin: const EdgeInsets.only(bottom: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    club['image']!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        club['name']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        club['description']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      
    );
  }
}
