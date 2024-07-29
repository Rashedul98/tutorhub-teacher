import '../../utilities/enums.dart';

class UpdateLocationState {
  final DataState dataState;
  final String? message;

  UpdateLocationState({
    this.dataState = DataState.initial,
    this.message,
  });

  UpdateLocationState copyWith({
    final DataState? dataState,
    final bool? success,
    final String? message,
  }) {
    return UpdateLocationState(
      dataState: dataState ?? this.dataState,
      message: message ?? this.message,
    );
  }
}
