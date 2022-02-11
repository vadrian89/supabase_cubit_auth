import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Show a [SpinKitDoubleBounce] loader widget from the https://pub.dev/packages/flutter_spinkit package.
///
/// Can be used in many parts of the and having it in a separate widget allows us to easily make changes to it,
/// without the burden of having to trace each of it's usages.
class CenterLoader extends StatelessWidget {
  const CenterLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: SpinKitDoubleBounce(
          color: Theme.of(context).primaryColor,
        ),
      );
}
