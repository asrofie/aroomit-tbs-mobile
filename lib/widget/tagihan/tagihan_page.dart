import 'package:flutter/material.dart';
import 'package:tbs_app/api/mock_response.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/model/tagihan_model.dart';
import 'package:tbs_app/routes.dart' as route;

class TagihanPage extends StatelessWidget {
  List<TagihanModel> dataModel = [];

  TagihanPage() {
    dataModel = sampleListTagihan();
  }

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
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Tagihan",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color(0xFF6dcff6),
              elevation: 0.0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  )),
            ),
            body: Stack(children: <Widget>[
              cardProperty(),
              Padding(
                  padding: EdgeInsets.only(top: 100, bottom: 16),
                  child: ListView.builder(
                    itemCount: (dataModel.length * 10),
                    itemBuilder: (context, index) {
                      return listTile(context, dataModel[0]);
                    },
                  ))
            ]),
          )
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

  listTile(context, TagihanModel model) {
    return GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(route.kRoutePayment, arguments: model.detailBillCode),
        child: Card(
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
            )));
  }
}
