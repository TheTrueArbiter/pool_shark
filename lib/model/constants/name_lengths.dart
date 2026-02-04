final class NameLengths {
  static const firstNameMin = 1;
  static const firstNameMax = 32;

  static const lastNameMin = 0;
  static const lastNameMax = 32;
  
  static const nicknameMin = 0;
  static const nicknameMax = 32;
  
  static const displayNameMin = 1;
  static const displayNameMax = firstNameMax + lastNameMax + nicknameMax;
}
