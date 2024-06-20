import 'package:flutter/material.dart';

import 'login_checker.dart';
import 'utilities/nav_service.dart';
import 'utilities/singleton.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: locator<NavigationService>().globalNavigatorKey,
      title: "TutorHub",
      debugShowCheckedModeBanner: false,
      home: const LoginCheckerScreen(),
    );
  }
}
