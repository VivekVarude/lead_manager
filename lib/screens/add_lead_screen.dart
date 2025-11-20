import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/lead_provider.dart';
import '../models/lead.dart';

class AddLeadScreen extends ConsumerWidget {
  const AddLeadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final contactController = TextEditingController();
    final notesController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Lead")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: contactController, decoration: const InputDecoration(labelText: "Contact")),
            TextField(controller: notesController, decoration: const InputDecoration(labelText: "Notes")),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final lead = Lead(
                  name: nameController.text,
                  contact: contactController.text,
                  notes: notesController.text,
                  status: "New",
                );

                ref.read(leadProvider.notifier).addLead(lead);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
