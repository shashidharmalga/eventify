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
      'description':
          'Fosters innovation with coding, tech talks, and hands-on sessions.',
      'image':
          'https://marketplace.canva.com/EAFzZYHiGOk/1/0/1600w/canva-colorful-illustrative-3d-robot-artificial-intelligence-logo-5f8exu36qDU.jpg',
    },
    {
      'name': 'Cultural Club',
      'description':
          'Celebrates diversity with dance, music, and traditional festivals.',
      'image':
          'https://cdn.dribbble.com/userupload/20928905/file/original-e3d18b312b4c6083a52ae8b7ef4cb041.jpg',
    },
    {
      'name': 'Sports Club',
      'description':
          'Promotes fitness with tournaments and sporting events.',
      'image':
          'https://static.vecteezy.com/system/resources/thumbnails/036/289/018/small_2x/sports-football-soccer-club-logo-design-vector.jpg',
    },
    {
      'name': 'Music Club',
      'description':
          'Unites music lovers with open mics and jam sessions.',
      'image':
          'https://protoinfrastack-myfirstbucketb8884501-fnnzvxt2ee5v.s3.amazonaws.com/WzZLLi8702jtlFyTzwwwvqIp7qZ3pN8Nea19.png',
    },
    {
      'name': 'Photography Club',
      'description':
          'Captures moments through lenses and photo walks.',
      'image':
          'https://png.pngtree.com/png-vector/20240621/ourmid/pngtree-colorful-camera-logo-on-white-background-vector-png-image_7039940.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Explore Clubs",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final club = clubs[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20)),
                          child: Image.network(
                            club['image'] ?? '',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                club['name'] ?? '',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              const SizedBox(height: 8),

                              Text(
                                club['description'] ?? '',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[800],
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 12),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "You joined ${club['name']}!"),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                  ),
                                  icon: const Icon(Icons.group_add),
                                  label: const Text(
                                    "Join Club",
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                    
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: clubs.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
