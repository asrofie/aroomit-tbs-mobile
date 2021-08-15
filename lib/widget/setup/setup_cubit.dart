import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/widget/setup/setup_state.dart';
import 'package:tbs_app/config/constant.dart';

class SetupCubit extends Cubit<SetupState> {
  SetupCubit() : super(InitialSetupState());

  void save(String url) async {
    emit(LoadingSetupState());
    await Future.delayed(Duration(seconds: 3));
    if (url == kServerUrl) {
      emit(SuccessSetupState());
    } else {
      emit(FailureSetupState('Login failure'));
    }
  }
}
