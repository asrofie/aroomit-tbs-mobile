import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tbs_app/config/constant.dart';

class SimpleShimmer extends StatelessWidget {
  SimpleShimmer();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = size.height * 0.3;
    final width = size.width * 0.8;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: kBaseMargin, vertical: 8),
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
                        size: Size((width - 20), 32),
                        child: Container(
                          decoration: ShapeDecoration(
                            color: Colors.grey[400]!,
                            shape: RoundedRectangleBorder(),
                          ),
                        )),
                  ))
            ]));
  }
}
