import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_cubit_auth/application/authentication/authentication_cubit.dart';
import 'package:supabase_cubit_auth/application/root_router/root_router_cubit.dart';
import 'package:supabase_cubit_auth/domain/user/user_model.dart';

/// The root screen of the app when the user is authenticated.
///
/// This screen is shown when the router's state is [RootRouterState.home] and
/// when the Uri path contains [RootRouterState.homePath].
class HomeScreen extends StatelessWidget {
  final UserModel user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(user.fullName),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () => context.read<AuthenticationCubit>().signOut(),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _bodyTile(context, icon: Icons.person, title: "Full name: ${user.fullName}"),
            _bodyTile(context, icon: Icons.person, title: "Username: ${user.email!}"),
            _bodyTile(
              context,
              icon: Icons.calendar_today,
              title: "Created at: ${user.createdAt!.toString()}",
            ),
            _bodyTile(
              context,
              icon: Icons.calendar_today,
              title: "Updated at: ${user.updatedAt!.toString()}",
            ),
            ElevatedButton(
              child: const Text("Push screen"),
              onPressed: () => context.read<RootRouterCubit>().goToLoggedInScreen(),
            ),
          ],
        ),
      );

  Widget _bodyTile(
    BuildContext context, {
    required String title,
    required IconData icon,
  }) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            child: Icon(icon, size: 30),
            radius: 40,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      );
}
