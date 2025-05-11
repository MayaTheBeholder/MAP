// lib/features/coach/team_management_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';
import '../../data/models/team_model.dart';
import '../../data/services/team_service.dart';

class TeamManagementScreen extends ConsumerStatefulWidget {
  final String? teamCode;
  const TeamManagementScreen({this.teamCode, super.key});

  @override
  ConsumerState<TeamManagementScreen> createState() => _TeamManagementScreenState();
}

class _TeamManagementScreenState extends ConsumerState<TeamManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final teamService = ref.read(teamServiceProvider);
    final team = widget.teamCode != null 
        ? teamService.getTeam(widget.teamCode!) 
        : null;
    _nameController = TextEditingController(text: team?.teamName ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.teamCode == null ? 'Create Team' : 'Edit Team'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Team Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTeam,
                child: Text(widget.teamCode == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTeam() {
    if (_formKey.currentState!.validate()) {
      final teamService = ref.read(teamServiceProvider);
      if (widget.teamCode == null) {
        final newTeam = TeamModel(
          teamCode: 'TCO${DateTime.now().millisecondsSinceEpoch}',
          teamName: _nameController.text,
        );
        teamService.createTeam(newTeam);
      } else {
        teamService.updateTeam(widget.teamCode!, _nameController.text);
      }
      context.pop();
    }
  }
}