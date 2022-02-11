import 'package:freezed_annotation/freezed_annotation.dart';

part 'operation_result.freezed.dart';

/// A freezed-union to easily identify if the operation was successful or not.
///
/// This is very handy because it simplifies the return type of all repository methods.
/// Having the knowledge that repositories operations should return an [OperationResult]
/// we can plan accordingly. This will make the Blocs/Cubits code more readable.
@freezed
class OperationResult<T> with _$OperationResult<T> {
  /// Used when repository operation ends in failure.
  ///
  /// Either beeing an unexpected result or an exception occurs.
  const factory OperationResult.failure(String message) = _Failure;

  /// Used when repository operation end in success.
  ///
  /// Because this receives a generic type we have the flexibility of also providing objects returned
  /// by queries.
  /// This is useful when we need to make a RESTful call which returns a result which needs to be treated.
  const factory OperationResult.success([T? response]) = _Success;
}
