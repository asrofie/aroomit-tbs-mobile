import 'package:tbs_app/api/api_response.dart';
import 'package:tbs_app/model/property_model.dart';
import 'package:tbs_app/model/tagihan_model.dart';
import 'package:tbs_app/model/news_model.dart';

const propertyByTenant = {
  "status": true,
  "data": [
    {
      "TenantName": "LILI",
      "Nik": "321014210410413",
      "PropertyCode": "P01",
      "TowerBuilding": "Mawar",
      "PropertyTypeName": "APARTEMENT",
      "FloorNumber": "1",
      "RoomNumber": "1",
      "RoomType": "std",
      "RoomM2": "30.0",
      "PropertyStatus": "1",
      "IdTenantNumber": "T0002"
    },
    {
      "TenantName": "LILI",
      "Nik": "321014210410413",
      "PropertyCode": "P02",
      "TowerBuilding": "A",
      "PropertyTypeName": "APARTEMENT",
      "FloorNumber": "1",
      "RoomNumber": "2",
      "RoomType": "std",
      "RoomM2": "30.0",
      "PropertyStatus": "1",
      "IdTenantNumber": "T0002"
    }
  ]
};

Future<ListPropertyResponse> mockListProperty() {
  return Future.delayed(const Duration(seconds: 2),
      () => ListPropertyResponse.fromJson(propertyByTenant));
}

List<PropertyModel> mockListPropertyOnly() {
  return (ListPropertyResponse.fromJson(propertyByTenant)).data;
}

const news = {
  "status": true,
  "data": [
    {
      "NewsContent":
          "&lt;p&gt;&lt;strong&gt;#1: Cek Oli&lt;\/strong&gt;&lt;br \/&gt;Oli mobil harus diganti setiap 5.000-10.000 km untuk memastikan mesin mobil tetap bekerja dengan optimal. Salah satu cara mengetahui oli mobil sudah harus diganti adalah dengan meneteskan sedikit oli di tangan Anda dan merasakan apakah terdapat serpihan-serpihan halus di dalamnya. Jika Anda dapat merasakan serpihan atau kotoran, maka sudah saatnya Anda mengganti oli mobil&lt;br \/&gt;&lt;strong&gt;#2: Pastikan Kopling Berfungsi Normal&lt;\/strong&gt;&lt;\/p&gt;&lt;p&gt;Tips ini berlaku jika mobil Anda bertransmisi manual. Jika kampas kopling Anda sudah mulai aus, maka perpindahan gigi akan semakin berat dan dapat mengganggu kenyamanan berkendara Anda. Persneling yang sulit dipindah merupakan salah satu indikasi kampas kopling mobil Anda mulai aus.&lt;\/p&gt;&lt;p&gt;&lt;strong&gt;#3: Isi Air Radiator Secukupnya&lt;\/strong&gt;&lt;\/p&gt;&lt;p&gt;Air radiator berfungsi untuk mendinginkan mesin saat sedang bekerja. Pastikan Anda mengisi air di tabung radiator secara berkala agar mesin dapat bekerja dengan baik. Selain itu, jika Anda cukup sering menggunakan air wiper, isi tabung air wiper dengan air bersih jika air sudah mulai habis.&lt;\/p&gt;",
      "NewsId": "5ead77b433c0f",
      "NewsTitle": "Tips Parkir di Apartment",
      "NewsBanner": "tbs.aroomit.com\/asset\/img\/berita1.jpg",
      "VideoFlag": "0",
      "VideoUrl": ""
    },
    {
      "NewsContent":
          "Di video kali ini kami memberikan tips pemeriksaan kendaraan kalian sebelum bepergian.",
      "NewsId": "5ef05d1794d32",
      "NewsTitle": "Video : tips keamanan di Apartment",
      "NewsBanner": "tbs.aroomit.com\/asset\/img\/berita2.jpg",
      "VideoFlag": "1",
      "VideoUrl": "LyOm4SuhkNw"
    }
  ]
};

Future<ListNewsResponse> mockListNews() {
  return Future.delayed(
      const Duration(seconds: 2), () => ListNewsResponse.fromJson(news));
}

const listTagihanResponseJson = {
  "status": true,
  "data": [
    {
      "BillCode": "BIL0001",
      "DetailBillCode": "DBIL0001-0001",
      "Periode": "2021-07-21",
      "PropertyCode": "P01",
      "IdTenantNumber": "T0001",
      "BillStatus": "0",
      "TypeBillName": "AIR",
      "Rate": "1200",
      "Qty": "2.00",
      "TotalRate": "2400",
      "Vat": "10.00",
      "TotalVat": "240.00",
      "Denda": "0.00",
      "StatusPayment": "1",
      "StatusPaymentName": "Paid",
      "GrandTotal": "2640.00"
    },
    {
      "BillCode": "BIL0001",
      "DetailBillCode": "DBIL0001-0002",
      "Periode": "2021-07-21",
      "PropertyCode": "P01",
      "IdTenantNumber": "T0001",
      "BillStatus": "0",
      "TypeBillName": "IPL",
      "Rate": "10000",
      "Qty": "1.00",
      "TotalRate": "10000",
      "Vat": "10.00",
      "TotalVat": "100.00",
      "Denda": "0.00",
      "StatusPayment": "0",
      "StatusPaymentName": "UnPaid",
      "GrandTotal": "10100.00"
    }
  ]
};

List<TagihanModel> sampleListTagihan() {
  return (ListTagihanResponse.fromJson(listTagihanResponseJson)).data;
}

List<NewsModel> sampleListNews() {
  return (ListNewsResponse.fromJson(news)).data;
}
