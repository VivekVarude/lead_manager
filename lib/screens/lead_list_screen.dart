import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/lead_provider.dart';
import '../widgets/lead_title.dart';
import 'add_lead_screen.dart';
import 'lead_detail_screen.dart';

class LeadListScreen extends ConsumerStatefulWidget {
  const LeadListScreen({super.key});

  @override
  ConsumerState<LeadListScreen> createState() => _LeadListScreenState();
}

class _LeadListScreenState extends ConsumerState<LeadListScreen> {
  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    final leads = ref.watch(leadProvider);
    final filtered = ref.read(leadProvider.notifier).filterByStatus(selectedFilter);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lead Manager"),
        actions: [
          DropdownButton<String>(
            value: selectedFilter,
            items: ["All", "New", "Contacted", "Converted", "Lost"]
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (v) => setState(() => selectedFilter = v!),
          ),
        ],
      ),
      body: filtered.isEmpty
          ? const Center(child: Text("No Leads Found"))
          : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) => LeadTile(
                lead: filtered[index],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LeadDetailScreen(lead: filtered[index]),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddLeadScreen()),
        ),
      ),
    );
  }
}
