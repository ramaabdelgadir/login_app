part of 'single_store_bloc.dart';

abstract class SingleStoreEvent {}

class AddStoreToFavoEvent extends SingleStoreEvent{
  final StoreModel storeModel;
  AddStoreToFavoEvent({required this.storeModel});
}

class RemoveStoreFromFavoEvent extends SingleStoreEvent{
  final int storeid;
  RemoveStoreFromFavoEvent({required this.storeid});
}
