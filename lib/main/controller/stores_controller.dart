import 'package:login_app/stores/controller/service/bloc/stores_bloc.dart';
import 'package:login_app/stores/model/store_model.dart';

class StoresController {
  final StoresBloc storesBloc = StoresBloc();
  

void getStoresData(){
  storesBloc.add(StoresGetDataEvent());
}

}