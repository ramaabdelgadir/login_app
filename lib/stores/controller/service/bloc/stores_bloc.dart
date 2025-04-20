import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:login_app/stores/controller/service/repo/store_repo.dart';
import 'package:login_app/stores/model/store_model.dart';
import 'package:meta/meta.dart';

part 'stores_event.dart';
part 'stores_state.dart';

class StoresBloc extends Bloc<StoresEvent, StoresState> {
  StoresBloc() : super(StoresInitial()) {
   on<StoresGetDataEvent>(storesGetData);
   on<AddStoreToFavoEvent>(addStoreToFavo);
   on<RemoveStoreFromFavoEvent>(removeStoreFromFavo);
  }

  FutureOr<void> storesGetData(StoresGetDataEvent event, Emitter<StoresState> emit) async{
    emit(StoresGetDataLoadingState());
    final Map<String,dynamic>response = await StoreRepo.getStoresData() ;
    if (response['status']){
      
      final List studentFavoStores = response['favo'];
      final List<dynamic> storesList = response['data'].map((e){
         if (studentFavoStores.contains(e['store_id'])){
          e['favo']= true;
         }else{
          e['favo']=false;
         }
        return StoreModel.fromMap(e);
         }).toList();
      emit(StoresGetDataSuccessState(storesList: storesList));
    }else{
      emit(StoresGetDataFailedState());
    }
  }

  FutureOr<void> addStoreToFavo(AddStoreToFavoEvent event, Emitter<StoresState> emit) async {
    final Map<String,dynamic> response = await StoreRepo.addStoreToFavo(event.storeid);
    if (response['status']){
      emit(AddStoreToFavoSuccessState(message: response['message']));
    }
    else{
      emit(AddStoreToFavoFailedState(message: response['message']));
    }

  }


  FutureOr<void> removeStoreFromFavo(RemoveStoreFromFavoEvent event, Emitter<StoresState> emit)async {
    final Map<String,dynamic> response = await StoreRepo.removeStoreFromFavo(event.storeid);
    if (response['status']){
      emit(RemoveFromFavoSuccessfulState(message: response['message']));
    }
    else{
      emit(RemoveFromFavoFailedState(message: response['message']));
    }
  }
}
