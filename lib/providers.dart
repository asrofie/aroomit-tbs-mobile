import "package:flutter_bloc/flutter_bloc.dart";
import 'package:tbs_app/bloc/login_cubit.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginCubit>(create: (_) => LoginCubit()),
];
