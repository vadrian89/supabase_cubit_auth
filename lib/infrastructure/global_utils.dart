/// Helper function used to add some delay whenever we need.
///
/// This is to have a global, constant delay time.
Future<void> responseDelay() => Future.delayed(const Duration(milliseconds: 300));
