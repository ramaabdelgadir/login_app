import 'package:login_app/stores/controller/service/bloc/stores_bloc.dart';
import 'package:login_app/stores/model/store_model.dart';

class SingleStoreController {
  final StoreModel storeModel;
  late bool NEW_IS_FAVO_VALUE;
  SingleStoreController({required this.storeModel}){
    NEW_IS_FAVO_VALUE = storeModel.favo;
  }
   final StoresBloc storesBloc= StoresBloc();
   void addStoreToFavo(){
    storesBloc.add(AddStoreToFavoEvent(storeid: storeModel.id));
  }
   void removeStoreFromFavo(){
    storesBloc.add(RemoveStoreFromFavoEvent(storeid: storeModel.id));
  }
  
}