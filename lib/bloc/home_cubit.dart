import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbs_app/api/api_service.dart';
import 'package:tbs_app/model/user_model.dart';
import 'package:tbs_app/validation.dart' as validator;
import 'package:tbs_app/bloc/login_state.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomeCubit extends Cubit<AppState> {
  HomeCubit() : super(PageInitState());
}
