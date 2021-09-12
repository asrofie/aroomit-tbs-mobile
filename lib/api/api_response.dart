import 'package:tbs_app/model/property_model.dart';
import 'package:tbs_app/model/news_model.dart';
import 'package:tbs_app/model/tagihan_model.dart';
import 'package:tbs_app/model/user_model.dart';

class ApiResponse<T> {
  bool? status;
  T? data;
  String? message;
  ApiResponse({this.status, this.data, this.message});
}

class ListPropertyResponse extends ApiResponse {
  ListPropertyResponse(status, data) : super(status: status, data: data);
  factory ListPropertyResponse.fromJson(Map<String, dynamic> json) {
    var status = json['status'];
    List<PropertyModel> data = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(PropertyModel.fromJson(v));
      });
    }
    return ListPropertyResponse(status, data);
  }
}

class ListNewsResponse extends ApiResponse {
  ListNewsResponse(status, data) : super(status: status, data: data);
  factory ListNewsResponse.fromJson(Map<String, dynamic> json) {
    var status = json['status'];
    List<NewsModel> data = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(NewsModel.fromJson(v));
      });
    }
    return ListNewsResponse(status, data);
  }
}

class NewsDetailResponse extends ApiResponse {
  NewsDetailResponse(status, data, message)
      : super(status: status, data: data, message: message);
  factory NewsDetailResponse.fromJson(Map<String, dynamic> json) {
    var status = json['status'];
    NewsModel? data;
    String? message;
    if (json['data'] != null) {
      if (json['data'] is String) {
        message = json['data'];
      } else {
        data = NewsModel.fromJson(json['data'][0]);
      }
    }
    return NewsDetailResponse(status, data, message);
  }
}

class ListTagihanResponse extends ApiResponse {
  ListTagihanResponse(status, data, message)
      : super(status: status, data: data, message: message);
  factory ListTagihanResponse.fromJson(Map<String, dynamic> json) {
    var status = json['status'];
    var message = null;
    List<TagihanModel> data = [];
    if (json['data'] is String) {
      message = json['data'];
    } else if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(TagihanModel.fromJson(v));
      });
    }
    return ListTagihanResponse(status, data, message);
  }
}

class LoginResponse extends ApiResponse {
  LoginResponse(status, data, message)
      : super(status: status, data: data, message: message);
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    var status = json['status'];
    List<UserModel> data = [];
    String? mesage = null;
    if (status && json['data'] != null) {
      json['data'].forEach((v) {
        data.add(UserModel.fromJson(v));
      });
    } else {
      mesage = json['data'];
    }
    return LoginResponse(status, data, mesage);
  }
}

class ForgotResponse extends ApiResponse {
  ForgotResponse(status, data, message)
      : super(status: status, data: data, message: message);
  factory ForgotResponse.fromJson(Map<String, dynamic> json) {
    var status = json['status'];
    String mesage = "Tidak terhubung server";
    if (json['data'] != null) {
      mesage = json['data'];
    }
    return ForgotResponse(status, [], mesage);
  }
}

class RegisterResponse extends ApiResponse {
  RegisterResponse(status, data, message)
      : super(status: status, data: data, message: message);
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    var status = json['status'];
    String mesage = "Tidak terhubung server";
    if (json['data'] != null) {
      mesage = json['data'];
    }
    return RegisterResponse(status, [], mesage);
  }
}
