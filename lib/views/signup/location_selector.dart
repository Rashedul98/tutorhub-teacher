import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tutorhub_teacher/utilities/functions/navigation.dart';
import 'package:tutorhub_teacher/views/signup/provider.dart';

import '../../models/signup/request.dart';
import '../../utilities/functions/get_position.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  GoogleMapController? _controller;
  LatLng? _pickedLocation;

  Future<void> _getCurrentLocation() async {
    try {
      final position = await getCurrentPosition();

      final LatLng currentLocation =
          LatLng(position.latitude, position.longitude);
      setState(() {
        _pickedLocation = currentLocation;
      });
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
        title: const Text('Pick Your Location'),
      ),
      body: _pickedLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
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
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          return FloatingActionButton(
            onPressed: () {
              if (_pickedLocation != null) {
                ref.read(signupRequestModelProvider.notifier).update(
                      (state) => state.copyWith(
                        location: Location(
                          latitude: _pickedLocation!.latitude,
                          longitude: _pickedLocation!.longitude,
                        ),
                      ),
                    );
              }
              pop();
            },
            child: const Icon(Icons.check),
          );
        },
      ),
    );
  }
}
