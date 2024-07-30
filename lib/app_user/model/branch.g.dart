// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BranchAdapter extends TypeAdapter<Branch> {
  @override
  final int typeId = 3;

  @override
  Branch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Branch(
      id: fields[0] as int?,
      storeId: fields[1] as int?,
      name: fields[2] as String?,
      addressDetail: fields[3] as String?,
      province: fields[4] as int?,
      district: fields[5] as int?,
      wards: fields[6] as int?,
      provinceName: fields[7] as String?,
      districtName: fields[8] as String?,
      wardsName: fields[9] as String?,
      branchCode: fields[10] as String?,
      postcode: fields[11] as String?,
      email: fields[12] as String?,
      phone: fields[13] as String?,
      isDefault: fields[14] as bool?,
      isDefaultOrderOnline: fields[17] as bool?,
      createdAt: fields[15] as DateTime?,
      updatedAt: fields[16] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Branch obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.storeId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.addressDetail)
      ..writeByte(4)
      ..write(obj.province)
      ..writeByte(5)
      ..write(obj.district)
      ..writeByte(6)
      ..write(obj.wards)
      ..writeByte(7)
      ..write(obj.provinceName)
      ..writeByte(8)
      ..write(obj.districtName)
      ..writeByte(9)
      ..write(obj.wardsName)
      ..writeByte(10)
      ..write(obj.branchCode)
      ..writeByte(11)
      ..write(obj.postcode)
      ..writeByte(12)
      ..write(obj.email)
      ..writeByte(13)
      ..write(obj.phone)
      ..writeByte(14)
      ..write(obj.isDefault)
      ..writeByte(15)
      ..write(obj.createdAt)
      ..writeByte(16)
      ..write(obj.updatedAt)
      ..writeByte(17)
      ..write(obj.isDefaultOrderOnline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BranchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
