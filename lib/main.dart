import 'package:flutter/material.dart';
import 'package:supabase_cubit_auth/application/bloc_initaliser.dart';
import 'package:supabase_cubit_auth/application/bloc_observer.dart';
import 'package:supabase_cubit_auth/presentation/app_root.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  /// Is required whenever the main function is aync, as in our case.
  WidgetsFlutterBinding.ensureInitialized();

  /// So we get rid of the pesky '#' from the browser url.
  setPathUrlStrategy();

  /// Initialisation from the oficial documentation: https://supabase.com/docs/reference/dart/initializing#flutter-initialize
  await Supabase.initialize(
    url: "",
    anonKey: "",
    debug: true, // optional
  );

  BlocOverrides.runZoned(
    () => runApp(BlocInitialiser(child: AppRoot())),
    blocObserver: SimpleBlocObserver(),
  );
}
