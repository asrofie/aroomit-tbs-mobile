import 'package:equatable/equatable.dart';
import 'package:tbs_app/bloc/app_state.dart';
import 'package:tbs_app/model/property_model.dart';

class PropertyInitPageState extends PageInitState {
  PropertyInitPageState() : super();
}

class SuccessLoadPropertyState extends AppState {
  List<PropertyModel> data;
  SuccessLoadPropertyState(this.data);
}

class FailureLoadPropertyState extends FailureLoadState {
  FailureLoadPropertyState(String errorMessage, int attempt)
      : super(errorMessage, attempt);
}
