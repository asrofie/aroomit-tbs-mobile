import 'package:flutter/material.dart';
import 'package:tbs_app/api/mock_response.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/model/news_model.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewsDetailPage extends StatelessWidget {
  NewsModel? dataModel = null;

  NewsDetailPage() {
    dataModel = sampleNewsDetail();
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
              title: Text(dataModel!.newsTitle!),
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_rounded, color: Colors.black)),
            ),
            body: listTile(dataModel!),
          )
        ],
      ),
    );
  }

  cardProperty(NewsModel model) {
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

  listTile(NewsModel model) {
    Widget header = Image(
      image: NetworkImage(model.newsBanner!),
      errorBuilder: (c, o, s) =>
          Image(image: AssetImage("images/image_placeholder.png")),
    );
    if (model.videoFlag == "1") {
      header = YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: model.videoUrl!, //Add videoID.
          flags: YoutubePlayerFlags(
            hideControls: false,
            controlsVisibleAtStart: true,
            autoPlay: false,
            mute: false,
          ),
        ),
        showVideoProgressIndicator: true,
        progressIndicatorColor: Color(kPrimaryColor),
      );
    }
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(kBaseMargin),
            child: Column(children: [
              header,
              Padding(
                padding: EdgeInsets.only(top: kBaseMargin),
                child: Html(data: model.newsContent!),
              )
            ])));
  }
}
