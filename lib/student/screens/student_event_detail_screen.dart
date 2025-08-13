import 'package:flutter/material.dart';
import 'package:project_duel_role/student/models/create_event_model.dart';

class StudentEventDetailScreen extends StatelessWidget {
  final CreateEventModel item;

  const StudentEventDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final formattedDate = item.date_time ;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Details"),
        backgroundColor: const Color.fromARGB(255, 91, 43, 234),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.image_url,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Text('Image not available')),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              item.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item.club,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                const Icon(Icons.calendar_today, size: 20),
                const SizedBox(width: 8),
                Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.location_on, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.location,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              item.description,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.star_border),
                    label: const Text("Interested"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text("Going"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
