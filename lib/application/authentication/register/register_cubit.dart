import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_cubit_auth/domain/authentication/authentication_repository.dart';
import 'package:supabase_cubit_auth/domain/user/user_model.dart';
import 'package:supabase_cubit_auth/infrastructure/extensions.dart';
import 'package:supabase_cubit_auth/infrastructure/global_utils.dart';

part 'register_state.dart';
part 'register_cubit.freezed.dart';

/// Cubit where we implement de logic for registering new users.
///
/// Used inside [RegisterScreen] class.
class RegisterCubit extends Cubit<RegisterState> {
  final AuthenticationRepository _repo;

  RegisterCubit({required AuthenticationRepository authRepo})
      : _repo = authRepo,
        super(const RegisterState.initial());

  /// Public method used to register the passed [UserModel] object.
  Future<void> registerUser(UserModel user) async {
    emit(const RegisterState.registering());
    await responseDelay();
    final result = await _repo.registerUser(user.copyWith(
      lastName: user.lastName!.capitalised,
      firstName: user.firstName!.capitalised,
    ));
    result.when(
      failure: (message) {
        emit(RegisterState.failure(message));
        emit(const RegisterState.initial());
      },
      success: (_) => null,
    );
  }
}
