import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/routes.dart' as route;
import 'package:tbs_app/providers.dart' as appProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:tbs_app/widget/single_content_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _App();
  }
}

class _App extends State<App> {
  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return MaterialApp(builder: (context, w) {
        return SafeArea(child: SingleContentPage("Loading inialize..."));
      });
    }
    if (_error) {
      return MaterialApp(builder: (context, w) {
        return SafeArea(child: SingleContentPage("Error inialize..."));
      });
    }
    return MultiBlocProvider(
        providers: appProvider.blocProviders,
        child: MaterialApp(
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
          onGenerateRoute: route.generateRoute,
          initialRoute: route.kRouteLogin,
        ));
  }

  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("tbs_firebase", token!);
      if (Platform.isIOS) {
        iOS_Permission();
      }
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  void iOS_Permission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }
}
