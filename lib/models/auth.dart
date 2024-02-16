class Auth {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? profile;
  String? status;
  int? doctorId;

  Auth({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profile,
    this.doctorId,
    this.status,
  });

  Auth.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    phone = data["phone"];
    profile = data["profile"];
    status = data["status"];
    if (data["doctor_id"] != null) {
      doctorId = data["doctor_id"];
    }
  }
}
