import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/widget/dashbboard/home_page.dart';
import 'package:tbs_app/widget/dashbboard/property/property_page.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 2;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  List<Widget> pages = [
    HomePage(),
    Container(child: Text('Tagihan Page')),
    PropertyPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        activeColor: Color(kPrimaryColor),
        color: Color(0xff9A9A9A),
        backgroundColor: Colors.white,
        curveSize: 75,
        items: [
          TabItem(icon: Icons.home_rounded, title: 'Home'),
          TabItem(
              icon: Image(image: AssetImage("assets/images/tagihan.png")),
              title: 'Tagihan'),
          TabItem(
              icon: Image(image: AssetImage("assets/images/property.png")),
              title: 'Property'),
          TabItem(icon: Icons.article_rounded, title: 'News'),
          TabItem(icon: Icons.person_rounded, title: 'Account'),
        ],
        initialActiveIndex: _currentIndex,
        onTap: (int i) {
          setState(() {
            this._currentIndex = i;
          });
        },
      ),
    );
  }
}
