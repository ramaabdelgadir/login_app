import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:login_app/theme/app_colors.dart';
import 'package:login_app/views/home_view.dart';
import 'package:login_app/views/login_view.dart';
import 'package:login_app/widget/custom_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void am_i_logged_in()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token =  prefs.getString('token');
    if (token==null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
      }
    else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
  }
  }

  @override
  void initState() {
    am_i_logged_in();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(60),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15)
            ),

            height: 200,
            width: 200,
            child: LoadingIndicator(
              indicatorType: Indicator.ballRotate,

              colors: const [AppColors.mainColor,AppColors.mainColor,AppColors.mainColor,],
              // colors: const [Colors.white,Colors.white,Colors.white,],

              strokeWidth: 2,
            ),
          ),
        ],
      ),
    )
      ],
      ),
    );
  }
}