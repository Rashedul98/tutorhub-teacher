import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_widgets/pro_widgets.dart';
import 'package:tutorhub_teacher/views/home/profile.dart';
import 'package:tutorhub_teacher/views/home/tutions.dart';

import '../../controllers/get_tution/get_tution.dart';
import '../../utilities/colors.dart';
import '../../utilities/functions/navigation.dart';
import '../../utilities/shared_preference.dart';
import '../../utilities/singleton.dart';
import '../signin/signin.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ProjectColors.primary,
          title: const ProText(
            text: "TutorHub",
            fontSize: 18,
            color: Colors.white,
          ),
          actions: [
            ProTapper(
              padding: const EdgeInsets.all(16),
              child: const Icon(
                Icons.person,
                color: ProjectColors.white,
              ),
              onTap: () {
                proBottomSheet(
                  context: context,
                  appBarTitle: "Profile",
                  onAppBarCloseIconTap: () {
                    pop();
                  },
                  sheetBody: const ProfileBottomSheet(),
                );
              },
            ),
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
            child: RefreshIndicator(
              onRefresh: () async {
                ref.read(getTutionProvider.notifier).reset();
              },
              child: ListView(
                children: const [
                  HomeTutionList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
