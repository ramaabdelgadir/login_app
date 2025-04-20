import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/main/controller/home_controller.dart';
import 'package:login_app/main/view/stores_view.dart';
import 'package:login_app/user/controller/service/bloc/student_bloc.dart';
import 'package:login_app/external/theme/app_colors.dart';
import 'package:login_app/user/views/profile_view.dart';
import 'package:login_app/external/widget/custom_loading.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:login_app/external/app_data.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() {
          _controller.current_page_index = value;
        }),
        currentIndex: _controller.current_page_index,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.favorite,),label: "Favo"),
        BottomNavigationBarItem(icon: Icon(Icons.store_mall_directory),label: "Stores"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: "Profile"),
      ],
      ),
      appBar: AppBar(
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))),
        backgroundColor: AppColors.mainColor,
        title: Text(
              "Home",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      actions: [
          ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/logo.png', height: 50),
           ),    
            ],
      ),
      
      body: 
      [

        Column(),
        StoresView(),

        Column(
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
                    "${AppData.SERVER_URL}/profile_pics/${_controller.studentData?.profile_pic_path == null ? "DEFAULT_PROFILE_IMAGE.png" : _controller.studentData!.profile_pic_path}",
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 15),
          
                // Name and Email text
                Text(
                  _controller.studentData?.name ?? "No Student",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  _controller.studentData?.email ?? "No Email",
                  style: TextStyle(fontSize: 16),
                ),
          
                const SizedBox(height: 20),
                // Profile button
                ElevatedButton(
                  onPressed: () async {
                    if (_controller.studentData == null) {
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
                                studentData: _controller.studentData!,
                              ),
                        ),
                      );
                      print(result);
                      if (result == true) {
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
      ),][_controller.current_page_index]
    );
  }
}
