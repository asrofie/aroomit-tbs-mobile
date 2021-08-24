import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tbs_app/api/base_api.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/model/user_model.dart';

class AuthApi extends BaseApi {
  Future<LoginResponse> postLogin(String email, String password) async {
    Uri endpoint = Uri.parse(kServerUrl + "/api/v1/master/usrlgn");
    var response = await http.post(endpoint, body: {
      "userEmail": email,
      "userPassword": password
    }, headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
    });
    return LoginResponseFromJson(response.body);
  }
}

LoginResponse LoginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String LoginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.status,
    this.data,
  });

  bool? status;
  List<UserModel>? data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        data: List<UserModel>.from(
            json["data"].map((x) => UserModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
