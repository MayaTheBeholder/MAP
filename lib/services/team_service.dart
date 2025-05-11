import 'package:realm/realm.dart';
import '../models/team_model.dart';

class TeamService {
  final Realm realm;

  TeamService(this.realm);

  List<Team> getAllTeams() {
    try {
      return realm.query<Team>('TRUEPREDICATE SORT(teamName ASC)').toList();
    } catch (e) {
      throw Exception('Failed to get teams: $e');
    }
  }

  Team? getTeamById(String teamCode) {
    try {
      return realm.find<Team>(teamCode);
    } catch (e) {
      throw Exception('Failed to get team: $e');
    }
  }

  Future<Team> addTeam(Team team) async {
    try {
      realm.write(() {
        realm.add(team);
      });
      return team;
    } catch (e) {
      throw Exception('Failed to add team: $e');
    }
  }

  Future<void> updateTeam(Team updatedTeam) async {
    try {
      realm.write(() {
        realm.add(updatedTeam, update: true);
      });
    } catch (e) {
      throw Exception('Failed to update team: $e');
    }
  }

  Future<void> deleteTeam(String teamCode) async {
    try {
      final team = realm.find<Team>(teamCode);
      if (team != null) {
        realm.write(() => realm.delete(team));
      }
    } catch (e) {
      throw Exception('Failed to delete team: $e');
    }
  }

  List<Map<String, dynamic>> getTeamBasicInfo() {
    try {
      return realm.query<Team>('TRUEPREDICATE SORT(teamName ASC)')
          .map((t) => {
        'code': t.teamCode,
        'name': t.teamName,
        'logo': t.teamLogo,
        'playerCount': t.players.length,
      })
          .toList();
    } catch (e) {
      throw Exception('Failed to get team info: $e');
    }
  }
}