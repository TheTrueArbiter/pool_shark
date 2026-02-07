/* 

local_user.dart

purpose: hold data and logic for local users 

Notes:
*/

import 'package:pool_shark/model/user/user.dart';

final class LocalUser extends User {

  LocalUser({
    required super.id,
    required super.firstName, 
    required super.displayName,
    String? lastName, 
    String? nickname,
  });
}
