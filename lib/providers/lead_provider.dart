import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/db_helper.dart';
import '../models/lead.dart';

class LeadNotifier extends StateNotifier<List<Lead>> {
  LeadNotifier() : super([]) {
    loadLeads();
  }

  final DBHelper _db = DBHelper.instance;

  Future<void> loadLeads() async {
    final data = await _db.getLeads();
    state = data;
  }

  Future<void> addLead(Lead lead) async {
    await _db.insertLead(lead);
    await loadLeads();
  }

  Future<void> updateLead(Lead lead) async {
    await _db.updateLead(lead);
    await loadLeads();
  }

  Future<void> deleteLead(int id) async {
    await _db.deleteLead(id);
    await loadLeads();
  }

  List<Lead> filterByStatus(String status) {
    if (status == "All") return state;
    return state.where((lead) => lead.status == status).toList();
  }
}

final leadProvider = StateNotifierProvider<LeadNotifier, List<Lead>>(
  (ref) => LeadNotifier(),
);
