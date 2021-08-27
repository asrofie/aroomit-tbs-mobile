import 'package:flutter/material.dart';
import 'package:tbs_app/api/mock_response.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/model/news_model.dart';

class NewsPage extends StatelessWidget {
  List<NewsModel> dataModel = [];

  NewsPage() {
    dataModel = sampleListNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "News",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF6dcff6),
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: (dataModel.length * 10),
        itemBuilder: (context, index) {
          return listTile(dataModel[0]);
        },
      ),
    );
  }

  listTile(NewsModel model) {
    String imageUrl = model.newsBanner!;
    String contentTipe = "Article";
    if (model.videoFlag == "1") {
      imageUrl = "https://i.ytimg.com/vi/" + model.videoUrl! + "/hq720.jpg";
      contentTipe = "Video";
    }
    return Card(
        margin: EdgeInsets.symmetric(
            horizontal: kBaseMargin, vertical: (kBaseMargin * 0.5)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadius),
        ),
        elevation: kElevation,
        child: SizedBox.fromSize(
            size: Size(double.infinity, 270),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: FadeInImage(
                    placeholder: AssetImage("images/image_placeholder.png"),
                    imageErrorBuilder: (c, o, s) {
                      return Image(
                          image: AssetImage("images/image_placeholder.png"));
                    },
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    fadeInDuration: Duration(milliseconds: 200),
                    fadeInCurve: Curves.linear,
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox.fromSize(
                        size: Size(double.infinity, 70),
                        child: Container(
                            alignment: Alignment.topCenter,
                            decoration:
                                BoxDecoration(color: Colors.grey.withAlpha(50)),
                            child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        model.newsTitle!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ])))))
              ],
            )));
  }
}
