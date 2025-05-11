import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:namibia_hockey_union/data/models/team_model.dart';
import 'package:namibia_hockey_union/data/services/team_service.dart';
import 'package:realm/realm.dart';

import 'admin_data_ioadmin_data_io.dart';

class TeamManagementScreen extends ConsumerStatefulWidget {
  const TeamManagementScreen({super.key});

  @override
  ConsumerState<TeamManagementScreen> createState() => _TeamManagementScreenState();
}

class _TeamManagementScreenState extends ConsumerState<TeamManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _logoController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Teams')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Team Name'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              TextFormField(
                controller: _logoController,
                decoration: const InputDecoration(labelText: 'Logo URL (optional)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createTeam,
                child: const Text('Save Team'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createTeam() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final teamService = ref.read(teamServiceProvider);
        final newTeam = Team(
          ObjectId(),
          _nameController.text,
          logoUrl: _logoController.text.isNotEmpty ? _logoController.text : null,
        );

        await teamService.addTeam(newTeam);
        if (mounted) {
          context.pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error creating team: $e')),
          );
        }
      }
    }
  }
}