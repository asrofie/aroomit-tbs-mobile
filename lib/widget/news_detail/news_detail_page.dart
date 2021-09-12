import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:tbs_app/bloc/app_cubit.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:tbs_app/bloc/news_cubit.dart';
import 'package:tbs_app/bloc/news_state.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/model/news_model.dart';
import 'package:tbs_app/widget/single_content_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewsDetailPage extends StatefulWidget {
  String? newsId;

  NewsDetailPage({Key? key, this.newsId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewsDetailPage(this.newsId);
  }
}

class _NewsDetailPage extends State<NewsDetailPage> {
  String? newsId;
  late AppCubit app;
  late NewsCubit cubit;
  String title = "News Detail";
  _NewsDetailPage(this.newsId);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      cubit.fetchDetail(app.user!, newsId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    app = BlocProvider.of<AppCubit>(context);
    cubit = BlocProvider.of<NewsCubit>(context);
    return BlocConsumer<NewsCubit, AppState>(
        bloc: cubit,
        builder: (c, state) {
          if (state is PageLoadingState) {
            return page(context, Text("Loading..."));
          }
          if (state is SuccessLoadNewsDetailState) {
            return page(context, tile(state.data));
          }
          return page(context, ErrorPage());
        },
        listener: (c, state) {
          if (state is SuccessLoadNewsDetailState) {
            setState(() {
              title = state.data.newsTitle!;
            });
          }
        });
  }

  Widget page(context, Widget content) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded, color: Colors.black)),
      ),
      body: Container(margin: EdgeInsets.all(kBaseMargin), child: content),
    );
  }

  tile(NewsModel model) {
    Widget header = Image(
      image: NetworkImage(model.newsBanner!),
      errorBuilder: (c, o, s) =>
          Image(image: AssetImage("assets/images/image_placeholder.png")),
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
    String fullHtml = "<!DOCTYPE html><html><head><title>" +
        model.newsTitle! +
        "</title><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"></head><body>";
    fullHtml += model.newsContent!;
    fullHtml += "</body></html>";
    var unescape = HtmlUnescape();
    return SingleChildScrollView(
        child: Column(children: [
      Padding(padding: EdgeInsets.only(bottom: 8), child: header),
      Html(data: unescape.convert(fullHtml))
    ]));
  }
}
