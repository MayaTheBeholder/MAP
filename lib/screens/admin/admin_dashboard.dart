import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Dashboard")),
      body: ListView(
        children: const [
          ListTile(title: Text("Manage Users")),
          ListTile(title: Text("Edit/Delete Teams")),
          ListTile(title: Text("Edit/Delete Players")),
          ListTile(title: Text("Create/Delete Events")),
          ListTile(title: Text("Create/Delete Posts")),
        ],
      ),
    );
  }
}
