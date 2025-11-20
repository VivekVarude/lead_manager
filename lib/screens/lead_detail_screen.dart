import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lead.dart';
import '../providers/lead_provider.dart';

class LeadDetailScreen extends ConsumerWidget {
  final Lead lead;

  const LeadDetailScreen({super.key, required this.lead});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController(text: lead.name);
    final contactController = TextEditingController(text: lead.contact);
    final notesController = TextEditingController(text: lead.notes);

    String currentStatus = lead.status;

    return Scaffold(
      appBar: AppBar(title: const Text("Lead Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: contactController, decoration: const InputDecoration(labelText: "Contact")),
            TextField(controller: notesController, decoration: const InputDecoration(labelText: "Notes")),
            DropdownButton<String>(
              value: currentStatus,
              items: ["New", "Contacted", "Converted", "Lost"]
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) {
                currentStatus = v!;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text("Update"),
              onPressed: () {
                final updatedLead = Lead(
                  id: lead.id,
                  name: nameController.text,
                  contact: contactController.text,
                  notes: notesController.text,
                  status: currentStatus,
                );
                ref.read(leadProvider.notifier).updateLead(updatedLead);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                ref.read(leadProvider.notifier).deleteLead(lead.id!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
