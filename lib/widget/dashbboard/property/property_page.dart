import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/api/mock_response.dart';
import 'package:tbs_app/bloc/app_cubit.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:tbs_app/bloc/property_cubit.dart';
import 'package:tbs_app/bloc/property_state.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/model/property_model.dart';
import 'package:tbs_app/routes.dart' as route;
import 'package:shimmer/shimmer.dart';

class PropertyPage extends StatelessWidget {
  List<PropertyModel> dataModel = [];
  Size iconSize = Size(100, 80);

  PropertyPage() {
    // dataModel = mockListPropertyOnly();
  }
  @override
  Widget build(BuildContext c1) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Property",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF6dcff6),
          elevation: 0.0,
        ),
        body: BlocConsumer<PropertyCubit, AppState>(builder: (c2, state) {
          Size size = MediaQuery.of(c1).size;
          final height = size.height * 0.3;
          final width = size.width * 0.8;
          if (state is PageLoadingState) {
            return ListView.builder(
                itemCount: kTotalDummy,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: Colors.grey.withOpacity(0.3),
                              period: Duration(seconds: 1),
                              child: SizedBox.fromSize(
                                  size: Size(width, 16),
                                  child: Container(
                                    decoration: ShapeDecoration(
                                      color: Colors.grey[400]!,
                                      shape: RoundedRectangleBorder(),
                                    ),
                                  )),
                            ),
                            Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.grey.withOpacity(0.3),
                                period: Duration(seconds: 1),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 4, right: 16),
                                  child: SizedBox.fromSize(
                                      size: Size(width, 16),
                                      child: Container(
                                        decoration: ShapeDecoration(
                                          color: Colors.grey[400]!,
                                          shape: RoundedRectangleBorder(),
                                        ),
                                      )),
                                ))
                          ]));
                });
          } else if (state is SuccessLoadPropertyState) {
            if (state.data.length == 0) {
              return Container(
                  child: Center(
                child: Text("Tidak ada data"),
              ));
            }
            return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  return propertyTile(context, state.data[index]);
                });
          }
          return Container(
              child: Center(
            child: Text("Tidak terhubung dengan server"),
          ));
        }, listener: (c2, state) {
          AppCubit app = BlocProvider.of<AppCubit>(c1);
          if (state is PropertyInitPageState) {
            BlocProvider.of<PropertyCubit>(c1).fetchData(app.user!);
          }
        }));
  }

  propertyTile(context, PropertyModel model) {
    Size size = MediaQuery.of(context).size;
    final height = size.height * 0.3;
    final width = size.width * 0.3;
    return GestureDetector(
        onTap: () => Navigator.pushNamed(context, route.kRouteTagihan),
        child: Card(
            margin: EdgeInsets.all(kBaseMargin / 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadius),
            ),
            elevation: kElevation,
            child: Container(
              height: height,
              width: width,
              child: Column(
                children: [
                  SizedBox.fromSize(
                    size: Size(double.infinity, 40),
                    child: Padding(
                        padding: EdgeInsets.only(left: kBaseMargin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                (model.propertyTypeName! +
                                    " - " +
                                    model.towerBuilding!),
                                style: TextStyle(
                                    color: Color(0xFF0095DA), fontSize: 14)),
                            SizedBox.fromSize(
                                size: Size(100, 40),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(model.propertyCode!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/ribbon.png"),
                                        fit: BoxFit.fill,
                                      )),
                                ))
                          ],
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kBaseMargin, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            model.tenantName!,
                            style: TextStyle(color: Color(0xFFFDB913)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Text("-",
                                style: TextStyle(color: Color(0xFFFDB913))),
                          ),
                          Text(model.nik!,
                              style: TextStyle(color: Color(0xFFFDB913))),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox.fromSize(
                            size: iconSize,
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage("assets/images/lantai.png"),
                                  height: 24,
                                  width: 24,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                ),
                                Text(model.floorNumber!),
                              ],
                            ),
                          ),
                          SizedBox.fromSize(
                            size: iconSize,
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage("assets/images/nomor.png"),
                                  height: 24,
                                  width: 24,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                ),
                                Text(model.floorNumber!),
                              ],
                            ),
                          ),
                          SizedBox.fromSize(
                            size: iconSize,
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage("assets/images/type.png"),
                                  height: 24,
                                  width: 24,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                ),
                                Text(model.roomType!),
                              ],
                            ),
                          ),
                          SizedBox.fromSize(
                            size: iconSize,
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage("assets/images/luas.png"),
                                  height: 24,
                                  width: 24,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                ),
                                Text(model.roomM2!),
                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            )));
  }
}
