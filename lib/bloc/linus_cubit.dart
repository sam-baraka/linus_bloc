import 'package:flutter_bloc/flutter_bloc.dart';

class LinusCubit extends Cubit<String> {
  LinusCubit(String initialState) : super(initialState);

  changeState({String? value}) {
    emit(value!);
  }
}
