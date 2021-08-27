import 'package:flutter/material.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/widget/setup/setup_page.dart';
import 'package:tbs_app/widget/login/login_page.dart';
import 'package:tbs_app/widget/dashbboard/main_page.dart';
import 'package:tbs_app/widget/tagihan/tagihan_page.dart';
import 'package:tbs_app/widget/news_detail/news_detail_page.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: label_app,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        fontFamily: 'Roboto',
        primarySwatch: MaterialColor(kPrimaryColor, colorCodes),
      ),
      home: NewsDetailPage(),
    );
  }
}
