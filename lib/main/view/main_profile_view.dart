import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/external/app_data.dart';
import 'package:login_app/external/theme/app_colors.dart';
import 'package:login_app/external/widget/custom_loading.dart';
import 'package:login_app/main/controller/main_profile_controller.dart';
import 'package:login_app/student/controller/service/bloc/student_bloc.dart';
import 'package:login_app/student/views/profile_view.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MainProfileView extends StatefulWidget {
 MainProfileView({super.key,required this.controller});
  final MainProfileController controller;

  @override
  State<MainProfileView> createState() => _MainProfileViewState();
}

class _MainProfileViewState extends State<MainProfileView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentBloc, StudentState>(
            bloc: widget.controller.studentBloc,
            builder: (context, state) {
              switch (state.runtimeType) {
                case StudentGetStudentDataLoadingState:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
             CustomLoading()
            
          ],
          );


                case StudentGetStudentDataSuccessfullState:
                  return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 330,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 5),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    "${AppData.SERVER_URL}/photos/profile_pics/${widget.controller.studentData?.profile_pic_path == null ? "DEFAULT_PROFILE_IMAGE.jpg" : widget.controller.studentData!.profile_pic_path}",
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 15),
          
                // Name and Email text
                Text(
                  widget.controller.studentData?.name ?? "No Student",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.controller.studentData?.email ?? "No Email",
                  style: TextStyle(fontSize: 16),
                ),
          
                const SizedBox(height: 20),
                // Profile button
                ElevatedButton(
                  onPressed: () async {
                    if (widget.controller.studentData == null) {
                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.error(
                          message: "You Dont Have an Account",
                        ),
                      );
                    } else {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => ProfilePage(
                                studentData: widget.controller.studentData!,
                              ),
                        ),
                      );
                      print(result);
                      if (result == true) {
                        widget.controller.getData();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "View Profile",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          )
          ]
          );

                default:
                return Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("an Error Occure"),
            ],
          )
          ],
          );
              }
            },
            listener: (context, state) {
              setState(() {
                widget.controller.showGetDataState(state, context);
              });
            },
          );
  }
}