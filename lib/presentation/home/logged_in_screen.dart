import 'package:flutter/material.dart';
import 'package:supabase_cubit_auth/domain/user/user_model.dart';

/// Screen used to highlight functionality of [RootRouterCubit].
///
/// This screen is shown when the [RootRouterCubit.goToLoggedInScreen] is called and
/// when the Uri path contains [RootRouterState.loggedInScreenPath].
///
/// This is to showcase a screen after the user is signed in.
class LoggedInScreen extends StatelessWidget {
  final UserModel user;
  const LoggedInScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(user.fullName),
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
