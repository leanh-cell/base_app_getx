// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StaffAdapter extends TypeAdapter<Staff> {
  @override
  final int typeId = 4;

  @override
  Staff read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Staff(
      id: fields[0] as int?,
      branchId: fields[1] as int?,
      username: fields[2] as String?,
      areaCode: fields[3] as String?,
      phoneNumber: fields[4] as String?,
      phoneVerifiedAt: fields[5] as String?,
      email: fields[6] as String?,
      emailVerifiedAt: fields[7] as String?,
      name: fields[8] as String?,
      password: fields[9] as String?,
      sex: fields[12] as int?,
      totalDevice: fields[13] as int?,
      online: fields[10] as bool?,
      address: fields[14] as String?,
      isSale: fields[11] as bool?,
      dateOfBirth: fields[15] as DateTime?,
      avatarImage: fields[16] as String?,
      salaryOneHour: fields[17] as double?,
      idDecentralization: fields[18] as int?,
      createdAt: fields[19] as DateTime?,
      updatedAt: fields[20] as DateTime?,
      totalCustomer: fields[21] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Staff obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.branchId)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.areaCode)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.phoneVerifiedAt)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.emailVerifiedAt)
      ..writeByte(8)
      ..write(obj.name)
      ..writeByte(9)
      ..write(obj.password)
      ..writeByte(10)
      ..write(obj.online)
      ..writeByte(11)
      ..write(obj.isSale)
      ..writeByte(12)
      ..write(obj.sex)
      ..writeByte(13)
      ..write(obj.totalDevice)
      ..writeByte(14)
      ..write(obj.address)
      ..writeByte(15)
      ..write(obj.dateOfBirth)
      ..writeByte(16)
      ..write(obj.avatarImage)
      ..writeByte(17)
      ..write(obj.salaryOneHour)
      ..writeByte(18)
      ..write(obj.idDecentralization)
      ..writeByte(19)
      ..write(obj.createdAt)
      ..writeByte(20)
      ..write(obj.updatedAt)
      ..writeByte(21)
      ..write(obj.totalCustomer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StaffAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
