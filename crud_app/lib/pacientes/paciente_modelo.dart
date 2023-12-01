import 'package:crud_app/usuario/usuario_model.dart';
import 'package:hive/hive.dart';

part 'paciente_modelo.g.dart';

@HiveType(typeId: 0)
class PacienteModelo extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String nome;

  @HiveField(2)
  String email;

  @HiveField(3)
  DateTime dataNascimento;

  @HiveField(4)
  String telefone;

  @HiveField(5)
  String endereco;

  @HiveField(6) 
  UsuarioModelo? usuario;

  PacienteModelo({
    this.id,
    required this.nome,
    required this.email,
    required this.dataNascimento,
    required this.telefone,
    required this.endereco,
  });

  @override
  int get hashCode => email.hashCode;


  @override
  bool operator ==(Object other) {
    if (PacienteModelo != other.runtimeType) {
      return false;
    }
    other as PacienteModelo;
    return id == other.id;
  }

  factory PacienteModelo.fromJson(Map<String, dynamic> json) => PacienteModelo(
        id: json["id"],
        nome: json["nome"],
        email: json["email"],
        dataNascimento: DateTime.parse(json["dataNascimento"]),
        telefone: json["telefone"],
        endereco: json["endereco"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "email": email,
        "dataNascimento": dataNascimento.toIso8601String(),
        "telefone": telefone,
        "endereco": endereco,
      };
}