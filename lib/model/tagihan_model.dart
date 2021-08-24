class TagihanModel {
  String? billCode;
  String? detailBillCode;
  String? periode;
  String? propertyCode;
  String? idTenantNumber;
  String? billStatus;
  String? typeBillName;
  String? rate;
  String? qty;
  String? totalRate;
  String? vat;
  String? totalVat;
  String? denda;
  String? statusPayment;
  String? statusPaymentName;
  String? grandTotal;

  TagihanModel(
      {this.billCode,
      this.detailBillCode,
      this.periode,
      this.propertyCode,
      this.idTenantNumber,
      this.billStatus,
      this.typeBillName,
      this.rate,
      this.qty,
      this.totalRate,
      this.vat,
      this.totalVat,
      this.denda,
      this.statusPayment,
      this.statusPaymentName,
      this.grandTotal});

  factory TagihanModel.fromJson(Map<String, dynamic> json) {
    return TagihanModel(
        billCode: json['BillCode'],
        detailBillCode: json['DetailBillCode'],
        periode: json['Periode'],
        propertyCode: json['PropertyCode'],
        idTenantNumber: json['IdTenantNumber'],
        billStatus: json['BillStatus'],
        typeBillName: json['TypeBillName'],
        rate: json['Rate'],
        qty: json['Qty'],
        totalRate: json['TotalRate'],
        vat: json['Vat'],
        totalVat: json['TotalVat'],
        denda: json['Denda'],
        statusPayment: json['StatusPayment'],
        statusPaymentName: json['StatusPaymentName'],
        grandTotal: json['GrandTotal']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BillCode'] = this.billCode;
    data['DetailBillCode'] = this.detailBillCode;
    data['Periode'] = this.periode;
    data['PropertyCode'] = this.propertyCode;
    data['IdTenantNumber'] = this.idTenantNumber;
    data['BillStatus'] = this.billStatus;
    data['TypeBillName'] = this.typeBillName;
    data['Rate'] = this.rate;
    data['Qty'] = this.qty;
    data['TotalRate'] = this.totalRate;
    data['Vat'] = this.vat;
    data['TotalVat'] = this.totalVat;
    data['Denda'] = this.denda;
    data['StatusPayment'] = this.statusPayment;
    data['StatusPaymentName'] = this.statusPaymentName;
    data['GrandTotal'] = this.grandTotal;
    return data;
  }
}
