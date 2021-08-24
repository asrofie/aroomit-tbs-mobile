import 'package:tbs_app/api/api_response.dart';

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

const news = {
  "status": true,
  "data": [
    {
      "NewsContent":
          "&lt;p&gt;&lt;strong&gt;#1: Cek Oli&lt;\/strong&gt;&lt;br \/&gt;Oli mobil harus diganti setiap 5.000-10.000 km untuk memastikan mesin mobil tetap bekerja dengan optimal. Salah satu cara mengetahui oli mobil sudah harus diganti adalah dengan meneteskan sedikit oli di tangan Anda dan merasakan apakah terdapat serpihan-serpihan halus di dalamnya. Jika Anda dapat merasakan serpihan atau kotoran, maka sudah saatnya Anda mengganti oli mobil&lt;br \/&gt;&lt;strong&gt;#2: Pastikan Kopling Berfungsi Normal&lt;\/strong&gt;&lt;\/p&gt;&lt;p&gt;Tips ini berlaku jika mobil Anda bertransmisi manual. Jika kampas kopling Anda sudah mulai aus, maka perpindahan gigi akan semakin berat dan dapat mengganggu kenyamanan berkendara Anda. Persneling yang sulit dipindah merupakan salah satu indikasi kampas kopling mobil Anda mulai aus.&lt;\/p&gt;&lt;p&gt;&lt;strong&gt;#3: Isi Air Radiator Secukupnya&lt;\/strong&gt;&lt;\/p&gt;&lt;p&gt;Air radiator berfungsi untuk mendinginkan mesin saat sedang bekerja. Pastikan Anda mengisi air di tabung radiator secara berkala agar mesin dapat bekerja dengan baik. Selain itu, jika Anda cukup sering menggunakan air wiper, isi tabung air wiper dengan air bersih jika air sudah mulai habis.&lt;\/p&gt;",
      "NewsId": "5ead77b433c0f",
      "NewsTitle": "3 Tips Merawat Kendaraan",
      "NewsBanner": "mesin-overheat-42.jpg",
      "VideoFlag": "0",
      "VideoUrl": ""
    },
    {
      "NewsContent":
          "Di video kali ini kami memberikan tips pemeriksaan kendaraan kalian sebelum bepergian.",
      "NewsId": "5ef05d1794d32",
      "NewsTitle": "Video : tips pemeriksaan kendaraan",
      "NewsBanner": "26231044_1736708449713357_5321506511020103734_n.jpg",
      "VideoFlag": "1",
      "VideoUrl": "G2bKuITH4MQ"
    }
  ]
};

Future<ListNewsResponse> mockListNews() {
  return Future.delayed(
      const Duration(seconds: 2), () => ListNewsResponse.fromJson(news));
}
