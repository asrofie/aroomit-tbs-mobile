import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tbs_app/bloc/app_cubit.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:tbs_app/bloc/news_cubit.dart';
import 'package:tbs_app/bloc/news_state.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/model/news_model.dart';
import 'package:tbs_app/routes.dart' as route;
import 'package:tbs_app/widget/single_content_page.dart';

class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsPage();
  }
}

class _NewsPage extends State<NewsPage> {
  late NewsCubit cubit;
  late AppCubit appCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((duration) {
      cubit.fetchData(appCubit.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    appCubit = BlocProvider.of<AppCubit>(context);
    cubit = BlocProvider.of<NewsCubit>(context);
    return BlocConsumer<NewsCubit, AppState>(
        bloc: BlocProvider.of<NewsCubit>(context),
        builder: (ctx, state) {
          if (state is SuccessLoadNewsState) {
            if (state.data.isEmpty) {
              return NodataPage();
            }
            return page(context, dataList(context, state.data));
          }
          if (state is FailureLoadNewsState) {
            return page(context, ErrorPage());
          }
          return page(context, shimmerList(context));
        },
        listener: (c, s) {});
  }

  Widget shimmerList(context) {
    Size size = MediaQuery.of(context).size;
    final height = size.height * 0.3;
    final width = size.width;
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: kBaseMargin),
            child: Text("Loading..."));
      },
    );
  }

  Widget dataList(context, List<NewsModel> data) {
    return ListView.builder(
      itemCount: (data.length),
      itemBuilder: (context, index) {
        return listTile(context, data[index]);
      },
    );
  }

  Widget page(context, Widget content) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "News",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF6dcff6),
          elevation: 0.0,
        ),
        body: Container(
            margin: EdgeInsets.only(top: kBaseMargin), child: content));
  }

  openNewsDetail(String newsId) async {
    final result = await Navigator.pushNamed(context, route.kRouteNewsDetail,
        arguments: newsId);
    cubit.fetchData(appCubit.user);
  }

  listTile(context, NewsModel model) {
    String imageUrl = model.newsBanner!;
    String contentTipe = "Article";
    if (model.videoFlag == "1") {
      imageUrl = "https://i.ytimg.com/vi/" + model.videoUrl! + "/hq720.jpg";
      contentTipe = "Video";
    }
    return GestureDetector(
        onTap: () {
          openNewsDetail(model.newsId!);
        },
        child: Card(
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
                        placeholder:
                            AssetImage("assets/images/image_placeholder.png"),
                        imageErrorBuilder: (c, o, s) {
                          return Image(
                              image: AssetImage(
                                  "assets/images/image_placeholder.png"));
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
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8)),
                                child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            model.newsTitle!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ])))))
                  ],
                ))));
  }
}
