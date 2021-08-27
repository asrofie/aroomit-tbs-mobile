import 'package:flutter/material.dart';
import 'package:tbs_app/widget/setup/setup_page.dart';
import 'package:tbs_app/widget/login/login_page.dart';
import 'package:tbs_app/widget/dashbboard/main_page.dart';
import 'package:tbs_app/widget/tagihan/tagihan_page.dart';
import 'package:tbs_app/widget/news_detail/news_detail_page.dart';

const kRouteSetup = "/setup";
const kRouteLogin = "/login";
const kRouteForgot = "/forgot";
const kRouteMain = "/main";
const kRouteTagihan = "/tagihan";
const kRouteNewsDetail = "/news";

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case kRouteSetup:
      return MaterialPageRoute(builder: (context) => SetupPage());
    case kRouteLogin:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case kRouteMain:
      return MaterialPageRoute(builder: (context) => MainPage());
    case kRouteTagihan:
      return MaterialPageRoute(builder: (context) => TagihanPage());
    case kRouteNewsDetail:
      {
        var NewsId = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => NewsDetailPage(newsId: NewsId.toString()));
      }
  }
  return MaterialPageRoute(builder: (context) => SetupPage());
}
