import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/controller/home_controller.dart';
import 'package:login_app/controller/service/bloc/student_bloc.dart';
import 'package:login_app/theme/app_colors.dart';
import 'package:login_app/views/profile_view.dart';
import 'package:login_app/widget/custom_loading.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeController();
  @override
  void initState() {
    setState(() {
      
    _controller.getData();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // Top Blue Container
          Container(
            height: 150,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
    
          // Home Text
          const Positioned(
            top: 60,
            left: 40,
            child: Text(
              "Home",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
    
          // Logo
          Positioned(
            top: 50,
            right: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/logo.png', height: 60),
            ),
          ),
    
          // User Info Card
          Align(
            alignment: Alignment.center,
            child: Container(
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
                    child:Image.network(
                     "http://192.168.1.6:5000/profile_pics/${_controller.studentData?.profile_pic_path ==null?"DEFAULT_PROFILE_IMAGE.png":_controller.studentData!.profile_pic_path}",
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                     ),
                  ),
                  const SizedBox(height: 15),
    
                  // Name and Email text
                   Text(
                    _controller.studentData?.name??"No Student",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                   Text(
                    _controller.studentData?.email??"No Email",
                    style: TextStyle(fontSize: 16),
                  ),
    
                  const SizedBox(height: 20),
                  // Profile button
                  ElevatedButton(
                    onPressed: () async{
                      if (_controller.studentData ==null){
                        showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: "You Dont Have an Account",
                            ),
                        );
                      }else{
                        final result =await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>ProfilePage(studentData: _controller.studentData!,)));
                          print(result);
                          if (result == true){
                            _controller.getData();
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
            ),
          ),
          BlocConsumer<StudentBloc, StudentState>(
            bloc: _controller.studentBloc,
            builder: (context, state) {
              switch (state.runtimeType) {
                case StudentGetStudentDataLoadingState:
                  {
                    return Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: CustomLoading(),
                    );
                  }
                default:
                  {
                    return Container();
                  }
              }
            },
            listener: (context, state) {
              setState(() {
                _controller.showGetDataState(state, context);
              });
            },
          ),
        ],
      ),
    );
  }
}
