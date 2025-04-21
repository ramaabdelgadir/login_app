import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
   on<ChangedScreenEvent>(changedScreen);
  }

  FutureOr<void> changedScreen(ChangedScreenEvent event, Emitter<MainState> emit) {
    switch (event.pageIndex){
      case 0:
      emit(GoToFavoScreenState());
      case 1:
      emit(GoToStoresScreenState());
      case 2:
      emit(GoToProfileScreenState());
    }
  }
}
