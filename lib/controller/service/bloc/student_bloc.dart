import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login_app/controller/service/model/student_model.dart';
import 'package:login_app/controller/service/repo/student_repo.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<StudentSignupEvent>(studentSignupEvent);
    on<StudentLoginEvent>(studentLoginEvent);
    on<StudentGetDataEvent>(studentGetDataEvent);
    on<StudentUpdateDataEvent>(studentUpdateDataEvent);
    on<StudentDeleteAccountEvent>(studentDeleteAccountEvent);
  }

  FutureOr<void> studentSignupEvent(StudentSignupEvent event, Emitter<StudentState> emit) async{
    emit(StudentSignupLoadingState());
    final Map<String,dynamic> response= await StudentRepo.signup(event.studentData);
    
    if (response['status']){
      emit(StudentSignupSuccessfullState(message: response['message']));
      }
    else{
      emit(StudentSignupFailedState(errorMessage: response['error']));
      }
  }

  FutureOr<void> studentLoginEvent(StudentLoginEvent event, Emitter<StudentState> emit)async {
    emit(StudentLoginLoadingState());
        final Map<String,dynamic> response= await StudentRepo.login(event.studentData);
    
    if (response['status']){
      emit(StudentLoginSuccessfullState(message: response['message']));
      }
    else{
      emit(StudentLoginFailedState(errorMessage: response['error']));
      }

  }

  FutureOr<void> studentGetDataEvent(StudentGetDataEvent event, Emitter<StudentState> emit) async{
    emit(StudentGetStudentDataLoadingState());
    final Map<String,dynamic> response= await StudentRepo.getStudentData();
    
    if (response['status']){
      final studentModel = StudentModel.fromResponse(response);
      emit(StudentGetStudentDataSuccessfullState(studentData: studentModel));
      }
    else{
      emit(StudentGetStudentDataFailedState(errorMessage: response['error']));
      }

  }

  FutureOr<void> studentUpdateDataEvent(StudentUpdateDataEvent event, Emitter<StudentState> emit)async {
        emit(StudentUpdateDataLoadingState());
    final Map<String,dynamic> response= await StudentRepo.updateStudentData(event.studentData);
    
    if (response['status']){
      print(response['message']);
      emit(StudentUpdateDataSuccessfullState(message: response['message']));
      }
    else{
      print(response['error']);
      emit(StudentUpdateDataFailedState(errorMessage: response['error']));
      }

  }
  }

  FutureOr<void> studentDeleteAccountEvent(StudentDeleteAccountEvent event, Emitter<StudentState> emit) {
  }


