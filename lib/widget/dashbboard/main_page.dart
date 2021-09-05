import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:tbs_app/bloc/property_cubit.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/routes.dart' as route;
import 'package:tbs_app/widget/dashbboard/home_page.dart';
import 'package:tbs_app/widget/dashbboard/property/property_page.dart';
import 'package:tbs_app/widget/dashbboard/news/news_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:tbs_app/bloc/app_cubit.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  List<Widget> pages = [
    HomePage(),
    PropertyPage(),
    NewsPage(),
    Container(child: Text('Account Page')),
  ];

  @override
  Widget build(BuildContext mainContext) {
    return BlocConsumer<AppCubit, AppState>(
        bloc: BlocProvider.of<AppCubit>(mainContext),
        builder: (context, state) {
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
                    icon:
                        Image(image: AssetImage("assets/images/property.png")),
                    title: 'Property'),
                TabItem(icon: Icons.article_rounded, title: 'News'),
                TabItem(icon: Icons.person_rounded, title: 'Account'),
              ],
              initialActiveIndex: _currentIndex,
              onTap: (int i) {
                setState(() {
                  this._currentIndex = i;
                });
                if (i == 1) {
                  AppCubit app = BlocProvider.of<AppCubit>(context);
                  app.changePage(context, "property");
                }
              },
            ),
          );
        },
        listener: (context, state) {
          if (state is ForceLogout) {
            BlocProvider.of<AppCubit>(mainContext).doLogout();
            Navigator.of(mainContext).pushReplacementNamed(route.kRouteLogin);
          }
        });
  }
}
