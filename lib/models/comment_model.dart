// lib/data/models/comment_model.dart
import 'package:realm/realm.dart';

part 'comment_model.realm.dart';

@RealmModel()
class _Comment {
  @PrimaryKey()
  late String commentCode; // Format: C001
  late String? eventCode; // E101 if commenting on event
  late String? postCode; // P101 if commenting on post
  late String text;
  late int likeCount;
  late String authorUsername; // Denormalized for quick display
}