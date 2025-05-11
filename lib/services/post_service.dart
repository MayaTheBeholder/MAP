import 'package:realm/realm.dart';
import '../models/post_models/update_post_model.dart';
import '../models/post_models/event_announcement_model.dart';
import '../models/post_models/past_event_model.dart';

class PostService {
  final Realm realm;

  PostService(this.realm);

  // For UpdatePosts (general announcements)
  List<UpdatePost> getAllPosts() {
    try {
      return realm.query<UpdatePost>('TRUEPREDICATE SORT(createdAt DESC)').toList();
    } catch (e) {
      throw Exception('Failed to get posts: $e');
    }
  }

  Future<UpdatePost> createPost(UpdatePost post) async {
    try {
      realm.write(() => realm.add(post));
      return post;
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  // For Event Announcements
  List<EventAnnouncement> getUpcomingEvents() {
    try {
      return realm.query<EventAnnouncement>('eventDate >= \$0 SORT(eventDate ASC)',
          [DateTime.now()]).toList();
    } catch (e) {
      throw Exception('Failed to get events: $e');
    }
  }

  Future<EventAnnouncement> createEvent(EventAnnouncement event) async {
    try {
      realm.write(() => realm.add(event));
      return event;
    } catch (e) {
      throw Exception('Failed to create event: $e');
    }
  }

  // For Past Events
  List<PastEvent> getPastEvents() {
    try {
      return realm.query<PastEvent>('eventDate < \$0 SORT(eventDate DESC)',
          [DateTime.now()]).toList();
    } catch (e) {
      throw Exception('Failed to get past events: $e');
    }
  }

  Future<PastEvent> addPastEvent(PastEvent event) async {
    try {
      realm.write(() => realm.add(event));
      return event;
    } catch (e) {
      throw Exception('Failed to add past event: $e');
    }
  }
}