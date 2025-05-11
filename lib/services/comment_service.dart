import 'package:realm/realm.dart';
import '../models/comment_model.dart';
import '../models/user_models/user_base_model.dart';

class CommentService {
  final Realm realm;

  CommentService(this.realm);

  List<Comment> getCommentsForPost(String postCode) {
    try {
      return realm.query<Comment>('postCode == \$0 SORT(createdAt DESC)',
          [postCode]).toList();
    } catch (e) {
      throw Exception('Failed to get comments: $e');
    }
  }

  List<Comment> getCommentsForEvent(String eventCode) {
    try {
      return realm.query<Comment>('eventCode == \$0 SORT(createdAt DESC)',
          [eventCode]).toList();
    } catch (e) {
      throw Exception('Failed to get event comments: $e');
    }
  }

  Future<Comment> addComment(Comment comment) async {
    try {
      realm.write(() => realm.add(comment));
      return comment;
    } catch (e) {
      throw Exception('Failed to add comment: $e');
    }
  }

  Future<void> deleteComment(String commentCode) async {
    try {
      final comment = realm.find<Comment>(commentCode);
      if (comment != null) {
        realm.write(() => realm.delete(comment));
      }
    } catch (e) {
      throw Exception('Failed to delete comment: $e');
    }
  }

  Future<void> toggleLike(Comment comment, UserBase user) async {
    try {
      realm.write(() {
        if (comment.likedBy.contains(user.userCode)) {
          comment.likedBy.remove(user.userCode);
        } else {
          comment.likedBy.add(user.userCode);
        }
      });
    } catch (e) {
      throw Exception('Failed to toggle like: $e');
    }
  }
}