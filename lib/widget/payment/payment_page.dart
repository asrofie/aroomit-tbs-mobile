import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/model/tagihan_model.dart';

class PaymentPage extends StatefulWidget {
  String? detailBillCode;
  PaymentPage(this.detailBillCode);

  @override
  PaymentPageState createState() => new PaymentPageState(this.detailBillCode);
}

class PaymentPageState extends State<PaymentPage> {
  String? detailBillCode;
  bool isLoading = true;
  InAppWebViewController? _webViewController;

  PaymentPageState(this.detailBillCode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.fromSize(
              size: Size(double.infinity, 100),
              child: Container(
                decoration: BoxDecoration(color: Color(0xFF6dcff6)),
              )),
          SafeArea(
              child: Stack(children: <Widget>[
            Visibility(
                visible: isLoading,
                child: Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(kPrimaryColor),
                    ),
                  ),
                )),
            InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(kServerUrl +
                      "/payment/do?DetailBillCode=" +
                      this.detailBillCode!)),
              initialOptions: InAppWebViewGroupOptions(),
              onLoadStop: (InAppWebViewController controller, url) async {},
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                print(progress);
                if (progress >= 100) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              onWebViewCreated: (InAppWebViewController controller) {
                _webViewController = controller;

                _webViewController!.addJavaScriptHandler(
                    handlerName: 'onClosePage',
                    callback: (args) {
                      Navigator.of(context).pop();
                    });

                _webViewController!.addJavaScriptHandler(
                    handlerName: 'onPaymentSuccess',
                    callback: (args) {
                      print(args);
                      // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                    });

                _webViewController!.addJavaScriptHandler(
                    handlerName: 'onPaymentPending',
                    callback: (args) {
                      print(args);
                      // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                    });

                _webViewController!.addJavaScriptHandler(
                    handlerName: 'onPaymentError',
                    callback: (args) {
                      print(args);
                      // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                    });
              },
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
              },
            )
          ]))
        ],
      ),
    );
  }

  cardProperty() {
    return Stack(children: <Widget>[
      SizedBox.fromSize(
        size: Size(double.infinity, 60),
        child:
            Container(decoration: BoxDecoration(color: Color(kPrimaryColor))),
      ),
      SizedBox.fromSize(
          size: Size(double.infinity, 100),
          child: Card(
              margin: EdgeInsets.symmetric(
                  horizontal: kBaseMargin, vertical: (kBaseMargin * 0.5)),
              elevation: kElevation,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRadius)),
              child: Padding(
                padding: EdgeInsets.all(kBaseMargin),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("Apartement - A",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text("Status")
                            ])),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Floor 1 / 414"),
                        Text("Sewa"),
                        Text("201m2")
                      ],
                    )
                  ],
                ),
              )))
    ]);
  }

  listTile(TagihanModel model) {
    return Card(
        margin: EdgeInsets.symmetric(
            horizontal: kBaseMargin, vertical: (kBaseMargin * 0.5)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadius),
        ),
        elevation: kElevation,
        child: SizedBox.fromSize(
          size: Size(double.infinity, 80),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox.fromSize(
                        size: Size(50, 50),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                              child: Text(
                            model.typeBillName!.substring(0, 3),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      )),
                  SizedBox.fromSize(
                      size: Size(100, 50),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              model.qty!,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              model.periode!,
                              textAlign: TextAlign.center,
                            )
                          ]))
                ]),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox.fromSize(
                        size: Size(200, 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              model.grandTotal!,
                              textAlign: TextAlign.right,
                            )
                          ],
                        )))
              ]),
        ));
  }
}
