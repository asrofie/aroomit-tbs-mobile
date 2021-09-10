import 'package:equatable/equatable.dart';
import 'package:tbs_app/model/user_model.dart';

abstract class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class PageInitState extends AppState {}

class PageLoadingState extends AppState {}

class PageLoadedState extends AppState {}

class OnCloseState extends AppState {}

class OnLoggedUser extends AppState {
  UserModel? user;
  OnLoggedUser(this.user);
}

class ForceLogout extends AppState {}

class FailureLoadState extends AppState {
  final String errorMessage;
  int attempt;

  FailureLoadState(this.errorMessage, this.attempt);

  @override
  List<Object> get props => [errorMessage, attempt];

  @override
  String toString() {
    return 'FailureLoginState{errorMessage: $errorMessage}';
  }
}

class AlreadyLoginState extends AppState {}

class NeedLoginState extends AppState {}

class FoundUrlState extends AppState {
  String url;
  FoundUrlState(this.url);

  @override
  List<Object> get props => [url];
}
