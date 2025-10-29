import 'package:atlas_digital_fmabc/models/users/user.dart';

/// Modelo de dados das turmas.
class Class {
  Class({
    required String id,
    required String name,
    required User teacher,
    String? imageId,
  }) : _id = id,
       _name = name,
       _teacher = teacher,
       _imageId = imageId;

  /// `_id` no banco de dados.
  final String _id;
  String get id => _id;

  /// Nome da turma.
  final String _name;
  String get name => _name;

  /// Usuário responsável pela turma.
  final User _teacher;
  User get teacher => _teacher;

  /// ID da imagem da turma.
  final String? _imageId;
  String? get imageId => _imageId;
}
