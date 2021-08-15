import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tbs_app/api/auth_api.dart';

void main() {
  test('Api Login Test', () async {
    var api = AuthApi();
    var response = await api.postLogin('SEWA1@GMAIL.COM', '1123465');
    expect(response.status, true);
    expect(response.data!.length, 1);
  });
}
