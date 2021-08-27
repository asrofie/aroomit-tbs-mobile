import 'package:flutter_test/flutter_test.dart';
import 'package:tbs_app/api/api_service.dart';
import 'package:tbs_app/api/auth_api.dart';

void main() {
  test('Api Login Test', () async {
    var api = AuthApi();
    var response = await api.postLogin('SEWA1@GMAIL.COM', '1123465');
    expect(response.status, true);
    expect(response.data!.length, 1);
  });

  test('List Property', () async {
    var api = ApiService();
    var response = await api.findByTenant('T0002');
    expect(response.status, true);
    expect(response.data!.length, 2);
  });

  test('List News', () async {
    var api = ApiService();
    var response = await api.findNews("C02");
    expect(response.status, true);
    expect(response.data!.length, 2);
  });

  test('Detail News', () async {
    var api = ApiService();
    var response = await api.getNews("C02", "5ead77b433c0f");
    expect(response.status, true);
    expect(response.data!.length, 1);
  });

  test('List Tagihan', () async {
    var api = ApiService();
    var response = await api.findTagihan("T0001", "P01");
    expect(response.status, true);
    expect(response.data!.length, 2);
  });
}
