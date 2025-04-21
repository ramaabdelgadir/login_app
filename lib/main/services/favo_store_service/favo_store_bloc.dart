import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login_app/external/database/database_service.dart';
import 'package:meta/meta.dart';

part 'favo_store_event.dart';
part 'favo_store_state.dart';

class FavoStoreBloc extends Bloc<FavoStoreEvent, FavoStoreState> {
  FavoStoreBloc() : super(FavoStoreInitial()) {
    on<GetAllStoresFromFavoEvent>(getAllStoresFromFavo);
  }

  DatabaseService _databaseService = DatabaseService.instance;
  
  FutureOr<void> getAllStoresFromFavo(GetAllStoresFromFavoEvent event, Emitter<FavoStoreState> emit)async {
    emit(GetAllStoresFromFavoLoadingState());

    final storesList =await _databaseService.getStores();

    if (storesList == null){
      emit(GetAllStoresFromFavoFailedState());
      return;
    }

    if (storesList.length==0){
      emit(GetAllStoresFromFavoZeroStoreState());
      return;
      }
    
    emit(GetAllStoresFromFavoSuccessState(storesList: storesList));
    
    
    

 
  }
}
