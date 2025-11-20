import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/lead_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: LeadManagerApp()));
}

class LeadManagerApp extends StatelessWidget {
  const LeadManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lead Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LeadListScreen(),
    );
  }
}
