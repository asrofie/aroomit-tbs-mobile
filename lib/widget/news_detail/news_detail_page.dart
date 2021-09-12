import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:html/parser.dart';
import 'package:tbs_app/bloc/app_cubit.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:tbs_app/bloc/news_cubit.dart';
import 'package:tbs_app/bloc/news_state.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/model/news_model.dart';
import 'package:flutter_html/flutter_html.dart';
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
        listener: (c, s) {});
  }

  Widget page(context, Widget content) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(),
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
    String fullHtml = "<!DOCTYPE html><html><head><title>" +
        model.newsTitle! +
        "</title><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"></head><body>";
    fullHtml += parse(model.newsContent!).toString();
    fullHtml += "</body></html>";
    return SingleChildScrollView(
        child: InAppWebView(
      initialData: InAppWebViewInitialData(data: fullHtml),
      initialOptions: InAppWebViewGroupOptions(),
      onLoadStop: (InAppWebViewController controller, url) async {},
      onProgressChanged: (InAppWebViewController controller, int progress) {},
      onWebViewCreated: (InAppWebViewController controller) {},
      onConsoleMessage: (controller, consoleMessage) {
        print(consoleMessage);
      },
    ));
  }
}
