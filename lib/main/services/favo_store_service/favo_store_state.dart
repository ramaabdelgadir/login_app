part of 'favo_store_bloc.dart';

abstract class FavoStoreState {}

final class FavoStoreInitial extends FavoStoreState {}

class GetAllStoresFromFavoSuccessState extends FavoStoreState{
  final List storesList;
  GetAllStoresFromFavoSuccessState({required this.storesList});
}
class GetAllStoresFromFavoZeroStoreState extends FavoStoreState{}
class GetAllStoresFromFavoFailedState extends FavoStoreState{}
class GetAllStoresFromFavoLoadingState extends FavoStoreState{}
