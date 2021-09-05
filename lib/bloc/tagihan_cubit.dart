import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/api/api_service.dart';
import 'package:tbs_app/bloc/tagihan_state.dart';
import 'package:tbs_app/model/user_model.dart';
import 'package:tbs_app/bloc/app_state.dart';

class TagihanCubit extends Cubit<AppState> {
  int attempt = 0;
  TagihanCubit() : super(PageInitState());
  UserModel? user;

  void fetchData(UserModel user, String propertyCode) async {
    attempt++;
    emit(PageLoadingState());
    ApiService api = ApiService();
    var response = await api.findTagihan(user.idTenantNumber!, propertyCode);
    if (response.status!) {
      emit(SuccessLoadTagihanState(response.data));
    } else {
      emit(FailureLoadTagihanState(response.message!, this.attempt));
    }
  }

  void initPage() {
    emit(TagihanInitPageState());
  }
}
