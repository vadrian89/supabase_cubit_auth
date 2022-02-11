import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_cubit_auth/domain/core/base_repository.dart';
import 'package:supabase_cubit_auth/domain/core/operation_result.dart';
import 'package:supabase_cubit_auth/domain/user/user_model.dart';

/// Repository class used for the authentication process
///
/// Used to implement everything which is tied to the authentication process:
/// sign in, register, sign in using OAuth providers and sign out.
///
/// In the current tutorial we will only cover: register, sign in using e-mail + password and sign out.
class AuthenticationRepository extends BaseRepository {
  /// Stream controller used to create a stream through which profile data is made available.
  ///
  /// To reduce complexity we use this stream controller to report multiple operations on the user,
  /// such as: whenever sign in/out occurs, when a new user is registered, when the user authentication data
  /// is updated or when the profile itself is updated.
  final StreamController<UserModel?> _profileStreamCtrl;

  /// Stream controller through which errors in the authentication process occurs.
  final StreamController<OperationResult> _resultStreamCtrl;

  /// Supabase authentication state subscription.
  ///
  /// It is used to call [getUserProfile], whenever an [AuthChangeEvent] is emitted.
  late final GotrueSubscription supabaseAuthSub;

  /// PostgreSQL table where the user profiles are stored.
  ///
  /// Make use of Row Level Security (RLS) so the users have access to only their personal profiles.
  /// More info: https://supabase.com/docs/guides/auth/row-level-security
  static const String _profilesTable = "user_profiles";

  /// Realtime subscription so we can react to changes made to the user's profile.
  RealtimeSubscription? _profileSub;

  /// Public stream to make the [UserModel] stream accesible outside class, while the controller private.
  Stream<UserModel?> get profileStream => _profileStreamCtrl.stream;

  /// Public stream to make the [OperationResult] stream accesible outside class, while the controller private.
  ///
  /// The only methods which do not use this stream are [signInUser], [registerUser] and [_registrationUpdate].
  /// The reason being, that they are not called inside [AuthenticationCubit].
  Stream<OperationResult> get resultStream => _resultStreamCtrl.stream;

  /// Shorthand getter
  GoTrueClient get _auth => supabaseClient.auth;

  /// Public getter to access the session on app startup.
  ///
  /// This way we can make sure that the user is signed in or not and set the [RootRouterState]
  /// accordingly. Being either [RootRouterState.unauthenticated] or [RootRouterState.home] state.
  Session? get authSession => _auth.session();

  AuthenticationRepository()
      : _profileStreamCtrl = StreamController.broadcast(),
        _resultStreamCtrl = StreamController.broadcast() {
    supabaseAuthSub = _auth.onAuthStateChange((_, __) => getUserProfile());
  }

  /// Subscribe to user profile changes, allowing us the know when the user's profile changed.
  ///
  /// Because Row Level Security is enabled for this table, the only available row in the [_profilesTable] is
  /// the currently signed in user's profile.
  /// Whenever a change occured [getUserProfile] is called.
  void startProfileSub() => _profileSub = supabaseClient
      .from(_profilesTable)
      .on(SupabaseEventTypes.all, (_) => getUserProfile())
      .subscribe()
    ..onClose(() => logDebug("User profile subscription closed"));

  /// Register's new user.
  Future<OperationResult> registerUser(UserModel user) async {
    OperationResult result = const OperationResult.success();
    try {
      final response = await _auth.signUp(user.email!, user.password!);
      if (response.error != null) {
        result = OperationResult.failure(response.error!.message);
      } else {
        result = await _registrationUpdate(UserModel.fromAuthUser(response.data!.user!).copyWith(
          lastName: user.lastName,
          firstName: user.firstName,
        ));
      }
    } catch (e, stackTrace) {
      logException("Exception in registerUser", stackTrace: stackTrace);
      result = const OperationResult.failure("Unkown error when registering user!");
    }
    return result;
  }

