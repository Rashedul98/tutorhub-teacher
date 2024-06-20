import 'package:flutter/material.dart';
import 'package:pro_widgets/pro_widgets.dart';
import 'package:tutorhub_teacher/views/home/tutions.dart';

import '../../utilities/colors.dart';
import '../../utilities/functions/navigation.dart';
import '../../utilities/shared_preference.dart';
import '../../utilities/singleton.dart';
import '../signin/signin.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ProjectColors.primary,
          title: const ProText(
            text: "TutorHub - Teacher",
            fontSize: 18,
            color: Colors.white,
          ),
          actions: [
            ProTapper(
              padding: const EdgeInsets.all(16),
              child: const Icon(
                Icons.logout,
                color: ProjectColors.white,
              ),
              onTap: () {
                locator<SharedPreferenceService>().clear().then((value) {
                  pushAndRemoveAll(screen: const SigninScreen());
                });
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: const [
                HomeTutionList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
