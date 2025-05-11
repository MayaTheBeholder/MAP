import 'package:flutter/material.dart';

class CoachDashboard extends StatelessWidget {
  const CoachDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Coach Dashboard")),
      body: ListView(
        children: const [
          ListTile(title: Text("Create/Edit Player Profiles")),
          ListTile(title: Text("Create/Edit Team Profile")),
          ListTile(title: Text("Create/Delete Posts")),
        ],
      ),
    );
  }
}
