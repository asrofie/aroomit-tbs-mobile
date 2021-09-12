import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/bloc/app_cubit.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AccountPage extends StatelessWidget {
  late var rowWidth;
  late var rowHeight;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: BlocProvider.of<AppCubit>(context),
        builder: (c, s) => pageBuilder(context, s),
        listener: (c, s) => blocListener(c, s));
  }

  blocListener(ctx, state) {}

  Widget pageBuilder(ctx, state) {
    final user = BlocProvider.of<AppCubit>(ctx).user!;
    final List<TileModel> data = [
      TileModel(Icons.person, 'Company', user.companyName!),
      TileModel(Icons.person, 'Name', user.tenantName!),
      TileModel(Icons.smartphone_rounded, 'Phone', user.tenantPhone!),
      TileModel(Icons.mail_rounded, 'Email', user.tenantEmail!),
      TileModel(Icons.home_rounded, 'Address', user.address!),
      TileModel(Icons.exit_to_app_rounded, 'Logout', ""),
    ];
    final deviceSize = MediaQuery.of(ctx).size;
    rowHeight = deviceSize.height * 0.1;
    rowWidth = deviceSize.width;
    return SafeArea(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (bc, index) {
              if (data[index].label.toLowerCase() == "logout") {
                return GestureDetector(
                    onTap: () {
                      BlocProvider.of<AppCubit>(ctx).doLogout();
                    },
                    child: tile(data[index]));
              }
              if (index == 0) {
                return Container(
                    height: (rowHeight * 3),
                    margin: EdgeInsets.symmetric(horizontal: kBaseMargin),
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          Container(
                              child: Center(
                                  child: CircleAvatar(
                                      radius: 55,
                                      backgroundColor: Colors.black26,
                                      child: CachedNetworkImage(
                                          imageUrl: user.iconImage!,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  new CircleAvatar(
                                                      radius: 50,
                                                      backgroundImage:
                                                          imageProvider,
                                                      backgroundColor:
                                                          Colors.white),
                                          errorWidget: (context, url, error) =>
                                              CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/image_placholder.png")))))),
                          Padding(
                            padding: EdgeInsets.only(top: kBaseMargin),
                            child: Text(user.companyName!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                )),
                          )
                        ])));
              }
              return tile(data[index]);
            },
            itemCount: data.length));
  }

  Widget tile(TileModel model) {
    return Card(
        child: Container(
      height: rowHeight,
      width: rowWidth,
      margin: EdgeInsets.symmetric(horizontal: kBaseMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(children: [
            Icon(model.icon),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(model.label),
            )
          ]),
          Text(model.value)
        ],
      ),
    ));
  }
}

class TileModel {
  IconData icon;
  String label;
  String value;
  TileModel(this.icon, this.label, this.value);
}
