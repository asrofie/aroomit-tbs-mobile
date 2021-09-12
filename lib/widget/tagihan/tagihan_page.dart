import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/bloc/app_cubit.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/model/property_model.dart';
import 'package:tbs_app/model/tagihan_model.dart';
import 'package:tbs_app/bloc/tagihan_cubit.dart';
import 'package:tbs_app/bloc/tagihan_state.dart';
import 'package:tbs_app/model/user_model.dart';
import 'package:tbs_app/routes.dart' as route;
import 'package:tbs_app/widget/single_content_page.dart';
import 'package:intl/intl.dart';

class TagihanPage extends StatefulWidget {
  PropertyModel propertyModel;
  TagihanPage({Key? key, required this.propertyModel}) : super(key: key);
  @override
  _TagihanPage createState() {
    return _TagihanPage(propertyModel);
  }
}

class _TagihanPage extends State<TagihanPage> {
  PropertyModel? propertyModel;

  _TagihanPage(this.propertyModel);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      UserModel? user = BlocProvider.of<AppCubit>(context).user;
      BlocProvider.of<TagihanCubit>(context)
          .fetchData(user!, propertyModel!.propertyCode!);
    });
  }

  @override
  Widget build(BuildContext c1) {
    final size = MediaQuery.of(c1).size;
    return Scaffold(
        body: Stack(children: <Widget>[
      SizedBox.fromSize(
          size: Size(size.width, 100),
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
                Navigator.pop(c1);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
        ),
        body: BlocConsumer<TagihanCubit, AppState>(
            bloc: BlocProvider.of<TagihanCubit>(c1),
            listener: (c2, state) {
              if (state is TagihanInitPageState) {
                final user = BlocProvider.of<AppCubit>(c1).user;
                BlocProvider.of<TagihanCubit>(c1)
                    .fetchData(user!, propertyModel!.propertyCode!);
              }
            },
            builder: (c2, state) {
              Size size = MediaQuery.of(c1).size;
              final height = size.height * 0.3;
              final width = size.width * 0.8;
              if (state is PageLoadingState) {
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.all(kBaseMargin),
                          child: Text("Loading..."));
                    });
              } else if (state is SuccessLoadTagihanState) {
                if (state.data.length == 0) {
                  return Container(
                      margin: EdgeInsets.only(top: kBaseMargin),
                      child: NodataPage());
                }
                return Stack(children: <Widget>[
                  cardProperty(),
                  Padding(
                      padding: EdgeInsets.only(top: 100, bottom: 16),
                      child: ListView.builder(
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          return listTile(context, state.data[0]);
                        },
                      ))
                ]);
              }
              return Container(
                  margin: EdgeInsets.only(top: kBaseMargin),
                  child: ErrorPage());
            }),
      )
    ]));
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
                              Text(
                                  propertyModel!.propertyTypeName! +
                                      " - " +
                                      propertyModel!.towerBuilding!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(propertyModel!.propertyStatus!)
                            ])),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(propertyModel!.roomType!),
                        Text(propertyModel!.roomM2! + "m2")
                      ],
                    )
                  ],
                ),
              )))
    ]);
  }

  listTile(context, TagihanModel model) {
    var formatter = NumberFormat('#,##,000', 'id_ID');
    final widthLeft = MediaQuery.of(context).size.width * 40 / 100;
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
            child: Container(
              height: 80,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: 50,
                            height: 50,
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
                          size: Size(widthLeft, 50),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Rp " + (model.qty!).toString(),
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
                        child: Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  formatter.format(
                                      double.tryParse(model.grandTotal!)),
                                  textAlign: TextAlign.right,
                                )
                              ],
                            )))
                  ]),
            )));
  }
}
