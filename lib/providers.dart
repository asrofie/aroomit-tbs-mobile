import "package:flutter_bloc/flutter_bloc.dart";
import 'package:tbs_app/bloc/login_cubit.dart';
import 'package:tbs_app/bloc/home_cubit.dart';
import 'package:tbs_app/bloc/app_cubit.dart';
import 'package:tbs_app/bloc/property_cubit.dart';
import 'package:tbs_app/bloc/tagihan_cubit.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginCubit>(create: (_) => LoginCubit()),
  BlocProvider<AppCubit>(create: (_) => AppCubit()),
  BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
  BlocProvider<PropertyCubit>(create: (_) => PropertyCubit()),
  BlocProvider<TagihanCubit>(create: (_) => TagihanCubit()),
];
