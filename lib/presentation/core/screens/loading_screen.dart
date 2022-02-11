import 'package:flutter/material.dart';
import 'package:supabase_cubit_auth/presentation/core/widgets/center_loader.dart';

/// The initial screen shown before the app checks if the user is authenticated or not.
///
/// This screen is shown when the router's state is [RootRouterState.initial].
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        backgroundColor: Colors.white,
        body: CenterLoader(),
      );
}
