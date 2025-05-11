import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/player_service.dart';

class PlayerViewScreen extends ConsumerWidget {
  const PlayerViewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(playersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Players')),
      body: playersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (players) => ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, index) {
            final player = players[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(player.playerPicture ?? ''),
              ),
              title: Text(player.playerName),
              subtitle: Text('${player.position} • ${player.team?.teamName ?? 'No Team'}'),
              onTap: () {
                // Navigate to player detail
              },
            );
          },
        ),
      ),
    );
  }
}

final playersProvider = FutureProvider.autoDispose<List<Player>>((ref) {
  return ref.read(playerServiceProvider).getAllPlayers();
});