import 'package:tbs_app/bloc/app_state.dart';
import 'package:tbs_app/model/news_model.dart';

class NewsInitPageState extends PageInitState {
  NewsInitPageState() : super();
}

class SuccessLoadNewsState extends AppState {
  List<NewsModel> data;
  SuccessLoadNewsState(this.data);
}

class FailureLoadNewsState extends FailureLoadState {
  FailureLoadNewsState(String errorMessage, int attempt)
      : super(errorMessage, attempt);
}

class SuccessLoadNewsDetailState extends AppState {
  NewsModel data;
  SuccessLoadNewsDetailState(this.data);
}
