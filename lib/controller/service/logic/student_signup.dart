import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_app/controller/service/bloc/student_bloc.dart';
import 'package:login_app/controller/service/model/student_model.dart';
import 'package:quickalert/quickalert.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class StudentContorller {
  final GlobalKey<FormState> formstate = GlobalKey();

  final List<TextEditingController> textFieldControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  final StudentBloc studentBloc = StudentBloc();

  StudentModel studentModel = StudentModel(
    name: "name",
    email: " email",
    password: "password",
    student_id: 0,
  );

  StudentContorller() {}

  void updateData() async {
    File? _image;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
    final Map<String, dynamic> data = {
      'profile_pic_path': _image?.path ?? "#",
      "name": "Magdi wlaeed mohamed",
      "email": "202108812666@gmail.com",
      "password": "20210886",
      "student_id": 0,
      "level": 4,
      "gender": 1,
    };

    studentBloc.add(StudentUpdateDataEvent(studentData: data));
  }

  void getData() {
    studentBloc.add(StudentGetDataEvent());
  }

  void gettingDataState(StudentState state) {
    switch (state.runtimeType) {
      case StudentGetStudentDataSuccessfullState:
        {
          state = state as StudentGetStudentDataSuccessfullState;
          print('///////////////////');
          print('///////////////////');
          print('///////////////////');
          studentModel = state.studentData;
        }
      case StudentGetStudentDataFailedState:
        {
          state = state as StudentGetStudentDataFailedState;
          print('///////////////////');
          print('///////////////////');
          print('///////////////////');
          print(state.errorMessage);
        }
    }
  }

  void login() {
    final Map<String, dynamic> domy = {
      "email": "202108812666@gmail.com",
      "password": "20210886",
    };
    studentBloc.add(StudentLoginEvent(studentData: domy));
  }

  void showLoginState(StudentState state, BuildContext context) {
    switch (state.runtimeType) {
      case StudentLoginSuccessfullState:
        {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(message: "Logged In Successfully"),
          );
        }
      case StudentLoginFailedState:
        {
          state = state as StudentLoginFailedState;
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(message: state.errorMessage),
          );
        }
    }
  }

  void signup() {
    final Map<String, dynamic> domy = {
      "name": "Magdi wlaeed mohamed",
      "email": "202108812666@gmail.com",
      "student_id": 20210886,
      "password": "20210886",
      "confirmPassword": "20210886",
    };
    studentBloc.add(StudentSignupEvent(domy));
  }

  void showSignupState(StudentState state, BuildContext context) {
    switch (state.runtimeType) {
      case StudentSignupSuccessfullState:
        {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(
              message: "The Account Has Been Created Successfully",
            ),
          );
        }
      case StudentSignupFailedState:
        {
          state = state as StudentSignupFailedState;
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(message: state.errorMessage),
          );
        }
    }
  }
}
