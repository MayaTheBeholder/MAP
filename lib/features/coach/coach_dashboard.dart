import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:namibia_hockey_union/data/models/player_model.dart';
import 'package:namibia_hockey_union/data/models/team_model.dart';
import 'package:namibia_hockey_union/data/services/player_service.dart';
import 'package:namibia_hockey_union/data/services/team_service.dart';
import 'package:namibia_hockey_union/features/shared/player_card.dart';
import 'package:namibia_hockey_union/features/shared/team_card.dart';

class CoachDashboard extends ConsumerStatefulWidget {
  const CoachDashboard({super.key});

  @override
  ConsumerState<CoachDashboard> createState() => _CoachDashboardState();
}

class _CoachDashboardState extends ConsumerState<CoachDashboard> {
  @override
  Widget build(BuildContext context) {
    final teamsAsync = ref.watch(coachTeamsProvider);
    final playersAsync = ref.watch(coachPlayersProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Coach Dashboard'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.group), text: 'Teams'),
              Tab(icon: Icon(Icons.people), text: 'Players'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => context.push('/coach/team-create'),
              tooltip: 'Create New Team',
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _refreshData,
              tooltip: 'Refresh Data',
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: TabBarView(
            children: [
              // Teams Tab
              _buildTeamsTab(teamsAsync),
              // Players Tab
              _buildPlayersTab(playersAsync),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamsTab(AsyncValue<List<Team>> teamsAsync) {
    return teamsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error loading teams: ${error.toString()}'),
            TextButton(
              onPressed: _refreshData,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (teams) => teams.isEmpty
          ? const Center(child: Text('No teams found'))
          : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: teams.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TeamCard(
            team: teams[index],
            onTap: () => context.push('/coach/team/${teams[index].teamCode}'),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayersTab(AsyncValue<List<Player>> playersAsync) {
    return playersAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error loading players: ${error.toString()}'),
            TextButton(
              onPressed: _refreshData,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (players) => players.isEmpty
          ? const Center(child: Text('No players found'))
          : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: players.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: PlayerCard(
            player: players[index],
            onTap: () => context.push('/coach/player/${players[index].playerCode}'),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    ref.invalidate(coachTeamsProvider);
    ref.invalidate(coachPlayersProvider);
  }
}

// Custom providers for coach-specific data
final coachTeamsProvider = FutureProvider.autoDispose<List<Team>>((ref) {
  final teamService = ref.watch(teamServiceProvider);
  return teamService.getAllTeams();
});

final coachPlayersProvider = FutureProvider.autoDispose<List<Player>>((ref) {
  final playerService = ref.watch(playerServiceProvider);
  return playerService.getAllPlayers();
});