// GENERATED CODE - DO NOT MODIFY BY HAND
/*
part of 'post_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostAdapter extends TypeAdapter<Post> {
  @override
  final int typeId = 1;

  @override
  Post read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Post(
      id: fields[0] as String,
      title: fields[1] as String,
      link: fields[2] as String?,
      description: fields[3] as String?,
      communityName: fields[4] as String,
      communityProfilePic: fields[5] as String,
      upvotes: (fields[6] as List).cast<String>(),
      downvotes: (fields[7] as List).cast<String>(),
      commentCount: fields[8] as int,
      username: fields[9] as String,
      uid: fields[10] as String,
      type: fields[11] as String,
      createdAt: fields[12] as DateTime,
      awards: (fields[13] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Post obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.link)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.communityName)
      ..writeByte(5)
      ..write(obj.communityProfilePic)
      ..writeByte(6)
      ..write(obj.upvotes)
      ..writeByte(7)
      ..write(obj.downvotes)
      ..writeByte(8)
      ..write(obj.commentCount)
      ..writeByte(9)
      ..write(obj.username)
      ..writeByte(10)
      ..write(obj.uid)
      ..writeByte(11)
      ..write(obj.type)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.awards);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
*/
