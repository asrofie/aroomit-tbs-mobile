import 'package:flutter/material.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/bloc/login_cubit.dart';
import 'package:tbs_app/bloc/login_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/routes.dart' as route;

class LoginPage extends StatelessWidget {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controllerPassword.text = "1123465";
    controllerUsername.text = "SEWA1@GMAIL.COM";
    return buildLoginPage(context);
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      callback();
    });
  }

  buildLoginPage(BuildContext mainContext) {
    return Scaffold(
        body: BlocConsumer<LoginCubit, AppState>(
            bloc: BlocProvider.of<LoginCubit>(mainContext),
            listener: (context, state) {
              if (state is AlreadyLoginState) {
                _onWidgetDidBuild(() {
                  Navigator.pushReplacementNamed(context, route.kRouteMain);
                });
              } else if (state is SuccessLoginState) {
                _onWidgetDidBuild(() {
                  Navigator.pushReplacementNamed(context, route.kRouteMain);
                });
              } else if (state is FailureLoginState) {
                ScaffoldMessenger.of(mainContext).showSnackBar(SnackBar(
                  content: Text(state.errorMessage),
                  duration: Duration(seconds: 3),
                ));
              } else if (state is PageInitState) {
                BlocProvider.of<LoginCubit>(mainContext).loginCheck();
              }
            },
            builder: (ctx, state) {
              return SafeArea(
                  maintainBottomViewPadding: true,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: kBaseMargin),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(top: 32),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(kRadius),
                                    child: Image(
                                      image: NetworkImage(
                                          "https://via.placeholder.com/100x100.png?text=TBS"),
                                    ),
                                  )),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 32),
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          text: "SIGN IN/UP",
                                          style: TextStyle(
                                            height: 1.3,
                                            fontFamily: 'Roboto',
                                            fontSize: 18,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          )))),
                              Material(
                                  elevation: 0,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(kRadius),
                                      topRight: Radius.circular(kRadius)),
                                  child: Container(
                                    height: 400,
                                    padding: EdgeInsets.only(
                                        top: kBaseMargin,
                                        left: kBaseMargin,
                                        right: kBaseMargin),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          // decoration: BoxDecoration(color: Colors.green),
                                          margin: EdgeInsets.only(top: 8),
                                          child: Material(
                                              elevation: kElevation,
                                              child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 4),
                                                  child: TextFormField(
                                                    controller:
                                                        controllerUsername,
                                                    keyboardType:
                                                        TextInputType.url,
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                right: 16),
                                                        labelText: "Email user",
                                                        labelStyle: TextStyle(
                                                            color:
                                                                Colors.black26,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize:
                                                                kFontSizeSmall),
                                                        prefixIcon: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16),
                                                          child: Icon(
                                                              Icons.mail,
                                                              color: Colors
                                                                  .black26),
                                                        ),
                                                        border:
                                                            InputBorder.none),
                                                    validator: (text) {
                                                      if (text!.isEmpty) {
                                                        return "Email tidak boleh kosong";
                                                      }
                                                      return null;
                                                    },
                                                  ))),
                                        ),
                                        Container(
                                          // decoration: BoxDecoration(color: Colors.green),
                                          margin:
                                              EdgeInsets.only(top: kBaseMargin),
                                          child: Material(
                                              elevation: kElevation,
                                              child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 4),
                                                  child: TextFormField(
                                                    controller:
                                                        controllerPassword,
                                                    obscureText: true,
                                                    onTap: () {},
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                right: 16),
                                                        labelText: "Password",
                                                        labelStyle: TextStyle(
                                                          color: Colors.black26,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 14,
                                                        ),
                                                        prefixIcon: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        16),
                                                            child: Icon(
                                                              Icons.lock,
                                                              color: Colors
                                                                  .black26,
                                                            )),
                                                        border:
                                                            InputBorder.none),
                                                    validator: (text) {
                                                      if (text!.length == 0) {
                                                        return "Password tidak boleh kosong";
                                                      }
                                                      return null;
                                                    },
                                                  ))),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: 32, bottom: 100),
                                            child: MaterialButton(
                                              child: IntrinsicWidth(
                                                  child: Text(
                                                "SUBMIT".toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Arial',
                                                    letterSpacing: 1.4),
                                              )),
                                              onPressed: () async {
                                                BlocProvider.of<LoginCubit>(
                                                        mainContext)
                                                    .login(
                                                        controllerUsername.text,
                                                        controllerPassword
                                                            .text);
                                              },
                                              elevation: 5,
                                              padding: EdgeInsets.all(0),
                                              color: Color(kPrimaryColor),
                                              height: 48,
                                              minWidth: double.infinity,
                                            )),
                                        Container(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text("Dengan submit kamu setuju ",
                                                style: TextStyle(
                                                  height: 1.3,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: kFontSizeSmall,
                                                  color: Colors.black45,
                                                )),
                                          ],
                                        )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            InkWell(
                                              child: Text(
                                                  "Syarat dan Ketentuan",
                                                  style: TextStyle(
                                                    height: 1.3,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: kFontSizeSmall,
                                                    color: Colors.blueAccent,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              onTap: () =>
                                                  launch("https://google.com"),
                                            ),
                                            Text(" dan ",
                                                style: TextStyle(
                                                  height: 1.3,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: kFontSizeSmall,
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            InkWell(
                                              child: Text("Kebijakan Privasi",
                                                  style: TextStyle(
                                                    height: 1.3,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: kFontSizeSmall,
                                                    color: Colors.blueAccent,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              onTap: () =>
                                                  launch("https://google.com"),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ));
            }));
  }
}
