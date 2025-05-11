// lib/data/models/user_models/user_base_model.dart
part 'user_base_model.g.dart';

@RealmModel()
class _UserBase {
  @PrimaryKey()
  late String userCode;
  late String username;
  late String email;
  late String password;
  late String? profilePictureUrl;
  late DateTime createdAt = DateTime.now();
}