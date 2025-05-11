// team_model.dart
part 'team_model.realm.dart';

@RealmModel()
class _Team {
  @PrimaryKey()
  late String teamCode;
  late String teamName;
  late String? teamLogoPath;
  late List<_Player> players;
  late List<_UpcomingEvent> upcomingEvents;
  late List<_PastEvent> pastEventScores;
}

// player_model.dart
part 'player_model.realm.dart';

@RealmModel()
class _Player {
  @PrimaryKey()
  late String playerCode;
  late String playerName;
  late String teamName;
  late String? playerPicturePath;
  late DateTime birthdate;
  late int age;
  late String position;
}