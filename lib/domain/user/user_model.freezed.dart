// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
class _$UserModelTearOff {
  const _$UserModelTearOff();

  _UserModel call(
      {String? id,
      String? email,
      @JsonKey(ignore: true)
          String? password,
      @JsonKey(name: "last_name")
          String? lastName,
      @JsonKey(name: "first_name")
          String? firstName,
      @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "updated_at")
          DateTime? createdAt,
      @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "created_at")
          DateTime? updatedAt}) {
    return _UserModel(
      id: id,
      email: email,
      password: password,
      lastName: lastName,
      firstName: firstName,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  UserModel fromJson(Map<String, Object?> json) {
    return UserModel.fromJson(json);
  }
}

/// @nodoc
const $UserModel = _$UserModelTearOff();

/// @nodoc
mixin _$UserModel {
  String? get id => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get password => throw _privateConstructorUsedError;
  @JsonKey(name: "last_name")
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: "first_name")
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "updated_at")
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "created_at")
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? email,
      @JsonKey(ignore: true)
          String? password,
      @JsonKey(name: "last_name")
          String? lastName,
      @JsonKey(name: "first_name")
          String? firstName,
      @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "updated_at")
          DateTime? createdAt,
      @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "created_at")
          DateTime? updatedAt});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  final UserModel _value;
  // ignore: unused_field
  final $Res Function(UserModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? lastName = freezed,
    Object? firstName = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(
          _UserModel value, $Res Function(_UserModel) then) =
      __$UserModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? email,
      @JsonKey(ignore: true)
          String? password,
      @JsonKey(name: "last_name")
          String? lastName,
      @JsonKey(name: "first_name")
          String? firstName,
      @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "updated_at")
          DateTime? createdAt,
      @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "created_at")
          DateTime? updatedAt});
}

/// @nodoc
class __$UserModelCopyWithImpl<$Res> extends _$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(_UserModel _value, $Res Function(_UserModel) _then)
      : super(_value, (v) => _then(v as _UserModel));

  @override
  _UserModel get _value => super._value as _UserModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? lastName = freezed,
    Object? firstName = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_UserModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel extends _UserModel {
  const _$_UserModel(
      {this.id,
      this.email,
      @JsonKey(ignore: true)
          this.password,
      @JsonKey(name: "last_name")
          this.lastName,
      @JsonKey(name: "first_name")
          this.firstName,
      @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "updated_at")
          this.createdAt,
      @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "created_at")
          this.updatedAt})
      : super._();

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String? id;
  @override
  final String? email;
  @override
  @JsonKey(ignore: true)
  final String? password;
  @override
  @JsonKey(name: "last_name")
  final String? lastName;
  @override
  @JsonKey(name: "first_name")
  final String? firstName;
  @override
  @JsonKey(
      fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "updated_at")
  final DateTime? createdAt;
  @override
  @JsonKey(
      fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "created_at")
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, password: $password, lastName: $lastName, firstName: $firstName, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, email, password, lastName,
      firstName, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  _$UserModelCopyWith<_UserModel> get copyWith =>
      __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(this);
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel(
      {String? id,
      String? email,
      @JsonKey(ignore: true)
          String? password,
      @JsonKey(name: "last_name")
          String? lastName,
      @JsonKey(name: "first_name")
          String? firstName,
      @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "updated_at")
          DateTime? createdAt,
      @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "created_at")
          DateTime? updatedAt}) = _$_UserModel;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String? get id;
  @override
  String? get email;
  @override
  @JsonKey(ignore: true)
  String? get password;
  @override
  @JsonKey(name: "last_name")
  String? get lastName;
  @override
  @JsonKey(name: "first_name")
  String? get firstName;
  @override
  @JsonKey(
      fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "updated_at")
  DateTime? get createdAt;
  @override
  @JsonKey(
      fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "created_at")
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$UserModelCopyWith<_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
