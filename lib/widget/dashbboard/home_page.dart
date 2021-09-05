import 'package:flutter/material.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/bloc/home_cubit.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:tbs_app/bloc/app_cubit.dart';

class GridContentModel {
  String title;
  int total;
  Widget icon;
  Color color;
  GridContentModel(this.title, this.total, this.icon, this.color);
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  UserModel? user;
  List<GridContentModel> GridContent = [
    GridContentModel(
        "Property",
        10,
        Image(
          image: AssetImage("assets/images/property.png"),
          height: 48,
          width: 48,
        ),
        Colors.lightGreen),
    GridContentModel(
        "Tagihan",
        3,
        Image(
          image: AssetImage("assets/images/tagihan.png"),
          height: 48,
          width: 48,
        ),
        Colors.redAccent),
    GridContentModel(
        "Notifikasi",
        10,
        Icon(
          Icons.notifications,
          color: Colors.white,
          size: 48,
        ),
        Colors.orange),
    GridContentModel(
        "News",
        20,
        Icon(
          Icons.article,
          color: Colors.white,
          size: 48,
        ),
        Colors.cyan),
  ];
  @override
  Widget build(BuildContext mainContext) {
    return BlocConsumer(
        bloc: BlocProvider.of<HomeCubit>(mainContext),
        listener: (context, state) {
          if (state is PageInitState) {
            BlocProvider.of<AppCubit>(mainContext).fetchUser();
          }
          if (state is OnLoggedUser) {
            setState(() {
              user = state.user;
            });
          }
        },
        builder: (context, state) {
          String tenantName = "-uuuu";
          String appName = label_app;
          if (user != null) {
            tenantName = user!.tenantName!;
            appName = user!.appName!;
          }
          return Scaffold(
            body: Stack(
              children: <Widget>[
                Container(
                  child: Image(
                    image: AssetImage("assets/images/home_bg.png"),
                  ),
                ),
                Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      title: Text(
                        appName,
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: GestureDetector(
                            child: Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                      backgroundColor: Color(kPrimaryColor).withOpacity(0.5),
                      elevation: 3,
                    ),
                    body: Container(
                      child: Center(
                        heightFactor: 0.6,
                        child: Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: kBaseMargin),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 135),
                                  child: Center(
                                      child: ClipOval(
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      height: 120,
                                      width: 120,
                                      child: ClipOval(
                                          child: Image(
                                        image: NetworkImage(
                                            "https://i.pravatar.cc/120"),
                                      )),
                                    ),
                                  )),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 24),
                                  child: Text(tenantName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 1.0,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                            Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 8.0,
                                              color: Color.fromARGB(
                                                  125, 0, 0, 255),
                                            ),
                                          ])),
                                ),
                                Container(
                                    width: 400,
                                    child: GridView.count(
                                      childAspectRatio: 2,
                                      crossAxisCount: 2,
                                      shrinkWrap: true,
                                      children: List.generate(4, (index) {
                                        return Container(
                                          width: 10,
                                          height: 10,
                                          child: Card(
                                            color: GridContent[index].color,
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                      child: Center(
                                                          child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${GridContent[index].total}",
                                                        style: TextStyle(
                                                            fontSize: 32,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                      Text(
                                                          GridContent[index]
                                                              .title,
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black26,
                                                          )),
                                                    ],
                                                  ))),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GridContent[index].icon,
                                                      ]),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ))
                              ],
                            )),
                      ),
                    )),
              ],
            ),
          );
        });
  }
}
