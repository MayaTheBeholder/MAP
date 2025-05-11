import 'package:realm/realm.dart';

part 'past_event_model.g.dart';

@RealmModel()
class _PastEvent {
  @PrimaryKey()
  late String code;
  late String title;
  late String text;
  late DateTime dateTime;
  late String location;
  late List<String> teams;
  late List<String> players;
  late String score;
  late String winningTeam;
  late String mvp;
  late int likeCount;
  late int commentCount;
}
