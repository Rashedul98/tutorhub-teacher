import '../../models/signin/response.dart';
import '../../utilities/enums.dart';

class SigninState {
  final DataState dataState;
  final SigninResponseModel? data;
  final String? message;

  SigninState({
    this.dataState = DataState.initial,
    this.data,
    this.message,
  });

  SigninState copyWith({
    final DataState? dataState,
    final SigninResponseModel? data,
    final String? message,
  }) {
    return SigninState(
      dataState: dataState ?? this.dataState,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}
