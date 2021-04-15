import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'http_state.dart';

class HttpCubit extends Cubit<HttpState> {
  HttpCubit() : super(HttpInitial());

  getData() async {
    print("Get");
    emit(HttpStateLoading());
    //Get the data
    //Typically
    try {
      await Future.delayed(Duration(seconds: 5));
      emit(HttpStateFailed("Nothing foadaljpoaj"));
    } catch (e) {
      emit(HttpStateFailed(e.toString()));
    }
  }
}
