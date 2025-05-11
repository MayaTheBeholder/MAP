import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namibia_hockey_union/data/models/team_model.dart';
import 'package:namibia_hockey_union/data/models/post_models/past_event_model.dart';

// Ensure that the PastEvent class is defined in the imported file.
import 'package:namibia_hockey_union/data/services/realm_service.dart';

import '../../core/providers.dart';

class EventEditScreen extends ConsumerStatefulWidget {
  final String eventCode;

  const EventEditScreen({super.key, required this.eventCode});

  @override
  ConsumerState<EventEditScreen> createState() => _EventEditScreenState();
}

class _EventEditScreenState extends ConsumerState<EventEditScreen> {
  @override
  Widget build(BuildContext context) {
    final realm = ref.read(realmServiceProvider).realm;
    final event = realm.find<PastEvent>(widget.eventCode);

    if (event == null) {
      return const Scaffold(body: Center(child: Text('Event not found')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Event')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              DropdownButtonFormField<Team>(
                value: event.winningTeam,
                items:
                    event.teams
                        .map(
                          (team) => DropdownMenuItem(
                            value: team,
                            child: Text(team.teamName),
                          ),
                        )
                        .toList(),
                onChanged: (team) {
                  if (team != null) {
                    realm.write(() => event.winningTeam = team);
                  }
                },
                decoration: const InputDecoration(labelText: 'Winning Team'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: event.score,
                decoration: const InputDecoration(labelText: 'Score'),
                onChanged:
                    (score) => realm.write(() => event.score = score ?? ''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
