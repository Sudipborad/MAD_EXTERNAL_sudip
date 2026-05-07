// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NutritionGoalAdapter extends TypeAdapter<NutritionGoal> {
  @override
  final int typeId = 2;

  @override
  NutritionGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NutritionGoal(
      calorieGoal: fields[0] as int,
      proteinGoal: fields[1] as int,
      carbsGoal: fields[2] as int,
      fatsGoal: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NutritionGoal obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.calorieGoal)
      ..writeByte(1)
      ..write(obj.proteinGoal)
      ..writeByte(2)
      ..write(obj.carbsGoal)
      ..writeByte(3)
      ..write(obj.fatsGoal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NutritionGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
