import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/api/api_service.dart';
import 'package:tbs_app/bloc/news_state.dart';
import 'package:tbs_app/model/user_model.dart';
import 'package:tbs_app/bloc/app_state.dart';

class NewsCubit extends Cubit<AppState> {
  int attempt = 0;
  NewsCubit() : super(PageInitState());
  UserModel? user;

  void fetchData(UserModel? user) async {
    attempt++;
    emit(PageLoadingState());
    ApiService api = ApiService();
    var response = await api.findNews(user!.companyCode!);
    if (response.status!) {
      emit(SuccessLoadNewsState(response.data));
    } else {
      emit(FailureLoadNewsState(response.message!, this.attempt));
    }
  }

  void initPage() {
    emit(NewsInitPageState());
  }
}
