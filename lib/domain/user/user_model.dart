// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_cubit_auth/domain/util/json_util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Model of the user's profile stored in the database.
///
/// Contains all fields, mapped to their respective table columns.
/// Because SQL and Dart naming convention differs, we make use `@JsonKey(name: "")` to properly map
/// the fields.
@freezed
class UserModel with _$UserModel {
  /// Make the constructor private to enable custom computed values (getters) and methods.
  ///
  /// You can read more, here: https://pub.dev/packages/freezed#custom-getters-and-methods
  const UserModel._();

  /// Get the full name of the user by making use of string interpolation.
  String get fullName => "${lastName ?? ""} ${firstName ?? ""}";

  const factory UserModel({
    String? id,
    String? email,
    @JsonKey(ignore: true) String? password,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "updated_at")
        DateTime? createdAt,
    @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson, name: "created_at")
        DateTime? updatedAt,
  }) = _UserModel;

  /// Make a [UserModel] object from a GoTrue [User].
  ///
  /// Because the incoming value has a [User.toJson] method we use it to turn it into a JSON
  /// and make use of the [UserModel.fromJson] constructor to make our object in a single line of code.
  factory UserModel.fromAuthUser(User user) => UserModel.fromJson(user.toJson());

  /// Make a [UserModel] object from the incoming JSON.
  factory UserModel.fromJson(Map<String, dynamic> data) => _$UserModelFromJson(data);
}
