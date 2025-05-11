// lib/data/models/user_models/admin_model.dart
import 'package:realm/realm.dart';

part 'admin_model.realm.dart';

@RealmModel()
class _AdminUser extends _UserBase {
  // No additional fields needed beyond base
}

class _UserBase {
}