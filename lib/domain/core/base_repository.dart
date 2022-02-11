import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Base class for all repositories.
///
/// Should contain all common properties used in repositories classes.
abstract class BaseRepository {
  late final Logger _logger;

  /// Supabase client used in all CRUD operations.
  SupabaseClient get supabaseClient => Supabase.instance.client;

  BaseRepository({Logger? logger, bool initHttpClient = true}) : _logger = logger ?? Logger() {
    _logger.i("Initialising repository $this");
  }

  /// Log debug messages.
  void logDebug(String message, {dynamic error, StackTrace? stackTrace}) =>
      _logger.d(message, error, stackTrace);

  /// Log exceptions caught.
  void logException(String message, {dynamic error, StackTrace? stackTrace}) =>
      _logger.e(message, error, stackTrace);

  /// Close all resources used in repository.
  @mustCallSuper
  Future<void> close() async {
    _logger.i("Closing repository $this");
    _logger.close();
  }
}
