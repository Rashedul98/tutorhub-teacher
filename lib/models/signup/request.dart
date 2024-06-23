class SignupRequestModel {
  String? firstName;
  String? lastName;
  String? gender;
  String? phone;
  String? educationalQualification;
  List<Expertise>? expertise;
  Location? location;
  String? email;
  String? password;

  SignupRequestModel({
    this.firstName,
    this.lastName,
    this.gender,
    this.phone,
    this.educationalQualification,
    this.expertise,
    this.location,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['Gender'] = gender;
    data['Phone'] = phone;
    data['educational_qualification'] = educationalQualification;
    if (expertise != null) {
      data['Expertise'] = expertise!.map((v) => v.toJson()).toList();
    }
    if (location != null) {
      data['Location'] = location!.toJson();
    }
    data['email'] = email;
    data['password'] = password;

    return data;
  }

  SignupRequestModel copyWith({
    String? firstName,
    String? lastName,
    String? gender,
    String? phone,
    String? educationalQualification,
    List<Expertise>? expertise,
    Location? location,
    String? email,
    String? password,
  }) {
    return SignupRequestModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      educationalQualification:
          educationalQualification ?? this.educationalQualification,
      expertise: expertise ?? this.expertise,
      location: location ?? this.location,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class Expertise {
  String? subject;
  String? scope;

  Expertise({this.subject, this.scope});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = subject;
    data['scope'] = scope;
    return data;
  }

  Expertise copyWith({
    String? subject,
    String? scope,
  }) {
    return Expertise(
        subject: subject ?? this.subject, scope: scope ?? this.scope);
  }

  map(Function(dynamic v) param0) {}
}

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }

  Location copyWith({
    double? latitude,
    double? longitude,
  }) {
    return Location(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude);
  }
}
