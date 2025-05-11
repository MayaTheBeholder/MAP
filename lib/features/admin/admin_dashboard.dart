import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:namibia_hockey_union/data/models/team_model.dart';
import 'package:namibia_hockey_union/data/services/team_service.dart';
import 'package:namibia_hockey_union/features/shared/team_card.dart';

import '../../core/providers.dart';

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsAsync = ref.watch(teamsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/admin/team-management'),
          ),
        ],
      ),
      body: teamsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (teams) => ListView.builder(
          itemCount: teams.length,
          itemBuilder: (context, index) => TeamCard(
            team: teams[index],
            onTap: () => context.push('/admin/team-detail/${teams[index].teamCode}'),
          ),
        ),
      ),
    );
  }
}

final teamsProvider = FutureProvider.autoDispose<List<Team>>((ref) {
  return ref.read(teamServiceProvider).getAllTeams();
});