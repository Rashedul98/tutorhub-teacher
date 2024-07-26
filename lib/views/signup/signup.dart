import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pro_widgets/pro_widgets.dart';
import 'package:tutorhub_teacher/utilities/functions/get_position.dart';
import 'package:tutorhub_teacher/utilities/functions/null_checker.dart';
import 'package:tutorhub_teacher/views/signin/signin.dart';
import 'package:tutorhub_teacher/views/signup/loader.dart';
import 'package:tutorhub_teacher/views/signup/location_selector.dart';
import 'package:tutorhub_teacher/views/signup/provider.dart';

import '../../models/signup/request.dart';
import '../../utilities/colors.dart';
import '../../utilities/enums.dart';
import '../../utilities/functions/navigation.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<Expertise> expertise =
        ref.watch(signupRequestModelProvider).expertise ?? [];
    Location? location = ref.watch(signupRequestModelProvider).location;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const ProText(
            text: "Signup",
            fontSize: 18,
            color: ProjectColors.primary,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ProTextFormField(
                    initialValue:
                        ref.read(signupRequestModelProvider).firstName,
                    borderColor: Colors.black12,
                    borderWidth: 1,
                    hint: "First name",
                    onChanged: (value) {
                      ref
                          .read(signupRequestModelProvider.notifier)
                          .update((state) => state.copyWith(firstName: value));
                    },
                    validator: (value) {
                      if (isNull(value)) {
                        return 'This field can not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const ProGap(y: 16),
                  ProTextFormField(
                    initialValue: ref.read(signupRequestModelProvider).lastName,
                    borderColor: Colors.black12,
                    borderWidth: 1,
                    hint: "Last name",
                    onChanged: (value) {
                      ref
                          .read(signupRequestModelProvider.notifier)
                          .update((state) => state.copyWith(lastName: value));
                    },
                    validator: (value) {
                      if (isNull(value)) {
                        return 'This field can not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const ProGap(y: 16),
                  ProTextFormField(
                    initialValue: ref.read(signupRequestModelProvider).email,
                    borderColor: Colors.black12,
                    borderWidth: 1,
                    hint: "Email",
                    onChanged: (value) {
                      ref
                          .read(signupRequestModelProvider.notifier)
                          .update((state) => state.copyWith(email: value));
                    },
                    validator: (value) {
                      if (isNull(value)) {
                        return 'This field can not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const ProGap(y: 16),
                  const ProText(
                    text: 'Select gender',
                  ),
                  const ProGap(y: 8),
                  Row(
                    children: [
                      ProRadioButton(
                        title: "Male",
                        checked: ref.watch(signupRequestModelProvider).gender ==
                            "Male",
                        onTap: (_) {
                          ref.read(signupRequestModelProvider.notifier).update(
                              (state) => state.copyWith(gender: "Male"));
                        },
                      ),
                      const ProGap(x: 16),
                      ProRadioButton(
                        title: "Female",
                        checked: ref.watch(signupRequestModelProvider).gender ==
                            "Female",
                        onTap: (value) {
                          ref.read(signupRequestModelProvider.notifier).update(
                              (state) => state.copyWith(gender: "Female"));
                        },
                      ),
                    ],
                  ),
                  const ProGap(y: 16),
                  ProTextFormField(
                    initialValue: ref.read(signupRequestModelProvider).phone,
                    borderColor: Colors.black12,
                    borderWidth: 1,
                    hint: "Phone",
                    onChanged: (value) {
                      ref
                          .read(signupRequestModelProvider.notifier)
                          .update((state) => state.copyWith(phone: value));
                    },
                    validator: (value) {
                      if (isNull(value)) {
                        return 'This field can not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const ProGap(y: 16),
                  ProTextFormField(
                    initialValue: ref
                        .read(signupRequestModelProvider)
                        .educationalQualification,
                    borderColor: Colors.black12,
                    borderWidth: 1,
                    hint: "Educational Qualification (Ex. Bachelor)",
                    onChanged: (value) {
                      ref.read(signupRequestModelProvider.notifier).update(
                            (state) =>
                                state.copyWith(educationalQualification: value),
                          );
                    },
                    validator: (value) {
                      if (isNull(value)) {
                        return 'This field can not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const ProGap(y: 16),
                  ProTextFormField(
                    initialValue: ref.read(signupRequestModelProvider).password,
                    borderColor: Colors.black12,
                    borderWidth: 1,
                    obsecureText: true,
                    hint: "Password",
                    onChanged: (value) {
                      ref
                          .read(signupRequestModelProvider.notifier)
                          .update((state) => state.copyWith(password: value));
                    },
                    validator: (value) {
                      if (isNull(value)) {
                        return 'This field can not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const ProGap(y: 16),
                  ProCard(
                    disableShadow: true,
                    borderColor: ProjectColors.border,
                    borderWidth: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ProText(
                          text: "Add your expertise",
                          fontSize: 14,
                          color: ProjectColors.primary,
                        ),
                        const ProGap(y: 12),
                        Column(
                          children: expertise.map(
                            (exp) {
                              int? indexOfExp = expertise.indexOf(exp);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: ProCard(
                                  disableShadow: true,
                                  borderColor: ProjectColors.border,
                                  borderWidth: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ProTextFormField(
                                              borderColor: Colors.black12,
                                              borderWidth: 1,
                                              hint: "Expertise (Ex. Bangla)",
                                              onChanged: (value) {
                                                expertise[indexOfExp] =
                                                    expertise[indexOfExp]
                                                        .copyWith(
                                                            subject: value);
                                                ref
                                                    .read(
                                                        signupRequestModelProvider
                                                            .notifier)
                                                    .update(
                                                      (state) => state.copyWith(
                                                          expertise: expertise),
                                                    );
                                              },
                                              validator: (value) {
                                                if (isNull(value)) {
                                                  return 'This field can not be empty';
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                          indexOfExp != 0
                                              ? ProTapper(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: const Icon(
                                                    Icons.cancel,
                                                    color: ProjectColors.red500,
                                                  ),
                                                  onTap: () {
                                                    expertise
                                                        .removeAt(indexOfExp);
                                                    ref
                                                        .read(
                                                            signupRequestModelProvider
                                                                .notifier)
                                                        .update((state) =>
                                                            state.copyWith(
                                                                expertise:
                                                                    expertise));
                                                  },
                                                )
                                              : const SizedBox.shrink()
                                        ],
                                      ),
                                      const ProGap(y: 12),
                                      ProRadioButton(
                                        checked: exp.scope ==
                                            ScopeType.primarySchool.value,
                                        title: ScopeType.primarySchool.name,
                                        titleFontSize: 12,
                                        titleColor: ProjectColors.primary,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        onTap: (_) {
                                          expertise[indexOfExp] =
                                              expertise[indexOfExp].copyWith(
                                            scope:
                                                ScopeType.primarySchool.value,
                                          );
                                          ref
                                              .read(signupRequestModelProvider
                                                  .notifier)
                                              .update(
                                                (state) => state.copyWith(
                                                    expertise: expertise),
                                              );
                                        },
                                      ),
                                      const ProGap(y: 4),
                                      ProRadioButton(
                                        checked: exp.scope ==
                                            ScopeType.highSchool.value,
                                        title: ScopeType.highSchool.name,
                                        titleFontSize: 12,
                                        titleColor: ProjectColors.primary,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        onTap: (_) {
                                          expertise[indexOfExp] =
                                              expertise[indexOfExp].copyWith(
                                            scope: ScopeType.highSchool.value,
                                          );
                                          ref
                                              .read(signupRequestModelProvider
                                                  .notifier)
                                              .update(
                                                (state) => state.copyWith(
                                                    expertise: expertise),
                                              );
                                        },
                                      ),
                                      const ProGap(y: 4),
                                      ProRadioButton(
                                        checked: exp.scope ==
                                            ScopeType.college.value,
                                        title: ScopeType.college.name,
                                        titleFontSize: 12,
                                        titleColor: ProjectColors.primary,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        onTap: (_) {
                                          expertise[indexOfExp] =
                                              expertise[indexOfExp].copyWith(
                                            scope: ScopeType.college.value,
                                          );
                                          ref
                                              .read(signupRequestModelProvider
                                                  .notifier)
                                              .update(
                                                (state) => state.copyWith(
                                                    expertise: expertise),
                                              );
                                        },
                                      ),
                                      const ProGap(y: 4),
                                      ProRadioButton(
                                        checked:
                                            exp.scope == ScopeType.oLevel.value,
                                        title: ScopeType.oLevel.name,
                                        titleFontSize: 12,
                                        titleColor: ProjectColors.primary,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        onTap: (_) {
                                          expertise[indexOfExp] =
                                              expertise[indexOfExp].copyWith(
                                            scope: ScopeType.oLevel.value,
                                          );
                                          ref
                                              .read(signupRequestModelProvider
                                                  .notifier)
                                              .update(
                                                (state) => state.copyWith(
                                                    expertise: expertise),
                                              );
                                        },
                                      ),
                                      const ProGap(y: 12),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                        const ProGap(y: 16),
                        ProButtonBasic(
                          text: "Add More Expertise +",
                          fontSize: 16,
                          fontColor: ProjectColors.primary,
                          height: 45,
                          width: double.infinity,
                          backgroundColor: Colors.transparent,
                          borderColor: ProjectColors.primary,
                          borderWidth: 1,
                          onTap: () {
                            expertise.add(Expertise());
                            ref
                                .read(signupRequestModelProvider.notifier)
                                .update((state) =>
                                    state.copyWith(expertise: expertise));
                          },
                        ),
                      ],
                    ),
                  ),
                  const ProGap(y: 16),
                  ProButtonBasic(
                    text: location?.latitude == null ||
                            location?.longitude == null
                        ? "Set Location"
                        : "Change Location",
                    fontSize: 16,
                    fontColor: ProjectColors.primary,
                    height: 45,
                    width: double.infinity,
                    backgroundColor: Colors.transparent,
                    borderColor: ProjectColors.primary,
                    borderWidth: 1,
                    onTap: () {
                      push(screen: const LocationSelector());
                    },
                  ),
                  const ProGap(y: 16),
                  ProButtonBasic(
                    text: "Sign up",
                    fontSize: 16,
                    height: 45,
                    width: double.infinity,
                    onTap: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (location?.latitude != null &&
                            location?.longitude != null) {
                          loader(screen: const SignupLoader());
                        }
                      }
                    },
                  ),
                  const ProGap(y: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ProText(
                        text: "Already have account?",
                        fontSize: 14,
                      ),
                      ProButtonText(
                        text: "Sign in",
                        fontColor: Colors.red,
                        function: () {
                          pushReplaced(screen: const SigninScreen());
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
