class UpdateLocationModelRequest {
  String? email;
  UpdatedLocation? location;

  UpdateLocationModelRequest({this.email, this.location});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class UpdatedLocation {
  double? latitude;
  double? longitude;

  UpdatedLocation({this.latitude, this.longitude});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
