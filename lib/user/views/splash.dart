import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:login_app/external/app_data.dart';
import 'package:login_app/external/theme/app_colors.dart';
import 'package:login_app/main/view/home_view.dart';
import 'package:login_app/user/views/login_view.dart';
import 'package:login_app/external/widget/custom_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void am_i_logged_in() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  final TextEditingController _textEditingController = TextEditingController();

  Future<bool> checkServer() async {
    print("Starting server check...");
    bool check = true;
    try {
      await http
          .get(Uri.parse(AppData.SERVER_URL!))
          .timeout(
            Duration(seconds: 5), //+
            onTimeout: () {
              //+
              check = false;
              throw TimeoutException('Server check timed out'); //+
            },
          );
    } catch (e) {
      check = false;
    }
    return check;
  }

  bool start_loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          start_loading
              ? Container(
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
                        borderRadius: BorderRadius.circular(15),
                      ),

                      height: 200,
                      width: 200,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballRotate,

                        colors: const [
                          AppColors.mainColor,
                          AppColors.mainColor,
                          AppColors.mainColor,
                        ],

                        // colors: const [Colors.white,Colors.white,Colors.white,],
                        strokeWidth: 2,
                      ),
                    ),
                  ],
                ),
              )
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        labelText: 'http://192.168.1.20:5000',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  start_loading = true;
                                });
                                AppData.SERVER_URL =
                                    _textEditingController.value.text;
                                if (await checkServer()) {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.success(
                                      message: "Connected Successfully",
                                    ),
                                  );
                                  am_i_logged_in();
                                } else {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message: "Error in connecting",
                                    ),
                                  );
                                }
                                setState(() {
                                  start_loading = false;
                                });
                              },
                              child: Text(
                                "Connect",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
