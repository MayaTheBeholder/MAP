// lib/data/models/post_models/update_post_model.dart
part 'update_post_model.realm.dart';

@RealmModel()
class _UpdatePost {
  @PrimaryKey()
  late String postCode; // Format: P101
  late String title;
  late String text;
  late String? picturePath;
  late int likeCount;
  late List<_Comment> comments;
}

// lib/data/models/post_models/event_announcement_model.dart
part 'event_announcement_model.realm.dart';

@RealmModel()
class _UpcomingEventAnnouncement {
  @PrimaryKey()
  late String eventCode; // Format: E102
  late String title;
  late String text;
  late String? picturePath;
  late DateTime eventTime;
  late String location;
  late List<_Team> teams;
  late List<_Player> players;
  late int likeCount;
  late List<_Comment> comments;
}

// lib/data/models/post_models/past_event_model.dart
part 'past_event_model.realm.dart';

@RealmModel()
class _PastEvent {
  @PrimaryKey()
  late String eventCode; // Format: E101
  // ... same fields as UpcomingEventAnnouncement
  late String? score;
  late String? winningTeam;
  late String? mvpPlayer;
}