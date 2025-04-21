part of 'stores_bloc.dart';

abstract class StoresState {}

final class StoresInitial extends StoresState {}


class StoresGetDataLoadingState extends StoresState{}
class StoresGetDataSuccessState extends StoresState{
  final List storesList;
  StoresGetDataSuccessState({required this.storesList}); 
}
class StoresGetDataFailedState extends StoresState{}


class AddStoreToFavoSuccessState extends StoresState{
  final String message;
  AddStoreToFavoSuccessState({required this.message});
}

class AddStoreToFavoFailedState extends StoresState{
  final String message;
  AddStoreToFavoFailedState({required this.message});
}

class RemoveFromFavoSuccessfulState extends StoresState{
  final String message;
  RemoveFromFavoSuccessfulState({required this.message});
}
class RemoveFromFavoFailedState extends StoresState{
  final String message;
  RemoveFromFavoFailedState({required this.message});
}