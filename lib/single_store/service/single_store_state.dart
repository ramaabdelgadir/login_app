part of 'single_store_bloc.dart';

abstract class SingleStoreState {}

final class SingleStoreInitial extends SingleStoreState {}

class SingleStoreAddingFailedState extends SingleStoreState{}
class SingleStoreAddingLoadingState extends SingleStoreState{}
class SingleStoreAddingSuccessState extends SingleStoreState{}

class SingleStoreRemovingFromSuccessState extends SingleStoreState{}
class SingleStoreRemovingFromLoadingState extends SingleStoreState{}
class SingleStoreRemovingFromFailedState extends SingleStoreState{}
