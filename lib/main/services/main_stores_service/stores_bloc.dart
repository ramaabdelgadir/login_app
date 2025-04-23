import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:login_app/external/database/database_service.dart';
import 'package:login_app/main/services/main_stores_service/repo/store_repo.dart';
import 'package:login_app/external/model/store_model.dart';

part 'stores_event.dart';
part 'stores_state.dart';

class StoresBloc extends Bloc<StoresEvent, StoresState> {
  StoresBloc() : super(StoresInitial()) {
    on<StoresGetDataEvent>(storesGetData);
  }

  FutureOr<void> storesGetData(
    StoresGetDataEvent event,
    Emitter<StoresState> emit,
  ) async {
    DatabaseService _databaseService = DatabaseService.instance;

    emit(StoresGetDataLoadingState());
    final Map<String, dynamic> response = await StoreRepo.getStoresData();
    if (response['status']) {
      final List studentFavoStores = response['favo'];
      final List<dynamic> storesList =
          response['data'].map((e) {
            if (studentFavoStores.contains(e['store_id'])) {
              if (event.firsttime) {
                _databaseService.addStore(StoreModel.fromMap(e));
              }

              e['favo'] = true;
            } else {
              e['favo'] = false;
            }
            return StoreModel.fromMap(e);
          }).toList();
      emit(StoresGetDataSuccessState(storesList: storesList));
    } else {
      emit(StoresGetDataFailedState());
    }
  }
}
