import 'package:flutter/material.dart';

/// The confirmation dialog shown to the user before exiting the app.
class AppExitDialog extends StatelessWidget {
  const AppExitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text("Exit App"),
        content: const Text("Are you sure you want to exit the app?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context, true),
          ),
          TextButton(
            child: const Text("Confirm"),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      );

  /// Show the confirmation dialog.
  ///
  /// Since [build] method returns the built widget, we need a separate method to actually
  /// show the dialog.
  Future<bool> show(BuildContext context) async =>
      await showDialog<bool>(
        context: context,
        builder: (_) => this,
      ) ??
      false;
}
