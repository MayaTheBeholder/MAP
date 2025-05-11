import 'package:realm/realm.dart';
import '../models/player_model.dart';
import '../models/team_model.dart';

class PlayerService {
  final Realm realm;

  PlayerService(this.realm);

  List<Player> getAllPlayers() {
    try {
      return realm.query<Player>('TRUEPREDICATE SORT(playerName ASC)').toList();
    } catch (e) {
      throw Exception('Failed to get players: $e');
    }
  }

  Player? getPlayerById(String playerCode) {
    try {
      return realm.find<Player>(playerCode);
    } catch (e) {
      throw Exception('Failed to get player: $e');
    }
  }

  List<Player> getPlayersByTeam(String teamCode) {
    try {
      return realm.query<Player>('team.teamCode == \$0', [teamCode]).toList();
    } catch (e) {
      throw Exception('Failed to get team players: $e');
    }
  }

  Future<Player> addPlayer(Player player, {Team? team}) async {
    try {
      realm.write(() {
        if (team != null) {
          player.team = team;
        }
        realm.add(player);
      });
      return player;
    } catch (e) {
      throw Exception('Failed to add player: $e');
    }
  }

  Future<void> updatePlayer(Player updatedPlayer) async {
    try {
      realm.write(() {
        realm.add(updatedPlayer, update: true);
      });
    } catch (e) {
      throw Exception('Failed to update player: $e');
    }
  }

  Future<void> deletePlayer(String playerCode) async {
    try {
      final player = realm.find<Player>(playerCode);
      if (player != null) {
        realm.write(() => realm.delete(player));
      }
    } catch (e) {
      throw Exception('Failed to delete player: $e');
    }
  }
}
