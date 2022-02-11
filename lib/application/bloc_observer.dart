// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

/// An observer for bloc to show when states are changed.
class SimpleBlocObserver extends BlocObserver {
  final Logger _logger = Logger();
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _logger.e("Error in $bloc", error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    _logger.d(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    _logger.d(change);
    super.onChange(bloc, change);
  }
}
