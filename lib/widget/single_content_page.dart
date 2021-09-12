import 'package:flutter/material.dart';

class SingleContentPage extends StatelessWidget {
  String content = "Data is Empty";

  SingleContentPage(this.content);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text(this.content),
    ));
  }
}

class NodataPage extends SingleContentPage {
  NodataPage() : super("Data is empty");
}

class ErrorPage extends SingleContentPage {
  ErrorPage() : super("Error connect to server");
}
