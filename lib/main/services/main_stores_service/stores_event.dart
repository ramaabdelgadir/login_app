part of 'stores_bloc.dart';

abstract class StoresEvent {}

class StoresGetDataEvent extends StoresEvent {
  final bool firsttime;
  StoresGetDataEvent({required this.firsttime});
}
