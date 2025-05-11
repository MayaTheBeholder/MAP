import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:namibia_hockey_union/data/models/user_models/user_base_model.dart';
import 'package:namibia_hockey_union/data/services/realm_service.dart';

import '../../core/providers.dart';

class RoleManagementScreen extends ConsumerWidget {
  const RoleManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final realm = ref.read(realmServiceProvider).realm;
    final users = realm.all<UserBase>();

    return Scaffold(
      appBar: AppBar(title: const Text('User Roles')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Username')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Current Role')),
            DataColumn(label: Text('Change Role')),
          ],
          rows: users.map((user) => DataRow(cells: [
            DataCell(Text(user.username)),
            DataCell(Text(user.email)),
            DataCell(Text(user.runtimeType.toString())),
            DataCell(
              DropdownButton<String>(
                value: user.runtimeType.toString(),
                items: const [
                  DropdownMenuItem(
                    value: 'Admin',
                    child: Text('Admin'),
                  ),
                  DropdownMenuItem(
                    value: 'Coach',
                    child: Text('Coach'),
                  ),
                  DropdownMenuItem(
                    value: 'GeneralUser',
                    child: Text('General User'),
                  ),
                ],
                onChanged: (newRole) => _updateRole(realm, user, newRole),
              ),
            ),
          ])).toList(),
        ),
      ),
    );
  }

  void _updateRole(Realm realm, UserBase user, String? newRole) {
    if (newRole == null) return;

    realm.write(() {
      // Implement role change logic based on your user model
      // This is a placeholder - adjust according to your actual user model structure
    });
  }
}

class UserBase {
  String? get username => null;

  String? get email => null;
}