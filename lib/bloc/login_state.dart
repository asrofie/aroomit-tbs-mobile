import 'package:equatable/equatable.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:tbs_app/model/user_model.dart';

class FailureLoginState extends AppState {
  final String errorMessage;
  int attempt;

  FailureLoginState(this.errorMessage, this.attempt);

  @override
  List<Object> get props => [errorMessage, attempt];

  @override
  String toString() {
    return 'FailureLoginState{errorMessage: $errorMessage}';
  }
}

class SuccessLoginState extends AppState {
  UserModel? userModel;
  SuccessLoginState(this.userModel) : super() {}
  @override
  List<Object> get props => [userModel!];
}

class AlreadyLoginState extends AppState {}

class NeedLoginState extends AppState {}
