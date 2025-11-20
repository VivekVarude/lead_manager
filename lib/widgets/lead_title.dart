import 'package:flutter/material.dart';
import '../models/lead.dart';

class LeadTile extends StatelessWidget {
  final Lead lead;
  final VoidCallback onTap;

  const LeadTile({
    super.key,
    required this.lead,
    required this.onTap,
  });

  Color _statusColor(String status) {
    switch (status) {
      case "New":
        return Colors.blue;
      case "Contacted":
        return Colors.orange;
      case "Converted":
        return Colors.green;
      case "Lost":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        onTap: onTap,
        title: Text(
          lead.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lead.contact),
            if (lead.notes.isNotEmpty)
              Text(
                lead.notes,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black54),
              ),
          ],
        ),
        trailing: Chip(
          label: Text(
            lead.status,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: _statusColor(lead.status),
        ),
      ),
    );
  }
}
