import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorhub_teacher/models/signup/request.dart';

final signupRequestModelProvider = StateProvider((ref) => SignupRequestModel(
      expertise: [
        Expertise(),
      ],
    ));
