import 'package:realm/realm.dart';
import '../models/user_models/user_base_model.dart';

class AuthService {
  final RealmService _realmService;

  AuthService(this._realmService);

  Future<UserBase?> login(String username, String password) async {
    try {
      return _realmService.realm.query<UserBase>(
        'username == \$0 AND password == \$1',
        [username, password],
      ).firstOrNull;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<UserBase?> getCurrentUser() async {
    try {
      return _realmService.realm.all<UserBase>().firstOrNull;
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  Future<void> logout() async {
    await _realmService.close();
  }

  Future<UserBase> signup(UserBase user, String password) async {
    try {
      _realmService.realm.write(() {
        _realmService.realm.add(user);
      });
      return user;
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }

  Future<void> deleteAccount(String userId) async {
    try {
      final user = _realmService.realm.find<UserBase>(userId);
      if (user != null) {
        _realmService.realm.write(() => _realmService.realm.delete(user));
      }
    } catch (e) {
      throw Exception('Account deletion failed: $e');
    }
  }
}