// lib/data/models/player_model.dart
import 'package:realm/realm.dart';

part 'player_model.realm.dart';

@RealmModel()
class _Player {
  @PrimaryKey()
  late String playerCode; // Format: P001
  late String playerName;
  late String teamName; // Denormalized for quick access
  late String? playerPicturePath;
  late DateTime birthdate;
  late int age;
  late String position;
}