class UserModel {
  String? companyCode;
  String? companyName;
  String? idTenantNumber;
  String? nik;
  String? tenantName;
  String? address;
  String? tenantEmail;
  String? tenantPhone;
  String? deviceID;
  String? iconImage;
  String? appName;

  UserModel(
      {this.companyCode,
      this.companyName,
      this.idTenantNumber,
      this.nik,
      this.tenantName,
      this.address,
      this.tenantEmail,
      this.tenantPhone,
      this.deviceID,
      this.iconImage,
      this.appName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      companyCode: json['CompanyCode'],
      companyName: json['CompanyName'],
      idTenantNumber: json['IdTenantNumber'],
      nik: json['Nik'],
      tenantName: json['TenantName'],
      address: json['Address'],
      tenantEmail: json['TenantEmail'],
      tenantPhone: json['TenantPhone'],
      deviceID: json['DeviceID'],
      iconImage: json['IconImage'],
      appName: json['AppName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyCode'] = this.companyCode;
    data['CompanyName'] = this.companyName;
    data['IdTenantNumber'] = this.idTenantNumber;
    data['Nik'] = this.nik;
    data['TenantName'] = this.tenantName;
    data['Address'] = this.address;
    data['TenantEmail'] = this.tenantEmail;
    data['TenantPhone'] = this.tenantPhone;
    data['DeviceID'] = this.deviceID;
    data['IconImage'] = this.iconImage;
    data['AppName'] = this.appName;
    return data;
  }
}
