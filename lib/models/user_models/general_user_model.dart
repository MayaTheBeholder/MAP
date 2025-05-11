// lib/data/models/user_models/general_user_model.dart
import 'package:realm/realm.dart';
import 'user_base_model.dart';

part 'general_user_model.realm.dart';

@RealmModel()
class _GeneralUser extends _UserBase {
  late DateTime birthdate;
  late int age;
  late List<_Team> followedTeams;
}