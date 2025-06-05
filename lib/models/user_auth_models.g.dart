// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAuthModelsAdapter extends TypeAdapter<UserAuthModels> {
  @override
  final int typeId = 0;

  @override
  UserAuthModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserAuthModels(
      isAuthenticated: fields[0] as bool?,
      id: fields[1] as String,
      email: fields[2] as String?,
      passwordHash: fields[3] as String?,
      createdAt: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, UserAuthModels obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.isAuthenticated)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.passwordHash)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAuthModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
