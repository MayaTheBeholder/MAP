import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';
import '../services/realm_service.dart';
import '../services/auth_service.dart';
import '../services/team_service.dart';
import '../services/player_service.dart';
import '../services/post_service.dart';
import '../services/comment_service.dart';

final realmServiceProvider = Provider<RealmService>((ref) {
  return RealmService();
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.read(realmServiceProvider));
});

final teamServiceProvider = Provider<TeamService>((ref) {
  return TeamService(ref.read(realmServiceProvider));
});

final playerServiceProvider = Provider<PlayerService>((ref) {
  final realm = ref.read(realmServiceProvider).realm;
  return PlayerService(realm);
});

final postServiceProvider = Provider<PostService>((ref) {
  final realm = ref.read(realmServiceProvider).realm;
  return PostService(realm);
});

final commentServiceProvider = Provider<CommentService>((ref) {
  final realm = ref.read(realmServiceProvider).realm;
  return CommentService(realm);
});

final currentUserProvider = FutureProvider<UserBase?>((ref) async {
  return await ref.read(authServiceProvider).getCurrentUser();
});

final upcomingEventsProvider = FutureProvider<List<EventAnnouncement>>((ref) {
  final realm = ref.read(realmServiceProvider).realm;
  return realm.all<EventAnnouncement>().toList();
});

final recentPostsProvider = FutureProvider<List<UpdatePost>>((ref) {
  final realm = ref.read(realmServiceProvider).realm;
  return realm.query<UpdatePost>('TRUEPREDICATE SORT(postDate DESC) LIMIT(10)');
});

final eventServiceProvider = Provider<EventService>((ref) {
  final realm = ref.read(realmServiceProvider).realm;
  return EventService(realm);
});