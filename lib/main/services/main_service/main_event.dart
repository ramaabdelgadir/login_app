part of 'main_bloc.dart';

abstract class MainEvent {
  
}

class ChangedScreenEvent extends MainEvent{
  final int pageIndex;
  ChangedScreenEvent({required this.pageIndex});

}

