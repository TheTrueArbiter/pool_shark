import 'package:pool_shark/model/constants/name_lengths.dart';

mixin UserValidation {

  // Class invariants for User
  void checkUser({
    required String id,
    required String firstName,
    required String lastName,
    required String nickname,
    required String displayName,
  }) {
    checkFirstName(firstName);
    checkLastName(lastName);
    checkNickname(nickname);
    checkDisplayName(displayName);
  }

  // Class invariants for OnlineUser
  void checkOnlineUser({
    required String username,
    required String email,
    required String passwordHash
  }) {
    checkUsername(username);
    checkEmail(email);
    checkPasswordHash(passwordHash);
  }

void _checkLength(String value, String varName, int min, int max) {
    value = value.trim();
    assert(
      value.length >= min && value.length <= max,
      '$varName length is not valid. Expected $min-$max, got ${value.length} ($value)',
    );
  }

  void checkFirstName(String firstName) =>
      _checkLength(firstName, 'firstName', NameLengths.firstNameMin, NameLengths.firstNameMax);

  void checkLastName(String lastName) =>
      _checkLength(lastName, 'lastName', NameLengths.lastNameMin, NameLengths.lastNameMax);

  void checkNickname(String nickname) =>
      _checkLength(nickname, 'nickname', NameLengths.nicknameMin, NameLengths.nicknameMax);

  void checkDisplayName(String displayName) =>
      _checkLength(displayName, 'displayName', NameLengths.displayNameMin, NameLengths.displayNameMax);

  // Not a rigorous set of email checks, very basic
  void checkEmail(String email) {
    _checkLength(email, 'email', NameLengths.emailMin, NameLengths.emailMax);

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

  void checkUsername(String username) {
    _checkLength(username, 'username', NameLengths.usernameMin, NameLengths.usernameMax);
  } 

  void checkPasswordHash(String passwordHash) {
    assert(passwordHash.isNotEmpty, 'password hash cannot be empty');
    // TODO: Add hash length once a hash is picked
  }

  void checkId(String id) {
    // TODO: add ID invariants once a method has been chosen for ID's 
  }



 
}
