class SigninResponseModel {
  bool? success;
  String? token;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? school;
  String? college;
  String? address;
  double? latitude;
  double? longitude;
  String? error;

  SigninResponseModel(
      {this.success,
      this.token,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.school,
      this.college,
      this.address,
      this.latitude,
      this.longitude,
      this.error});

  SigninResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    school = json['school'];
    college = json['college'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    error = json['error'];
  }
}
