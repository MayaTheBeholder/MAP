import 'package:flutter/material.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Dashboard")),
      body: ListView(
        children: const [
          ListTile(title: Text("View Players")),
          ListTile(title: Text("View Teams")),
          ListTile(title: Text("View Events")),
          ListTile(title: Text("Like/Comment on Events and Posts")),
        ],
      ),
    );
  }
}
