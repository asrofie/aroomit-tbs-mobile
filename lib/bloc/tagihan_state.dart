import 'package:tbs_app/bloc/app_state.dart';
import 'package:tbs_app/model/tagihan_model.dart';

class TagihanInitPageState extends PageInitState {
  TagihanInitPageState() : super();
}

class SuccessLoadTagihanState extends AppState {
  List<TagihanModel> data;
  SuccessLoadTagihanState(this.data);
}

class FailureLoadTagihanState extends FailureLoadState {
  FailureLoadTagihanState(String errorMessage, int attempt)
      : super(errorMessage, attempt);
}
