import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pro_widgets/pro_widgets.dart';
import 'package:tutorhub_teacher/models/update_location_request.dart';
import 'package:tutorhub_teacher/utilities/functions/navigation.dart';
import 'package:tutorhub_teacher/views/home/loaders/update_location_loader.dart';
import 'package:tutorhub_teacher/views/home/providers.dart';
import '../../utilities/colors.dart';
import '../../utilities/functions/get_position.dart';

class LocationSelectorProfile extends StatefulWidget {
  final LatLng? latLng;
  final String? email;
  const LocationSelectorProfile({super.key, this.latLng, this.email});

  @override
  State<LocationSelectorProfile> createState() =>
      _LocationSelectorProfileState();
}

class _LocationSelectorProfileState extends State<LocationSelectorProfile> {
  GoogleMapController? _controller;
  LatLng? _pickedLocation;

  Future<void> _getCurrentLocation() async {
    try {
      if (widget.latLng?.latitude == 0 || widget.latLng?.longitude == 0) {
        final position = await getCurrentPosition();

        final LatLng currentLocation =
            LatLng(position.latitude, position.longitude);
        setState(() {
          _pickedLocation = currentLocation;
        });
      } else {
        setState(() {
          _pickedLocation = widget.latLng;
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _controller?.animateCamera(CameraUpdate.newLatLng(_pickedLocation!));
  }

  void _onTap(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Your Location'),
      ),
      body: _pickedLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _pickedLocation!,
                    zoom: 15,
                  ),
                  onTap: _onTap,
                  markers: _pickedLocation == null
                      ? {}
                      : {
                          Marker(
                            markerId: const MarkerId('picked-location'),
                            position: _pickedLocation!,
                          ),
                        },
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Consumer(
                    builder: (context, ref, child) {
                      return ProButtonBasic(
                        text: "Update",
                        fontSize: 16,
                        fontColor: ProjectColors.white,
                        height: 45,
                        width: 200,
                        backgroundColor: ProjectColors.primary,
                        borderWidth: 1,
                        onTap: () {
                          if (_pickedLocation != null) {
                            ref
                                .read(updateLocationModelProvider.notifier)
                                .update(
                                  (state) => UpdateLocationModelRequest(
                                    email: widget.email,
                                    location: UpdatedLocation(
                                      latitude: _pickedLocation?.latitude,
                                      longitude: _pickedLocation?.longitude,
                                    ),
                                  ),
                                );

                            loader(screen: const UpdateLocationLoader());
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
