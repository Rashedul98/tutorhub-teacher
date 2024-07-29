import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorhub_teacher/views/home/providers.dart';

import '../../utilities/enums.dart';
import '../../utilities/functions/http_request.dart';
import '../../utilities/shared_preference.dart';
import '../../utilities/singleton.dart';
import 'state.dart';

class UpdateLocationController extends StateNotifier<UpdateLocationState> {
  final Ref ref;
  UpdateLocationController({required this.ref}) : super(UpdateLocationState());

  update() async {
    try {
      final Response? response = await httpRequest(
        httpRequestType: HttpRequestType.post,
        path: "/updatelocations",
        payload: ref.read(updateLocationModelProvider).toJson(),
      );

      if (response?.data != null) {
        if (response?.data['error'] == null) {
          if (response?.data['success'] == true) {
            locator<SharedPreferenceService>().setDouble(
              key: "location_latitude",
              value:
                  ref.read(updateLocationModelProvider).location?.latitude ?? 0,
            );

            locator<SharedPreferenceService>().setDouble(
              key: "location_longitude",
              value:
                  ref.read(updateLocationModelProvider).location?.longitude ??
                      0,
            );
            state = state.copyWith(
              dataState: DataState.loaded,
            );
          } else {
            state = state.copyWith(
              dataState: DataState.error,
              message: "Something went wrong. Please try again!",
            );
          }
        } else {
          state = state.copyWith(
            dataState: DataState.error,
            message: "Something went wrong. Please try again!",
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
    state = UpdateLocationState();
  }
}

final updateLocationProvider = StateNotifierProvider.autoDispose<
    UpdateLocationController, UpdateLocationState>(
  (ref) => UpdateLocationController(ref: ref),
);
