import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class PageInitState extends AppState {}

class PageLoadingState extends AppState {}

class PageLoadedState extends AppState {}

class OnCloseState extends AppState {}
