// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paciente_modelo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PacienteModeloAdapter extends TypeAdapter<PacienteModelo> {
  @override
  final int typeId = 0;

  @override
  PacienteModelo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PacienteModelo(
      id: fields[0] as int?,
      nome: fields[1] as String,
      email: fields[2] as String,
      dataNascimento: fields[3] as DateTime,
      telefone: fields[4] as String,
      endereco: fields[5] as String,
    )..usuario = fields[6] as UsuarioModelo?;
  }

  @override
  void write(BinaryWriter writer, PacienteModelo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nome)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.dataNascimento)
      ..writeByte(4)
      ..write(obj.telefone)
      ..writeByte(5)
      ..write(obj.endereco)
      ..writeByte(6)
      ..write(obj.usuario);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PacienteModeloAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
