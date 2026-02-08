import 'package:pool_shark/model/user/user.dart';
import 'package:pool_shark/utils/check_length.dart';
import 'package:pool_shark/model/constants/name_lengths.dart';

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

    checkInvariants();
  }

  // Class invariants

  void checkInvariants() {
    _checkUsername(_username);
    _checkEmail(_email);
    _checkPasswordHash(_passwordHash);
  }

  // Not a rigorous set of email checks, very basic
  void _checkEmail(String email) {
    CheckLength.checkLength(email, 'email', NameLengths.emailMin, NameLengths.emailMax);

    final parts = email.split('@');
    
    // check email contains one '@' symbol
    assert(parts.length == 2, 'email, $email, contains more than 1 @');

    String username = parts[0];
    String domain = parts[1];

    // Check domain and username are not empty
    assert(username.isNotEmpty, 'Username of email cannot be empty');
    assert(domain.isNotEmpty, ' Domain of email cannot be empty');

    // Check domain conatins 1 '.' and is not at beginning or end of domian 
    assert(domain.contains('.'), 'Domain must contain a dot');
    assert(!domain.startsWith('.'), 'Domain cannot start with a dot');
    assert(!domain.endsWith('.'), 'Domain cannot end with a dot');

    final domainParts = domain.split('.');

    // Check tld is not too short
    assert(domainParts.last.length >= 2, 'Top-level domain is too short');

  }

  void _checkUsername(String username) {
    CheckLength.checkLength(username, 'username', NameLengths.usernameMin, NameLengths.usernameMax);
  } 

  void _checkPasswordHash(String passwordHash) {
    assert(passwordHash.isNotEmpty, 'password hash cannot be empty');
    // TODO: Add hash length once a hash is picked
  }


    // Getters

  String get username => _username;
  String get passwordHash => _passwordHash;
  String get email => _email;


  // Setters

  set username(String username) {
    _checkUsername(username);
    _username = username;
  }

  set passwordHash(String passwordHash) {
      _checkPasswordHash(passwordHash);
      _passwordHash = passwordHash;
  }
    
  set email(String email) {
    _checkEmail(email);
    _email = email;
  }
 
}
