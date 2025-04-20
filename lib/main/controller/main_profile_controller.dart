import 'package:flutter/cupertino.dart';
import 'package:login_app/student/controller/service/bloc/student_bloc.dart';
import 'package:login_app/student/model/student_model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MainProfileController {

  final StudentBloc studentBloc = StudentBloc();


  StudentModel? studentData;
  MainProfileController(){
  }
  void getData(){
    studentBloc.add(StudentGetDataEvent());
  }
  
  void showGetDataState(StudentState state,BuildContext context){
    switch(state.runtimeType){
      case StudentGetStudentDataSuccessfullState:{
        state = state as StudentGetStudentDataSuccessfullState;
        studentData= state.studentData;
      }
      case StudentGetStudentDataFailedState:{
        state = state as StudentGetStudentDataFailedState;
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(message:state.errorMessage),
          );
      }
    }

  }
}