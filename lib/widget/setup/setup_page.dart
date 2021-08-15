import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/widget/login/login_page.dart';
import 'package:tbs_app/widget/setup/setup_cubit.dart';
import 'package:tbs_app/widget/setup/setup_state.dart';

class SetupPage extends StatelessWidget {
  final setupCubit = SetupCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Color(kPrimaryColor),
              image: DecorationImage(
                  image: AssetImage("assets/images/setup_bg.png"),
                  fit: BoxFit.cover)),
        ),
        Container(
            child: Center(
          child: Container(
              width: 400,
              height: 300,
              margin: EdgeInsets.only(top: 48),
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Masukan Websitex2 / Scan QR\ndari Developer",
                          style: TextStyle(
                              height: 1.3,
                              fontSize: 18,
                              color: Color(kSecondaryColor),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2))),
                  Container(
                    // decoration: BoxDecoration(color: Colors.green),
                    margin: EdgeInsets.only(top: 16, left: 32, right: 32),
                    child: Material(
                        elevation: 3,
                        child: Container(
                            margin: EdgeInsets.only(top: 4),
                            child: TextFormField(
                              keyboardType: TextInputType.url,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(right: 16),
                                  labelText: "Masukan website developer",
                                  labelStyle: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Icon(Icons.manage_accounts),
                                  ),
                                  border: InputBorder.none),
                              validator: (text) {
                                if (text!.length == 0) {
                                  return "URL tidak boleh kosong";
                                }
                                return null;
                              },
                            ))),
                  ),
                  Container(
                    // decoration: BoxDecoration(color: Colors.green),
                    margin: EdgeInsets.only(top: 16, left: 32, right: 32),
                    child: Material(
                        elevation: 3,
                        child: Container(
                            margin: EdgeInsets.only(top: 4),
                            child: TextFormField(
                              keyboardType: TextInputType.url,
                              onTap: () {},
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(right: 16),
                                  labelText: "Scan QR website developer",
                                  labelStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                  ),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Icon(Icons.qr_code),
                                  ),
                                  border: InputBorder.none),
                              validator: (text) {
                                if (text!.length == 0) {
                                  return "URL tidak boleh kosong";
                                }
                                return null;
                              },
                            ))),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 16, left: 32, right: 32),
                      child: MaterialButton(
                        child: IntrinsicWidth(
                            child: Text(
                          "Simpan",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                              letterSpacing: 1.4),
                        )),
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) => LoginPage()));
                        },
                        elevation: 3,
                        padding: EdgeInsets.all(0),
                        color: Color(kPrimaryColor),
                        height: 48,
                        minWidth: double.infinity,
                      ))
                ],
              ))),
        ))
      ],
    ));
  }
}
