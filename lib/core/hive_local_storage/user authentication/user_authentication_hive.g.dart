// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_authentication_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAuthenticationAdapter extends TypeAdapter<UserAuthentication> {
  @override
  final int typeId = 1;

  @override
  UserAuthentication read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserAuthentication(
      password: fields[0] as String,
      email: fields[1] as String,
      status: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserAuthentication obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.password)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAuthenticationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
