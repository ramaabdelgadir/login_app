import 'package:flutter/material.dart';
import 'package:login_app/theme/app_colors.dart';

class SignupPage extends StatefulWidget {
  final int step;

  const SignupPage({super.key, required this.step});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  String? _selectedGender;
  int? _selectedLevel;

  @override
  Widget build(BuildContext context) {
    int step = widget.step;
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
          // Title
          const Positioned(
            top: 60,
            left: 30,
            child: Text(
              "Create Account",
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
          // Signup Card
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
                  if (step == 1) ...[
                    const Text("Please fill out the following fields"),
                    const SizedBox(height: 15),
                    TextFormField(
                      textInputAction: TextInputAction.done,
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
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.textFieldColor,
                        labelText: "Student ID",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                  if (step == 2) ...[
                    const Text("Please fill out the following fields"),
                    const SizedBox(height: 15),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.textFieldColor,
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.textFieldColor,
                        labelText: "Confirm Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                  if (step == 3) ...[
                    const Text("Select Your Preferences"),
                    const SizedBox(height: 10),
                    const Text(
                      "Gender:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: "Male",
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                        const Text("Male"),
                        const SizedBox(width: 20),
                        Radio<String>(
                          value: "Female",
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                        const Text("Female"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Select Your Level:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      children: List.generate(4, (index) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<int>(
                              value: index + 1,
                              groupValue: _selectedLevel,
                              onChanged: (value) {
                                setState(() {
                                  _selectedLevel = value;
                                });
                              },
                            ),
                            Text("Level ${index + 1}"),
                          ],
                        );
                      }),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedGender = null;
                              _selectedLevel = null;
                            });
                          },
                          child: const Text(
                            "Clear",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 15),
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
                        if (step < 3) {
                          Navigator.pushReplacementNamed(
                            context,
                            '/signup/Step ${step + 1}',
                          );
                        } else {
                          Navigator.pushReplacementNamed(context, '/Home');
                        }
                      },
                      child: Text(
                        step < 3 ? "NEXT" : "FINISH",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Step $step of 3"),
                      if (step == 3)
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/Home');
                          },
                          child: const Text(
                            "SKIP",
                            style: TextStyle(
                              fontSize: 16,
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
