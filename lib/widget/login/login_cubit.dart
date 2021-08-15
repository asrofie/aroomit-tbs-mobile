import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/api/auth_api.dart';
import 'package:tbs_app/config/constant.dart';
import 'package:tbs_app/widget/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());

  Future<LoginResponse> login(String email, String password) async {
    emit(LoadingLoginState());
    AuthApi api = AuthApi();
    var response = await api.postLogin(email, password);
    if (response.status!) {
      emit(SuccessLoginState());
    } else {
      emit(FailureLoginState('Email/Password tidak sesuai'));
    }
    return response;
  }
}
