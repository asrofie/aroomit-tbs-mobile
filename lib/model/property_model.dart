class PropertyModel {
  String? tenantName;
  String? nik;
  String? propertyCode;
  String? towerBuilding;
  String? propertyTypeName;
  String? floorNumber;
  String? roomNumber;
  String? roomType;
  String? roomM2;
  String? propertyStatus;
  String? idTenantNumber;

  PropertyModel(
      {this.tenantName,
      this.nik,
      this.propertyCode,
      this.towerBuilding,
      this.propertyTypeName,
      this.floorNumber,
      this.roomNumber,
      this.roomType,
      this.roomM2,
      this.propertyStatus,
      this.idTenantNumber});

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
        tenantName: json['TenantName'],
        nik: json['Nik'],
        propertyCode: json['PropertyCode'],
        towerBuilding: json['TowerBuilding'],
        propertyTypeName: json['PropertyTypeName'],
        floorNumber: json['FloorNumber'],
        roomNumber: json['RoomNumber'],
        roomType: json['RoomType'],
        roomM2: json['RoomM2'],
        propertyStatus: json['PropertyStatus'],
        idTenantNumber: json['IdTenantNumber']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TenantName'] = this.tenantName;
    data['Nik'] = this.nik;
    data['PropertyCode'] = this.propertyCode;
    data['TowerBuilding'] = this.towerBuilding;
    data['PropertyTypeName'] = this.propertyTypeName;
    data['FloorNumber'] = this.floorNumber;
    data['RoomNumber'] = this.roomNumber;
    data['RoomType'] = this.roomType;
    data['RoomM2'] = this.roomM2;
    data['PropertyStatus'] = this.propertyStatus;
    data['IdTenantNumber'] = this.idTenantNumber;
    return data;
  }
}
