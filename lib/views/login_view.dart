import 'package:flutter/material.dart';
import 'package:login_app/theme/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // Top Blue Container
          Container(
            height: 350,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),

          // Welcome Text
          Positioned(
            top: 60,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Welcome back",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Login",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),

          // Logo
          Positioned(
            top: 50,
            right: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                50,
              ), // Adjust the radius as needed
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                height: 60,
              ),
            ),
          ),

          // Login Card with Padding
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
                  // Email TextField
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.textFieldColor,
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Password TextField
                  TextFormField(
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.textFieldColor,
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Login Button
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/Home');
                      },
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Sign Up Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            '/signup/Step 1',
                          );
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ],
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
