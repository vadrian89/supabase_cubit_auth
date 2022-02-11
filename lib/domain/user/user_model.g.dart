// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      lastName: json['last_name'] as String?,
      firstName: json['first_name'] as String?,
      createdAt: dateTimeFromJson(json['updated_at']),
      updatedAt: dateTimeFromJson(json['created_at']),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'last_name': instance.lastName,
      'first_name': instance.firstName,
      'updated_at': dateTimeToJson(instance.createdAt),
      'created_at': dateTimeToJson(instance.updatedAt),
    };
