import 'package:flutter/material.dart';

/// A 404-error style screen.
///
/// This screen is shown when the router's state is [RootRouterState.unkown] and
/// when the Uri path contains [RootRouterState.unknownPath].
class UnkownScreen extends StatelessWidget {
  const UnkownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 100),
              Flexible(
                child: Text(
                  "Resource not found",
                  style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
}
