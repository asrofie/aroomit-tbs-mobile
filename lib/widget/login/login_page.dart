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
            bloc: BlocProvider.of<LoginCubit>(mainContext),
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
                BlocProvider.of<LoginCubit>(mainContext).loginCheck();
              }
            },
            builder: (ctx, state) {
              final heightForm = MediaQuery.of(mainContext).size.height * 0.4;
              return SafeArea(
                  maintainBottomViewPadding: true,
                  child: Stack(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(top: kBaseMargin),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(kRadius),
                            child: Image(
                              image: NetworkImage(
                                  "https://via.placeholder.com/100x100.png?text=TBS"),
                              errorBuilder: (ctx, obj, tr) {
                                return Image(
                                  image: AssetImage(
                                      "assets/images/image_placeholder.png"),
                                  width: 100,
                                );
                              },
                            ),
                          )),
                      Center(
                          child: Container(
                        margin: EdgeInsets.symmetric(horizontal: kBaseMargin),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(bottom: kBaseMargin),
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          text: "SIGN IN/UP",
                                          style: TextStyle(
                                            height: 1.3,
                                            fontFamily: 'Roboto',
                                            fontSize: 18,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          )))),
                              Material(
                                  elevation: 0,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(kRadius),
                                      topRight: Radius.circular(kRadius)),
                                  child: Container(
                                    height: heightForm,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kBaseMargin),
                                    child: Column(
                                      children: <Widget>[
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
                                                controller: controllerPassword,
                                                hint: "Password",
                                                icon: Icons.lock_rounded,
                                                inputType: TextInputType.text,
                                                obsecure: true)),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: kBaseMargin),
                                            child: MyButton(
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
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      )),
                      Container(
                          child: Padding(
                        padding: EdgeInsets.symmetric(vertical: kBaseMargin),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  child: Text("Syarat dan Ketentuan",
                                      style: TextStyle(
                                        height: 1.3,
                                        fontStyle: FontStyle.normal,
                                        fontSize: kFontSizeSmall,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  onTap: () => launch("https://google.com"),
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
                                  onTap: () => launch("https://google.com"),
                                )
                              ],
                            )
                          ],
                        ),
                      ))
                    ],
                  ));
            }));
  }
}
