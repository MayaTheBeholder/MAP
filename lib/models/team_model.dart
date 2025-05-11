import 'package:realm/realm.dart';

part 'team_model.g.dart';

@RealmModel()
class _Team {
  @PrimaryKey()
  late String teamCode;
  late String teamName;
  late String? teamLogoPath;
  late List<Player> players;
  late List<EventAnnouncement> upcomingEvents;
  late List<PastEvent> pastEvents;
}