import 'package:flutter/material.dart';
import 'package:tbs_app/model/property_model.dart';
import 'package:tbs_app/model/news_model.dart';

class ApiResponse<T> {
  bool? status;
  T? data;
  ApiResponse({this.status, this.data});
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

class ListNewsResponse extends ApiResponse<List<NewsModel>> {
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
