import 'package:flutter/material.dart';
import 'package:tbs_app/api/mock_response.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/model/property_model.dart';

class PropertyPage extends StatelessWidget {
  List<PropertyModel> dataModel = [];

  PropertyPage() {
    dataModel = mockListPropertyOnly();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataModel.length,
      itemBuilder: (context, index) {
        return propertyTile(dataModel[index]);
      },
    );
  }

  propertyTile(PropertyModel model) {
    return Card(
      margin: EdgeInsets.all(kBaseMargin / 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      elevation: kElevation,
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
                        style:
                            TextStyle(color: Color(0xFF0095DA), fontSize: 14)),
                    SizedBox.fromSize(
                        size: Size(100, 40),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(model.propertyCode!,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              image: DecorationImage(
                                image: AssetImage("assets/images/ribbon.png"),
                                fit: BoxFit.fill,
                              )),
                        ))
                  ],
                )),
          ),
          Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: kBaseMargin, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    model.tenantName!,
                    style: TextStyle(color: Color(0xFFFDB913)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child:
                        Text("-", style: TextStyle(color: Color(0xFFFDB913))),
                  ),
                  Text(model.nik!, style: TextStyle(color: Color(0xFFFDB913))),
                ],
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: kBaseMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                  ),
                  SizedBox.fromSize(
                    size: Size(100, 100),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage("assets/images/lantai.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                        ),
                        Text(model.floorNumber!),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                  ),
                  SizedBox.fromSize(
                    size: Size(100, 100),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage("assets/images/nomor.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                        ),
                        Text(model.floorNumber!),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                  ),
                  SizedBox.fromSize(
                    size: Size(100, 100),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage("assets/images/type.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                        ),
                        Text(model.roomType!),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                  ),
                  SizedBox.fromSize(
                    size: Size(100, 100),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage("assets/images/luas.png"),
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
    );
  }
}
