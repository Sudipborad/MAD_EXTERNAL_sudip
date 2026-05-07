import 'package:flutter/material.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Tracking'),
      ),
      body: const Center(
        child: Text('Tracking Screen'),
      ),
    );
  }
}
