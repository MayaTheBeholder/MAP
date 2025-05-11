import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

import '../../data/models/team_model.dart';
import '../../data/models/player_model.dart';
import '../../core/providers.dart';
import '../admin/admin_data_ioadmin_data_io.dart';

class PlayerTransferScreen extends ConsumerStatefulWidget {
  final String playerCode;
  const PlayerTransferScreen({required this.playerCode, super.key});

  @override
  ConsumerState<PlayerTransferScreen> createState() => _PlayerTransferScreenState();
}

class _PlayerTransferScreenState extends ConsumerState<PlayerTransferScreen> {
  Team? _selectedTeam;

  @override
  Widget build(BuildContext context) {
    final realm = ref.read(realmServiceProvider).realm;
    final player = realm.find<Player>(widget.playerCode);
    final teams = realm.all<Team>();

    return Scaffold(
      appBar: AppBar(title: const Text('Transfer Player')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Transfer ${player?.name ?? ''}'),
            const SizedBox(height: 20),
            DropdownButtonFormField<Team>(
              value: _selectedTeam,
              items: teams.map((team) => DropdownMenuItem(
                value: team,
                child: Text(team.teamName),
              )).toList(),
              onChanged: (team) => setState(() => _selectedTeam = team),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedTeam != null ? () => _transferPlayer(player) : null,
              child: const Text('Confirm Transfer'),
            ),
          ],
        ),
      ),
    );
  }

  void _transferPlayer(Player? player) {
    if (player == null || _selectedTeam == null) return;

    final realm = ref.read(realmServiceProvider).realm;
    realm.write(() {
      player.team = _selectedTeam;
    });
    Navigator.pop(context);
  }
}