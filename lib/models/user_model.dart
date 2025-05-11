// admin_model.dart
import 'package:realm/realm.dart';

part 'admin_model.realm.dart';


@RealmModel()
class _AdminUser extends _UserBase {
  // Additional admin-specific fields if needed
}

// coach_model.dart
part 'coach_model.realm.dart';

@RealmModel()
class _CoachUser extends _UserBase {
  // Coach-specific fields
}

// general_user_model.dart
part 'general_user_model.realm.dart';

@RealmModel()
class _GeneralUser extends _UserBase {
  late DateTime birthdate;
  late int age;
}