part of 'stores_bloc.dart';

abstract class StoresEvent {}

class StoresGetDataEvent extends StoresEvent{
}
class AddStoreToFavoEvent extends StoresEvent{
  final int storeid;
  AddStoreToFavoEvent({required this.storeid});
}
class RemoveStoreFromFavoEvent extends StoresEvent{
  final int storeid;
  RemoveStoreFromFavoEvent({required this.storeid});
}

