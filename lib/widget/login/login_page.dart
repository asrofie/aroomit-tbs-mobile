import 'package:flutter/material.dart';
import 'package:tbs_app/bloc/app_cubit.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:tbs_app/component/my_button.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/bloc/login_cubit.dart';
import 'package:tbs_app/bloc/login_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/routes.dart' as route;
import 'package:tbs_app/component/my_text_input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  final PAGE_LOGIN = "page_login";
  final PAGE_FORGOT = "page_forgot";
  final PAGE_REGISTER = "page_register";

  _LoginPage() {
    page = PAGE_LOGIN;
  }

  String page = "login";
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerUrl = TextEditingController();
  late AppCubit appCubit;
  @override
  Widget build(BuildContext context) {
    // controllerPassword.text = "1123465";
    // controllerUsername.text = "SEWA1@GMAIL.COM";
    // controllerUrl.text = kServerUrl;
    return buildLoginPage(context);
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((duration) {
      appCubit.loginCheck();
      appCubit.urlCheck();
    });
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      callback();
    });
  }

  buildLoginPage(BuildContext mainContext) {
    appCubit = BlocProvider.of<AppCubit>(mainContext);
    return Scaffold(
      body: BlocConsumer<AppCubit, AppState>(
        bloc: BlocProvider.of<AppCubit>(mainContext),
        listener: (context, _appState) {
          if (_appState is AlreadyLoginState) {
            _onWidgetDidBuild(() {
              Navigator.pushReplacementNamed(context, route.kRouteMain);
            });
          }
          if (_appState is FoundUrlState) {
            controllerUrl.text = _appState.url;
          }
        },
        builder: (contxt, state) {
          return BlocConsumer<LoginCubit, AppState>(
              bloc: BlocProvider.of<LoginCubit>(mainContext),
              listener: (context, state) {
                if (state is SuccessLoginState) {
                  _onWidgetDidBuild(() {
                    AppCubit app = BlocProvider.of<AppCubit>(mainContext);
                    app.loggedIn(state.userModel!, controllerUrl.text);
                    Navigator.pushReplacementNamed(context, route.kRouteMain);
                  });
                } else if (state is FailureLoginState) {
                  ScaffoldMessenger.of(mainContext).showSnackBar(SnackBar(
                    content: Text(state.errorMessage),
                    duration: Duration(seconds: 3),
                  ));
                } else if (state is PageInitState) {
                  BlocProvider.of<AppCubit>(mainContext).loginCheck();
                } else if (state is SuccessApiState) {
                  ScaffoldMessenger.of(mainContext).showSnackBar(SnackBar(
                    content: Text(state.response.message!),
                    duration: Duration(seconds: 3),
                  ));
                  if (state.response.status!) {
                    setState(() {
                      page = PAGE_LOGIN;
                    });
                  }
                } else if (state is NoInternetState) {
                  ScaffoldMessenger.of(mainContext).showSnackBar(SnackBar(
                    content: Text("No internet connection"),
                    duration: Duration(seconds: 3),
                  ));
                }
              },
              builder: (ctx, state) {
                final heightForm =
                    MediaQuery.of(mainContext).size.height * 0.57;
                final widthForm = MediaQuery.of(mainContext).size.width * 0.5;
                String labelButton = "Login";
                if (page == PAGE_FORGOT) {
                  labelButton = "Submit";
                } else if (page == PAGE_REGISTER) {
                  labelButton = "Register";
                }
                return SafeArea(
                    maintainBottomViewPadding: true,
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                color: Color(kPrimaryColor),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/setup_bg.png"),
                                    fit: BoxFit.fitHeight,
                                    alignment: Alignment.center))),
                        Center(
                          child: Padding(
                              padding: EdgeInsets.only(top: 54),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      child: Container(
                                        height: heightForm,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: kBaseMargin),
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: kBaseMargin),
                                              child: Text(
                                                "Selamat Datang",
                                                style: TextStyle(
                                                    fontFamily: "Roboto",
                                                    fontSize: 24,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                                // decoration: BoxDecoration(color: Colors.green),
                                                margin: EdgeInsets.only(top: 8),
                                                child: MyTextInput(
                                                  controller: controllerUrl,
                                                  hint: "Website Developer",
                                                  icon: Icons.language_rounded,
                                                  inputType: TextInputType.url,
                                                )),
                                            Container(
                                                // decoration: BoxDecoration(color: Colors.green),
                                                margin: EdgeInsets.only(top: 8),
                                                child: MyTextInput(
                                                  icon: Icons.email_rounded,
                                                  hint: "Email",
                                                  controller:
                                                      controllerUsername,
                                                  inputType: TextInputType
                                                      .emailAddress,
                                                )),
                                            Visibility(
                                                visible: (page == PAGE_LOGIN ||
                                                    page == PAGE_REGISTER),
                                                child: Container(
                                                    // decoration: BoxDecoration(color: Colors.green),
                                                    margin:
                                                        EdgeInsets.only(top: 8),
                                                    child: MyTextInput(
                                                        controller:
                                                            controllerPassword,
                                                        hint: "Password",
                                                        icon:
                                                            Icons.lock_rounded,
                                                        inputType:
                                                            TextInputType.text,
                                                        obsecure: true))),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: kBaseMargin),
                                                child: MyButton(
                                                    disabled: (state
                                                        is PageLoadingState),
                                                    onPress: () {
                                                      final validUrl =
                                                          BlocProvider.of<
                                                                      AppCubit>(
                                                                  mainContext)
                                                              .changeUrl(
                                                                  controllerUrl
                                                                      .text);
                                                      if (!validUrl) {
                                                        ScaffoldMessenger.of(
                                                                mainContext)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "Invalid URL"),
                                                          duration: Duration(
                                                              seconds: 3),
                                                        ));
                                                        return;
                                                      }
                                                      final cubit = BlocProvider
                                                          .of<LoginCubit>(
                                                              mainContext);
                                                      if (page == PAGE_LOGIN) {
                                                        cubit.login(
                                                            controllerUsername
                                                                .text,
                                                            controllerPassword
                                                                .text);
                                                      } else if (page ==
                                                          PAGE_REGISTER) {
                                                        cubit.register(
                                                            controllerUsername
                                                                .text,
                                                            controllerPassword
                                                                .text);
                                                      } else if (page ==
                                                          PAGE_FORGOT) {
                                                        cubit.forgot(
                                                            controllerUsername
                                                                .text);
                                                      }
                                                    },
                                                    text: labelButton)),
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 36),
                                                margin: EdgeInsets.only(
                                                    top: kBaseMargin,
                                                    bottom: 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Visibility(
                                                        visible: (page ==
                                                            PAGE_LOGIN),
                                                        child: GestureDetector(
                                                          child:
                                                              Text("Akun Baru"),
                                                          onTap: () {
                                                            setState(() {
                                                              page =
                                                                  PAGE_REGISTER;
                                                            });
                                                          },
                                                        )),
                                                    Visibility(
                                                        visible: (page ==
                                                            PAGE_LOGIN),
                                                        child: GestureDetector(
                                                          child: Text(
                                                              "Lupa Password"),
                                                          onTap: () {
                                                            setState(() {
                                                              page =
                                                                  PAGE_FORGOT;
                                                            });
                                                          },
                                                        )),
                                                    Visibility(
                                                        visible: (page ==
                                                                PAGE_REGISTER ||
                                                            page ==
                                                                PAGE_FORGOT),
                                                        child: GestureDetector(
                                                          child: Text(
                                                              "Kembali ke Login"),
                                                          onTap: () {
                                                            setState(() {
                                                              page = PAGE_LOGIN;
                                                            });
                                                          },
                                                        )),
                                                  ],
                                                )),
                                            Container(
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 8),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                            child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                                "Dengan submit kamu setuju ",
                                                                style:
                                                                    TextStyle(
                                                                  height: 1.3,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontSize:
                                                                      kFontSizeSmall,
                                                                  color: Colors
                                                                      .black45,
                                                                )),
                                                          ],
                                                        )),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            InkWell(
                                                              child: Text(
                                                                  "Syarat dan Ketentuan",
                                                                  style:
                                                                      TextStyle(
                                                                    height: 1.3,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontSize:
                                                                        kFontSizeSmall,
                                                                    color: Colors
                                                                        .blueAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                              onTap: () => launch(
                                                                  "https://google.com"),
                                                            ),
                                                            Text(" dan ",
                                                                style:
                                                                    TextStyle(
                                                                  height: 1.3,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontSize:
                                                                      kFontSizeSmall,
                                                                  color: Colors
                                                                      .black45,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                            InkWell(
                                                              child: Text(
                                                                  "Kebijakan Privasi",
                                                                  style:
                                                                      TextStyle(
                                                                    height: 1.3,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontSize:
                                                                        kFontSizeSmall,
                                                                    color: Colors
                                                                        .blueAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                              onTap: () => launch(
                                                                  "https://google.com"),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    )))
                                          ],
                                        ),
                                      ))
                                ],
                              )),
                        ),
                      ],
                    ));
              });
        },
      ),
    );
  }
}
