import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_app/theme/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController(
    text: "Mohammed Shaker",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "20210777@stud.fci-cu.edu.eg",
  );
  final TextEditingController _studentIdController = TextEditingController(
    text: "20210777",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "mypassword123",
  );

  bool _isPasswordVisible = false;
  String? _selectedGender = "Male";
  int? _selectedLevel = 2;
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // Top blue container
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          // Profile title
          const Positioned(
            top: 60,
            left: 40,
            child: Text(
              "Profile",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          // Logo image
          Positioned(
            top: 50,
            right: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/logo.png', height: 60),
            ),
          ),
          // Profile form card
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Container(
                  width: 330,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 30),
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
                      // User image
                      GestureDetector(
                        onTap: _pickImage,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child:
                              _image != null
                                  ? Image.file(
                                    _image!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )
                                  : Image.asset(
                                    'assets/images/user.png',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                        ),
                      ),
                      const Text(
                        "Tap to change the image",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),

                      const SizedBox(height: 15),

                      // Name field
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          filled: true,
                          fillColor: AppColors.textFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Email field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          filled: true,
                          fillColor: AppColors.textFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Student ID field
                      TextFormField(
                        controller: _studentIdController,
                        decoration: InputDecoration(
                          labelText: "Student ID",
                          filled: true,
                          fillColor: AppColors.textFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Password field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          fillColor: AppColors.textFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Preferences Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Gender selection
                            const Text(
                              "Gender:",
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: "Male",
                                  groupValue: _selectedGender,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                  activeColor: Colors.white,
                                  fillColor: WidgetStateProperty.resolveWith(
                                    (states) => Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Male",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Radio<String>(
                                  value: "Female",
                                  groupValue: _selectedGender,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                  activeColor: Colors.white,
                                  fillColor: WidgetStateProperty.resolveWith(
                                    (states) => Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Female",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Level selection
                            const Text(
                              "Level:",
                              style: TextStyle(color: Colors.white),
                            ),
                            Wrap(
                              spacing: 10,
                              children: List.generate(4, (index) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio<int>(
                                      value: index + 1,
                                      groupValue: _selectedLevel,
                                      onChanged: (int? value) {
                                        setState(() {
                                          _selectedLevel = value;
                                        });
                                      },
                                      activeColor: Colors.white,
                                      fillColor:
                                          WidgetStateProperty.resolveWith(
                                            (states) => Colors.white,
                                          ),
                                    ),
                                    Text(
                                      "Level ${index + 1}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                            const SizedBox(height: 10),

                            // Clear Button
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedGender = null;
                                    _selectedLevel = null;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppColors.mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                ),
                                child: const Text("Clear"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Save Changes button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/Home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Save Changes",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
