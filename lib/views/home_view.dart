import 'package:flutter/material.dart';
import 'package:login_app/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    child: Image.asset(
                      'assets/images/user.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Name and Email text
                  const Text(
                    "Mohammed Shaker",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "20210777@example.com",
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 20),
                  // Profile button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
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
        ],
      ),
    );
  }
}
