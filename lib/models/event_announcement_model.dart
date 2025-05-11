import 'package:realm/realm.dart';

part 'event_announcement_model.g.dart';

@RealmModel()
class _EventAnnouncement {
  @PrimaryKey()
  late String code;
  late String title;
  late String text;
  late String picture;
  late DateTime dateTime;
  late String location;
  late List<String> teams;
  late List<String> players;
  late int likeCount;
  late int commentCount;
}
