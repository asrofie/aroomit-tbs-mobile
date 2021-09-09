import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/api/api_service.dart';
import 'package:tbs_app/model/user_model.dart';
import 'package:tbs_app/validation.dart' as validator;
import 'package:tbs_app/bloc/login_state.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginCubit extends Cubit<AppState> {
  int? attempt;
  LoginCubit() : super(PageInitState()) {
    this.attempt = 0;
  }

  void login(String email, String password) async {
    if (this.attempt == null) {
      this.attempt = 1;
    } else {
      this.attempt = this.attempt! + 1;
    }
    if (!validator.checkMinLength(email, 3) ||
        !validator.checkMinLength(password, 3)) {
      emit(FailureLoginState(
          'Email/Password minimal 3 karakter', this.attempt!));
    } else if (!validator.checkEmail(email)) {
      emit(FailureLoginState('Invalid email format', this.attempt!));
    } else {
      emit(PageLoadingState());
      ApiService api = ApiService();
      var response = await api.postLogin(email, password, "xx123");
      if (response.status!) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        UserModel user = response.data![0];
        String userJson = json.encode(user);
        await prefs.setString("tbs_user", userJson);
        emit(SuccessLoginState(user));
      } else {
        emit(FailureLoginState(response.message!, this.attempt!));
      }
    }
  }

  void register(String email, String password) async {
    if (this.attempt == null) {
      this.attempt = 1;
    } else {
      this.attempt = this.attempt! + 1;
    }
    if (!validator.checkMinLength(email, 3) ||
        !validator.checkMinLength(password, 3)) {
      emit(FailureLoginState(
          'Email/Password minimal 3 karakter', this.attempt!));
    } else if (!validator.checkEmail(email)) {
      emit(FailureLoginState('Invalid email format', this.attempt!));
    } else {
      emit(PageLoadingState());
      ApiService api = ApiService();
      var response = await api.postRegister(email, password, "xx123");
      emit(SuccessApiState(response, this.attempt!));
    }
  }

  void forgot(String email) async {
    if (this.attempt == null) {
      this.attempt = 1;
    } else {
      this.attempt = this.attempt! + 1;
    }
    if (!validator.checkMinLength(email, 3)) {
      emit(FailureLoginState('Email minimal 3 karakter', this.attempt!));
    } else if (!validator.checkEmail(email)) {
      emit(FailureLoginState('Invalid email format', this.attempt!));
    } else {
      emit(PageLoadingState());
      ApiService api = ApiService();
      var response = await api.postForgot(email);
      emit(SuccessApiState(response, this.attempt!));
    }
  }
}
