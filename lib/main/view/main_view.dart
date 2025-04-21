import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/main/services/main_service/main_bloc.dart';
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

class MainView extends StatelessWidget {
  
  final MainBloc mainBloc = MainBloc();
  int current_page_index = 1;
  List<String> appbarText = ["Favorite", "Stores", "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: BlocBuilder<MainBloc, MainState>(
        bloc: mainBloc,
        builder: (context, state) {
          int active_button =1;
          switch (state.runtimeType) {
            case GoToFavoScreenState:
              active_button =0;
            case GoToStoresScreenState:
              active_button=1;
            case GoToProfileScreenState:
              active_button=2;
            default:
              active_button =1;
          }
          return BottomNavigationBar(
            onTap: (value) {
              mainBloc.add(ChangedScreenEvent(pageIndex: value));
            },
            currentIndex: active_button,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favo",
              ),
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
          );
        },
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
        title: BlocBuilder<MainBloc, MainState>(
          bloc: mainBloc,
          builder: (context, state) {
            switch (state.runtimeType) {
              case GoToFavoScreenState:
                return Text(
                  "Favorite",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              case GoToStoresScreenState:
                return Text(
                  "Stores",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              case GoToProfileScreenState:
                return Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              default:
                 return Text(
                  "Stores",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
            }
          },
        ),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset('assets/images/logo.png', height: 50),
          ),
        ],
      ),

      body: BlocBuilder<MainBloc, MainState>(
        bloc: mainBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case GoToFavoScreenState:
              return FavoStoresView();
            case GoToStoresScreenState:
              return StoresView();
            case GoToProfileScreenState:
              return MainProfileView();
            default:
              return StoresView();
          }
        },
      ),
    );
  }
}
