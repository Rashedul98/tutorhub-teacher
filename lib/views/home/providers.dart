import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorhub_teacher/models/tution/update_tution_request.dart';
import 'package:tutorhub_teacher/models/update_location_request.dart';

final updateTutionModelProvider =
    StateProvider((ref) => UpdateTutionModelReq());

final updateLocationModelProvider =
    StateProvider((ref) => UpdateLocationModelRequest());
