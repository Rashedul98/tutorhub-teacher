class UpdateTutionModelReq {
  String? id;
  String? status;
  int? fee;

  UpdateTutionModelReq({this.id, this.status, this.fee});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['fee'] = fee;
    return data;
  }

  UpdateTutionModelReq copyWith({
    String? id,
    String? status,
    int? fee,
  }) {
    return UpdateTutionModelReq(
      id: id ?? this.id,
      status: status ?? this.status,
      fee: fee ?? this.fee,
    );
  }
}
