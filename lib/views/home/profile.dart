import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pro_widgets/pro_widgets.dart';
import 'package:tutorhub_teacher/utilities/colors.dart';
import 'package:tutorhub_teacher/utilities/functions/navigation.dart';
import 'package:tutorhub_teacher/views/home/location_selector.dart';

import '../../utilities/shared_preference.dart';
import '../../utilities/singleton.dart';

class ProfileBottomSheet extends StatefulWidget {
  const ProfileBottomSheet({super.key});

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {
  String? name;
  String? email;
  String? phone;
  LatLng latLng = const LatLng(0, 0);

  getUserData() async {
    name = await locator<SharedPreferenceService>().getString(key: "userName");
    email =
        await locator<SharedPreferenceService>().getString(key: "userEmail");
    phone =
        await locator<SharedPreferenceService>().getString(key: "userPhone");
    double? lat = await locator<SharedPreferenceService>()
        .getDouble(key: "location_latitude");
    double? long = await locator<SharedPreferenceService>()
        .getDouble(key: "location_longitude");
    latLng = LatLng(lat ?? 0, long ?? 0);
    setState(() {});
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProText(
            text: "Name: $name",
            fontSize: 16,
            color: ProjectColors.primary,
          ),
          const ProGap(y: 8),
          ProText(
            text: "Email: $email",
            fontSize: 16,
            color: ProjectColors.primary,
          ),
          const ProGap(y: 8),
          ProText(
            text: "Phone: $phone",
            fontSize: 16,
            color: ProjectColors.primary,
          ),
          const ProGap(y: 16),
          ProButtonBasic(
            text: latLng.latitude != 0 || latLng.longitude != 0
                ? "Change Location"
                : "Set Location",
            fontSize: 16,
            fontColor: ProjectColors.primary,
            height: 45,
            width: double.infinity,
            backgroundColor: Colors.transparent,
            borderColor: ProjectColors.primary,
            borderWidth: 1,
            onTap: () {
              push(
                  screen: LocationSelectorProfile(
                latLng: latLng,
                email: email,
              ));
            },
          ),
        ],
      ),
    );
  }
}
