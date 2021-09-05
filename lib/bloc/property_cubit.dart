import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/api/api_service.dart';
import 'package:tbs_app/bloc/property_state.dart';
import 'package:tbs_app/model/property_model.dart';
import 'package:tbs_app/model/user_model.dart';
import 'package:tbs_app/validation.dart' as validator;
import 'package:tbs_app/bloc/login_state.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PropertyCubit extends Cubit<AppState> {
  int attempt = 0;
  PropertyCubit() : super(PageInitState());
  UserModel? user;

  void fetchData(UserModel user) async {
    attempt++;
    emit(PageLoadingState());
    ApiService api = ApiService();
    var response = await api.findByTenant(user.idTenantNumber!);
    if (response.status!) {
      emit(SuccessLoadPropertyState(response.data));
    } else {
      emit(FailureLoadPropertyState(response.message!, this.attempt));
    }
  }

  void initPage() {
    emit(PropertyInitPageState());
  }
}
