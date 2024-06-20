import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/tution/tution_list_response.dart';
import '../../utilities/enums.dart';
import '../../utilities/functions/http_request.dart';
import '../../utilities/shared_preference.dart';
import '../../utilities/singleton.dart';
import 'state.dart';

class GetTutionController extends StateNotifier<GetTutionState> {
  final Ref ref;
  GetTutionController({required this.ref}) : super(GetTutionState());

  get() async {
    try {
      String? email =
          await locator<SharedPreferenceService>().getString(key: "userEmail");

      final Response? response = await httpRequest(
        httpRequestType: HttpRequestType.post,
        path: "/gettutionsteacher",
        payload: {
          "email": email,
        },
      );

      TutionListResponseModel? data =
          TutionListResponseModel.fromJson(response?.data);
      if (data.error == null) {
        if (data.results != null && data.results!.isNotEmpty) {
          state = state.copyWith(
            data: data,
            dataState: DataState.loaded,
          );
        } else {
          state = state.copyWith(
            message: "No data found",
            dataState: DataState.empty,
          );
        }
      } else {
        state = state.copyWith(
          message: "Something went wrong. Please try again!",
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
    state = GetTutionState();
  }
}

final getTutionProvider =
    StateNotifierProvider.autoDispose<GetTutionController, GetTutionState>(
  (ref) => GetTutionController(ref: ref),
);