  /// Update the user's profile correctly after the registration occurs.
  ///
  /// When a user is registered, a stored procedure is called in PostgreSQL through a trigger, creating the user's profile only containing the
  /// user's id and e-mail. To add all the rest of the data we need to make an update to the profile.
  ///```
  /// Stored procedure:
  /// create or replace function public.handle_new_user()
  /// returns trigger as $$
  /// begin
  ///   INSERT INTO public.user_profiles (id, email)
  ///   values (new.id, new.email)
  ///  ON CONFLICT (id)
  ///   DO
  ///     UPDATE SET email = new.email;
  ///   return new;
  /// end;
  /// $$ language plpgsql security definer;
  /// ```
  ///
  /// Trigger:
  /// ```
  /// create trigger on_auth_user_created
  ///   after update or insert on auth.users
  ///   for each row execute procedure public.handle_new_user();
  ///```
  /// If you wonder, why we don't do an insert, it's because RLS policy is enabled and
  /// profiles cannot be inserted from outside of the database.
  Future<OperationResult> _registrationUpdate(UserModel userProfile) async {
    OperationResult result = const OperationResult.success();
    try {
      final response = await supabaseClient
          .from(_profilesTable)
          .update(userProfile.toJson())
          .eq("id", userProfile.id)
          .execute();
      if (response.error != null) {
        result = OperationResult.failure(response.error!.message);
      }
    } catch (e, stackTrace) {
      logException("Exception in registrationUpdate", stackTrace: stackTrace);
      result = const OperationResult.failure("Unkown error when updating user profile!");
    }
    return result;
  }

  /// Sign in the user using e-mail + password.
  Future<OperationResult> signInUser({
    required String email,
    required String password,
  }) async {
    OperationResult result = const OperationResult.success();
    try {
      final response = await _auth.signIn(email: email, password: password);
      if (response.error != null) {
        result = OperationResult.failure(response.error!.message);
      }
    } catch (e, stackTrace) {
      logException("Exception in signInUser", stackTrace: stackTrace);
      result = const OperationResult.failure("Unkown error when signing in user!");
    }
    return result;
  }

  /// Sign out the user.
  ///
  /// Besides signing out the user, we need to unsubscribe from [_profileSub].
  Future<void> signOut() async {
    OperationResult? result;
    try {
      final response = await _auth.signOut();
      if (response.error != null) {
        logException("Sign in has error: ${response.error}");
        result = OperationResult.failure(response.error!.message);
      } else {
        _profileSub?.unsubscribe();
      }
    } catch (e, stackTrace) {
      logException("Exception at signOut", stackTrace: stackTrace);
      result = const OperationResult.failure("Unkown error at sign out!");
    }
    if (result != null) {
      _resultStreamCtrl.sink.add(result);
    }
  }

  /// Retrieve the user's profile from [_profilesTable] database table.
  ///
  /// Before retrieving the profile we first need to check if the session exists (meaning the user is signed in).
  /// If we cannot find any session, we send a null value to [profileStream], which in turn will trigger a
  /// call to [signOut].
  /// If the session exists, we make the call to the database requesting the profile, make the necessary checks
  /// to ensure there is a profile saved, then send it to the [profileStream] to be properly used.
  Future<void> getUserProfile() async {
    if (_auth.currentSession == null) {
      _profileStreamCtrl.sink.add(null);
      return;
    }
    OperationResult? result;
    try {
      final response = await supabaseClient.from(_profilesTable).select().execute();
      if (response.error != null) {
        result = OperationResult.failure(response.error!.message);
      } else {
        if ((response.data as List).isEmpty) {
          result = const OperationResult.failure("Missing user profile!");
        } else if (response.hasError) {
          result = OperationResult.failure(response.error!.message);
        } else {
          final userProfile = UserModel.fromJson(response.data.first);
          _profileStreamCtrl.sink.add(userProfile);
        }
      }
    } catch (e, stackTrace) {
      logException("Exception in userProfile", stackTrace: stackTrace);
      result = const OperationResult.failure("Unkown error when retrieving user profile!");
    }
    if (result != null) {
      signOut();
      _resultStreamCtrl.sink.add(result);
    }
  }

  /// Close all stream controllers.
  @override
  Future<void> close() async {
    await _resultStreamCtrl.close();
    await _profileStreamCtrl.close();
    super.close();
  }
}
