import 'package:pool_shark/model/user/user.dart';

final class OnlineUser extends User {

  String _username;
  String _email;
  String _passwordHash;

  OnlineUser({
    required super.firstName,
    required super.id,
    required super.displayName,
    required String email,
    required String username,
    required String passwordHash,
    super.nickname,
    super.lastName

  })  : 
      _username = username,
      _email = email,
      _passwordHash = passwordHash {

    checkOnlineUser(
      username: _username,
      email: _email,
      passwordHash: _passwordHash
    );
  }

    // Getters

  String get username => _username;
  String get passwordHash => _passwordHash;
  String get email => _email;


  // Setters

  set username(String username) {
    checkUsername(username);
    _username = username;
  }

  set passwordHash(String passwordHash) {
      checkPasswordHash(passwordHash);
      _passwordHash = passwordHash;
  }
    
  set email(String email) {
    checkEmail(email);
    _email = email;
  }
 
}
