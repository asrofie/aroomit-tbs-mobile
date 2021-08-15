class UserModel {
  UserModel({
    this.idTenantNumber,
    this.nik,
    this.tenantName,
    this.address,
    this.tenantEmail,
    this.tenantPhone,
    this.passwordApp,
    this.deviceId,
    this.status,
  });

  String? idTenantNumber;
  String? nik;
  String? tenantName;
  String? address;
  String? tenantEmail;
  String? tenantPhone;
  String? passwordApp;
  String? deviceId;
  String? status;

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
        idTenantNumber: json["IdTenantNumber"],
        nik: json["Nik"],
        tenantName: json["TenantName"],
        address: json["Address"],
        tenantEmail: json["TenantEmail"],
        tenantPhone: json["TenantPhone"],
        passwordApp: json["PasswordApp"],
        deviceId: json["DeviceID"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "IdTenantNumber": idTenantNumber,
        "Nik": nik,
        "TenantName": tenantName,
        "Address": address,
        "TenantEmail": tenantEmail,
        "TenantPhone": tenantPhone,
        "PasswordApp": passwordApp,
        "DeviceID": deviceId,
        "Status": status,
      };
}
