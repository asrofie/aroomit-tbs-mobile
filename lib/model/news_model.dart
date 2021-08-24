import 'package:flutter/material.dart';

class NewsModel {
  String? newsContent;
  String? newsId;
  String? newsTitle;
  String? newsBanner;
  String? videoFlag;
  String? videoUrl;

  NewsModel(
      {this.newsContent,
      this.newsId,
      this.newsTitle,
      this.newsBanner,
      this.videoFlag,
      this.videoUrl});

  NewsModel.fromJson(Map<String, dynamic> json) {
    newsContent = json['NewsContent'];
    newsId = json['NewsId'];
    newsTitle = json['NewsTitle'];
    newsBanner = json['NewsBanner'];
    videoFlag = json['VideoFlag'];
    videoUrl = json['VideoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NewsContent'] = this.newsContent;
    data['NewsId'] = this.newsId;
    data['NewsTitle'] = this.newsTitle;
    data['NewsBanner'] = this.newsBanner;
    data['VideoFlag'] = this.videoFlag;
    data['VideoUrl'] = this.videoUrl;
    return data;
  }
}
