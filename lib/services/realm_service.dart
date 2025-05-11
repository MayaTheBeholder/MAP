import 'package:realm/realm.dart';
import '../models/team_model.dart';
import '../models/player_model.dart';
import '../models/comment_model.dart';
import '../models/user_models/user_base_model.dart';
import '../models/post_models/update_post_model.dart';
import '../models/post_models/event_announcement_model.dart';
import '../models/post_models/past_event_model.dart';

class RealmService {
  late final Realm realm;
  late final App app;

  static const String _appId = 'your-atlas-app-id-here';

  Future<void> initialize() async {
    try {
      app = App(AppConfiguration(_appId));
      final user = await app.logIn(Credentials.anonymous());

      final config = Configuration.flexibleSync(
        user,
        [
          Team.schema,
          Player.schema,
          Comment.schema,
          UserBase.schema,
          Admin.schema,
          Coach.schema,
          GeneralUser.schema,
          UpdatePost.schema,
          EventAnnouncement.schema,
          PastEvent.schema,
        ],
        path: 'nhockey.realm',
      );

      realm = Realm(config);
      await _initializeSubscriptions();
    } catch (e) {
      throw Exception('Realm initialization failed: $e');
    }
  }

  Future<void> _initializeSubscriptions() async {
    try {
      realm.subscriptions.update((mutableSubscriptions) {
        mutableSubscriptions.add(realm.all<Team>());
        mutableSubscriptions.add(realm.all<Player>());
        mutableSubscriptions.add(realm.all<UserBase>());
        mutableSubscriptions.add(realm.all<UpdatePost>());
        mutableSubscriptions.add(realm.all<EventAnnouncement>());
        mutableSubscriptions.add(realm.all<PastEvent>());
      });
      await realm.subscriptions.waitForSynchronization();
    } catch (e) {
      throw Exception('Subscription initialization failed: $e');
    }
  }

  Future<void> syncChanges() async {
    try {
      await realm.syncSession.waitForUpload();
      await realm.syncSession.waitForDownload();
    } catch (e) {
      throw Exception('Sync failed: $e');
    }
  }

  void close() {
    if (realm.isClosed) return;
    realm.close();
    app.currentUser?.logOut();
  }
}