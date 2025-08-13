import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:project_duel_role/student/models/create_event_model.dart';
import 'package:project_duel_role/student/providers/create_event_provider.dart';

class AdminEditScreen extends ConsumerStatefulWidget {
  final dynamic item;
  const AdminEditScreen({super.key, required this.item});

  @override
  ConsumerState<AdminEditScreen> createState() => _AdminEditScreenState();
}

class _AdminEditScreenState extends ConsumerState<AdminEditScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController imageController;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.item.name);
    descriptionController = TextEditingController(text: widget.item.description);
    locationController = TextEditingController(text: widget.item.location);
    imageController = TextEditingController(text: widget.item.imageUrl);
    selectedDate = DateFormat('d-M-yyyy').parse(widget.item.dateTime);;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    imageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  } 
  Future<void> _saveChanges() async {
    final title = titleController.text.trim();
    final desc = descriptionController.text.trim();
    final loc = locationController.text.trim();
    final imageUrl = imageController.text.trim();
    if (title.isEmpty || desc.isEmpty || loc.isEmpty || imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }
    final updatedEvent = CreateEventModel(
      id: widget.item.id,
      name: title,
      description: desc,
      location: loc,
      image_url: imageUrl,
      date_time: selectedDate.toString(),
      club: widget.item.club,
      created_by: widget.item.created_by,
    );
    try {
      await ref.read(createEventItemProvider.notifier).updateEvent(updatedEvent);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Event updated successfully")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update: $e")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Event"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageController.text,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    height: 180,
                    child: const Center(child: Icon(Icons.broken_image, size: 50)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
              ),
              const SizedBox(height: 10),

              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: "Location"),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: imageController,
                decoration: const InputDecoration(labelText: "Image URL"),
                onChanged: (_) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Text("Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}"),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text("Select Date"),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                ),
                child: const Text("Save Changes", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}