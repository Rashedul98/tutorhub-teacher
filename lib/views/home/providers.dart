import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorhub_teacher/models/tution/update_tution_request.dart';

final updateTutionModelProvider =
    StateProvider((ref) => UpdateTutionModelReq());
