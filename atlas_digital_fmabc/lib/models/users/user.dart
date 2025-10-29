/// Tipo de usuário (professor ou admin).
enum UserType { teacher, admin }

/// Modelo de dados para usuários (professores e administradores).
class User {
  // Construtor
  User({
    required String id,
    required String name,
    required String email,
    required String password,
    UserType type = UserType.teacher,
  }) : _id = id,
       _name = name,
       _email = email,
       _password = password,
       _type = type;

  /// `_id` no banco de dados.
  final String _id;
  String get id => _id;

  /// Nome do usuário.
  final String _name;
  String get name => _name;

  /// E-mail do usuário.
  final String _email;
  String get email => _email;

  /// Hash da senha do usuário.
  final String _password;
  String get password => _password;

  /// Tipo de usuário (professor ou admin).
  final UserType _type;
  UserType get type => _type;
}
