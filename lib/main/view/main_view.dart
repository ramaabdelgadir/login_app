import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class MainView extends StatefulWidget {
  MainView({super.key, required this.firsttime});
  bool firsttime;
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentPageIndex = 1;
  int build_counter = 0;

  List<String> appBarText = ["Favorite", "Stores", "Profile"];

  @override
  Widget build(BuildContext context) {
    build_counter++;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentPageIndex = value;
            if (build_counter > 0 && widget.firsttime) {
              widget.firsttime = false;
            }
          });
        },
        currentIndex: currentPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favo"),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_mall_directory),
            label: "Stores",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "Profile",
          ),
        ],
        selectedItemColor: AppColors.mainColor,
      ),
      appBar: AppBar(
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        backgroundColor: AppColors.mainColor,
        title: Text(
          appBarText[currentPageIndex],
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
        leading: Container(),
      ),

      body:
          [
            FavoStoresView(),
            StoresView(firsttime: widget.firsttime),
            MainProfileView(),
          ][currentPageIndex],
    );
  }
}
