import 'package:realm/realm.dart';

part 'update_post_model.g.dart';

@RealmModel()
class _UpdatePost {
  @PrimaryKey()
  late String code;
  late String title;
  late String text;
  late String picture;
  late int likeCount;
  late int commentCount;
}
