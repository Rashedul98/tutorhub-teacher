import 'package:get_it/get_it.dart';
import 'package:tutorhub_teacher/utilities/nav_service.dart';

import 'dio.dart';
import 'shared_preference.dart';

GetIt locator = GetIt.instance;

Future<void> registerSingletons() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SharedPreferenceService());
  locator.registerLazySingleton(() => DioService());
}
