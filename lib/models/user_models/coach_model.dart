// lib/data/models/user_models/coach_model.dart
import 'package:realm/realm.dart';
import 'user_base_model.dart';

part 'coach_model.realm.dart';

@RealmModel()
class _CoachUser extends _UserBase {
  // Coach-specific relationships
  late List<_Team> managedTeams;
}