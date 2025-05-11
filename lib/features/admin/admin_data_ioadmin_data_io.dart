import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:realm/realm.dart';
import 'package:namibia_hockey_union/data/models/team_model.dart';
import 'package:namibia_hockey_union/data/services/realm_service.dart';

import '../../core/providers.dart';

class AdminDataIOScreen extends ConsumerStatefulWidget {
  const AdminDataIOScreen({super.key});

  @override
  ConsumerState<AdminDataIOScreen> createState() => _AdminDataIOScreenState();
}

class _AdminDataIOScreenState extends ConsumerState<AdminDataIOScreen> {
  @override
  Widget build(BuildContext context) {
    final realm = ref.read(realmServiceProvider).realm;

    return Scaffold(
      appBar: AppBar(title: const Text('Data Management')),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.upload),
            title: const Text('Export Teams to CSV'),
            onTap: () => _exportTeams(realm),
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Import Players from CSV'),
            onTap: () => _importPlayers(),
          ),
        ],
      ),
    );
  }

  Future<void> _exportTeams(Realm realm) async {
    try {
      final teams = realm.all<Team>();
      final csvData = const ListToCsvConverter().convert([
        ['Team Code', 'Team Name', 'Player Count'],
        ...teams.map((t) => [t.teamCode, t.teamName, t.players.length])
      ]);

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/teams_export.csv');
      await file.writeAsString(csvData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Exported to ${file.path}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    }
  }

  Future<void> _importPlayers() async {
    // Implement your CSV import logic here
  }
}

class Team {
  String? get teamName => null;
}

extension on Object? {
  get teamCode => null;

  get teamName => null;

  get players => null;
}