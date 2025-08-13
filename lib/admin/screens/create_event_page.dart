import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _regLinkController = TextEditingController();
  final TextEditingController _imageurlController = TextEditingController();
  final TextEditingController _clubController = TextEditingController();

  final supabase = Supabase.instance.client;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _dateController.dispose();
    _venueController.dispose();
    _regLinkController.dispose();
    _imageurlController.dispose();
    _clubController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
  }

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      if (_dateController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a date")),
        );
        return;
      }

      try {
        final userId = Supabase.instance.client.auth.currentUser?.id;

        if (userId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User not authenticated")),
          );
          return;
        }

        await Supabase.instance.client.from('events').insert({
          'name': _titleController.text.trim(),
          'description': _descController.text.trim(),
          'date_time': _dateController.text.trim(),
          'image_url': _imageurlController.text.trim(),
          'club': _clubController.text.trim(),
          'location': _venueController.text.trim(),
          'registration_link': _regLinkController.text.trim(),
          'created_by': userId,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Event created successfully")),
        );
        _formKey.currentState!.reset();
        _dateController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Unexpected Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text('Create Event', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: const [
          Icon(Icons.settings, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),

              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Event Title',
                  hintText: 'Enter event title...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),

              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Describe your event...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),

              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: _pickDate,
                decoration: InputDecoration(
                  hintText: 'dd-mm-yyyy',
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 16),
              TextFormField(
                controller: _venueController,
                decoration: InputDecoration(
                  labelText: 'Venue',
                  hintText: 'Enter venue location...',
                  prefixIcon: const Icon(Icons.location_on),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 16),
              TextFormField(
                controller: _imageurlController,
                decoration: InputDecoration(
                  labelText: 'Image URL',
                  hintText: 'Enter Image URL...',
                  prefixIcon: const Icon(Icons.image),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 16),
              TextFormField(
                controller: _clubController,
                decoration: InputDecoration(
                  labelText: 'Club',
                  hintText: 'Enter your club name...',
                  prefixIcon: const Icon(Icons.class_),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 16),
              TextFormField(
                controller: _regLinkController,
                decoration: InputDecoration(
                  labelText: 'Registration Link (Optional)',
                  hintText: 'https://forms.google.com/...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint('Save Draft clicked');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade100,
                        foregroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Save Draft'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _validateAndSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Publish', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}
