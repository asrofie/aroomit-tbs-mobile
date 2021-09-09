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

class LoginPage extends StatelessWidget {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerUrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controllerPassword.text = "1123465";
    controllerUsername.text = "SEWA1@GMAIL.COM";
    controllerUrl.text = kServerUrl;
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
            bloc: LoginCubit(),
            listener: (context, state) {
              if (state is AlreadyLoginState) {
                _onWidgetDidBuild(() {
                  Navigator.pushReplacementNamed(context, route.kRouteMain);
                });
              } else if (state is SuccessLoginState) {
                _onWidgetDidBuild(() {
                  BlocProvider.of<AppCubit>(mainContext)
                      .loggedIn(state.userModel!);
                  Navigator.pushReplacementNamed(context, route.kRouteMain);
                });
              } else if (state is FailureLoginState) {
                ScaffoldMessenger.of(mainContext).showSnackBar(SnackBar(
                  content: Text(state.errorMessage),
                  duration: Duration(seconds: 3),
                ));
              } else if (state is PageInitState) {
                BlocProvider.of<AppCubit>(mainContext).loginCheck();
              }
            },
            builder: (ctx, state) {
              final heightForm = MediaQuery.of(mainContext).size.height * 0.57;
              final widthForm = MediaQuery.of(mainContext).size.width * 0.5;
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
                                  image:
                                      AssetImage("assets/images/setup_bg.png"),
                                  fit: BoxFit.fitWidth,
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
                                                hint: "URL Server / Scan QR",
                                                icon: Icons.qr_code_2_rounded,
                                                inputType: TextInputType.url,
                                              )),
                                          Container(
                                              // decoration: BoxDecoration(color: Colors.green),
                                              margin: EdgeInsets.only(top: 8),
                                              child: MyTextInput(
                                                icon: Icons.email_rounded,
                                                hint: "Email",
                                                controller: controllerUsername,
                                                inputType:
                                                    TextInputType.emailAddress,
                                              )),
                                          Container(
                                              // decoration: BoxDecoration(color: Colors.green),
                                              margin: EdgeInsets.only(top: 8),
                                              child: MyTextInput(
                                                  controller:
                                                      controllerPassword,
                                                  hint: "Password",
                                                  icon: Icons.lock_rounded,
                                                  inputType: TextInputType.text,
                                                  obsecure: true)),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: kBaseMargin),
                                              child: MyButton(
                                                  disabled: (state
                                                      is PageLoadingState),
                                                  onPress: () {
                                                    BlocProvider.of<LoginCubit>(
                                                            mainContext)
                                                        .login(
                                                            controllerUsername
                                                                .text,
                                                            controllerPassword
                                                                .text);
                                                  },
                                                  text: "Login")),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 36),
                                              margin: EdgeInsets.only(
                                                  top: kBaseMargin, bottom: 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Akun Baru"),
                                                  Text("Lupa Password")
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
                                                              style: TextStyle(
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
                                                              style: TextStyle(
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
            }));
  }
}
