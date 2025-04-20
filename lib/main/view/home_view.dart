import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/main/controller/main_controller.dart';
import 'package:login_app/main/controller/main_profile_controller.dart';
import 'package:login_app/main/controller/stores_controller.dart';
import 'package:login_app/main/view/favo_stores_view.dart';
import 'package:login_app/main/view/main_profile_view.dart';
import 'package:login_app/main/view/stores_view.dart';
import 'package:login_app/student/controller/service/bloc/student_bloc.dart';
import 'package:login_app/external/theme/app_colors.dart';
import 'package:login_app/student/views/profile_view.dart';
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
  final MainController _controller = MainController();
  final MainProfileController _main_profile_controller = MainProfileController();
  final StoresController _storesController = StoresController();

  @override
  void initState() {
    setState(() {
      _controller.onPageChange(1, _main_profile_controller,_storesController);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() {
          _controller.onPageChange(value, _main_profile_controller,_storesController);
        }),
        currentIndex: _controller.current_page_index,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.favorite,),label: "Favo"),
        BottomNavigationBarItem(icon: Icon(Icons.store_mall_directory),label: "Stores"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: "Profile"),
      ],
      selectedItemColor: AppColors.mainColor,
      ),
      appBar: AppBar(
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))),
        backgroundColor: AppColors.mainColor,
        title: Text(
             _controller.appbarText[_controller.current_page_index],
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
        FavoStoresView(),
        StoresView(
          controller: _storesController
          ),
        MainProfileView(
          controller: _main_profile_controller
          )
      ]
      [_controller.current_page_index]
    );
  }
}
