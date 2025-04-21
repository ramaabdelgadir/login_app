import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login_app/external/database/database_service.dart';
import 'package:login_app/external/model/store_model.dart';
import 'package:login_app/single_store/service/repo/single_store_repo.dart';
import 'package:meta/meta.dart';


part 'single_store_event.dart';
part 'single_store_state.dart';

class SingleStoreBloc extends Bloc<SingleStoreEvent, SingleStoreState> {
  SingleStoreBloc() : super(SingleStoreInitial()) {
    on<AddStoreToFavoEvent>(addStoreToFavo);
    on<RemoveStoreFromFavoEvent>(removeStoreFromFave);
  }

  
  DatabaseService _databaseService = DatabaseService.instance;

  FutureOr<void> addStoreToFavo(AddStoreToFavoEvent event, Emitter<SingleStoreState> emit) async{
    emit(SingleStoreAddingLoadingState());
    final Map<String,dynamic> response = await SingleStoreRepo.addStoreToFavo(event.storeModel.id);
    if (response['status']){
    final sqlResponse =await _databaseService.addStore(event.storeModel);
    
    if (sqlResponse){
      emit(SingleStoreAddingSuccessState());
    }else{
      emit(SingleStoreAddingFailedState());
    }
      }
    else{
      emit(SingleStoreAddingFailedState());
    }

  }


  FutureOr<void> removeStoreFromFave(RemoveStoreFromFavoEvent event, Emitter<SingleStoreState> emit)async {
    emit(SingleStoreRemovingFromLoadingState());
     final Map<String,dynamic> response = await SingleStoreRepo.removeStoreFromFavo(event.storeid);
    if (response['status']){
      
    final response =await _databaseService.deleteStore(event.storeid);
    if (response){
      emit(SingleStoreRemovingFromSuccessState());
    }else{
      emit(SingleStoreRemovingFromFailedState());
    }

    }
    else{
      emit(SingleStoreRemovingFromFailedState());
    }
  }

}

 
  
