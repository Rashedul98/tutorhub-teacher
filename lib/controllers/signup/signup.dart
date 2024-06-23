import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorhub_teacher/controllers/signup/signup_state.dart';
import 'package:tutorhub_teacher/models/signup/response.dart';
import 'package:tutorhub_teacher/utilities/enums.dart';
import 'package:tutorhub_teacher/utilities/functions/http_request.dart';
import 'package:tutorhub_teacher/views/signup/provider.dart';

class SignupController extends StateNotifier<SignupState> {
  final Ref ref;
  SignupController({required this.ref}) : super(SignupState());

  signUp() async {
    try {
      final Response? response = await httpRequest(
        httpRequestType: HttpRequestType.post,
        path: "/teacher-signup",
        payload: ref.read(signupRequestModelProvider).toJson(),
      );

      SignupResponseModel? data = SignupResponseModel.fromJson(response?.data);

      if (data.success == true) {
        state = state.copyWith(
          data: data,
          dataState: DataState.loaded,
        );
      } else {
        state = state.copyWith(
          message: data.error ?? "Something went wrong.",
          dataState: DataState.error,
        );
      }
    } catch (_) {
      state = state.copyWith(
        message: "Something went wrong. Please try again!",
        dataState: DataState.error,
      );
    }
  }

  reset() {
    state = SignupState();
  }
}

final signupProvider =
    StateNotifierProvider.autoDispose<SignupController, SignupState>(
  (ref) => SignupController(ref: ref),
);
