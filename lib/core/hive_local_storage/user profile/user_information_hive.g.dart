// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_information_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      name: fields[0] as String,
      imgUrl: fields[1] as String,
      gender: fields[2] as String,
      ageGroup: fields[3] as String,
      primaryHealthGoal: fields[4] as String,
      fitnessGoal: fields[5] as String,
      additionalNotes: fields[6] as String,
      fitnessLevel: fields[7] as String,
      exerciseStatus: fields[8] as String,
      exerciseFrequency: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imgUrl)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.ageGroup)
      ..writeByte(4)
      ..write(obj.primaryHealthGoal)
      ..writeByte(5)
      ..write(obj.fitnessGoal)
      ..writeByte(6)
      ..write(obj.additionalNotes)
      ..writeByte(7)
      ..write(obj.fitnessLevel)
      ..writeByte(8)
      ..write(obj.exerciseStatus)
      ..writeByte(9)
      ..write(obj.exerciseFrequency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
