import 'package:equatable/equatable.dart';

abstract class SetupState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSetupState extends SetupState {}

class LoadingSetupState extends SetupState {}

class FailureSetupState extends SetupState {
  final String errorMessage;

  FailureSetupState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureSetupState{errorMessage: $errorMessage}';
  }
}

class SuccessSetupState extends SetupState {}
