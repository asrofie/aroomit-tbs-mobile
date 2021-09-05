import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/api/api_service.dart';
import 'package:tbs_app/bloc/property_cubit.dart';
import 'package:tbs_app/model/user_model.dart';
import 'package:tbs_app/validation.dart' as validator;
import 'package:tbs_app/bloc/login_state.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(PageInitState());
  UserModel? user;

  void fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("tbs_user");
    if (user != null) {
      emit(OnLoggedUser(UserModel.fromJson(json.decode(user))));
    } else {
      emit(ForceLogout());
    }
  }

  void doLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("tbs_user");
    emit(ForceLogout());
  }

  void loggedIn(UserModel user) async {
    this.user = user;
  }

  void changePage(context, route) {
    if (route == "property") {
      PropertyCubit propertyCubit = BlocProvider.of<PropertyCubit>(context);
      propertyCubit.fetchData(user!);
    }
  }
}