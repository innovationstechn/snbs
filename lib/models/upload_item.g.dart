// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UploadItemAdapter extends TypeAdapter<UploadItem> {
  @override
  final int typeId = 1;

  @override
  UploadItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UploadItem(
      checksum: fields[1] as String,
      data: fields[0] as String,
      id: fields[2] as String,
      url: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UploadItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.checksum)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UploadItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadItem _$UploadItemFromJson(Map<String, dynamic> json) => UploadItem(
      checksum: json['checksum'] as String,
      data: json['data'] as String,
      id: json['id'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$UploadItemToJson(UploadItem instance) =>
    <String, dynamic>{
      'data': instance.data,
      'checksum': instance.checksum,
      'id': instance.id,
      'url': instance.url,
    };
