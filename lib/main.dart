import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'utilities/dio.dart';
import 'utilities/singleton.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await registerSingletons();
  await locator<DioService>().create("http://192.168.68.121:3000");

  runApp(const ProviderScope(child: MyApp()));
}
