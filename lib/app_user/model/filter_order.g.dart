// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilterOrderAdapter extends TypeAdapter<FilterOrder> {
  @override
  final int typeId = 2;

  @override
  FilterOrder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilterOrder(
      dateFrom: fields[0] as DateTime?,
      dateTo: fields[1] as DateTime?,
      listSource: (fields[2] as List?)?.cast<int>(),
      listBranch: (fields[3] as List?)?.cast<Branch>(),
      listOrderStt: (fields[4] as List?)?.cast<String>(),
      listPaymentStt: (fields[5] as List?)?.cast<String>(),
      name: fields[6] as String?,
      staff: fields[7] as Staff?,
    );
  }

  @override
  void write(BinaryWriter writer, FilterOrder obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.dateFrom)
      ..writeByte(1)
      ..write(obj.dateTo)
      ..writeByte(2)
      ..write(obj.listSource)
      ..writeByte(3)
      ..write(obj.listBranch)
      ..writeByte(4)
      ..write(obj.listOrderStt)
      ..writeByte(5)
      ..write(obj.listPaymentStt)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.staff);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
