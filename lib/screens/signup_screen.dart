// ignore_for_file: use_build_context_synchronously
import 'package:exam_block/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 40.sp,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  hintText: "Enter User Name",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  prefixIcon: Icon(Icons.mail),
                  filled: true,
                  hintText: "Enter Email Id ",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                  ),
                  filled: true,
                  hintText: "Enter Password",
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  prefixIcon: const Icon(Icons.key),
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: _isObscure,
                controller: _passController,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passController.text)
                    .then(
                  (value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                );
              },
              focusElevation: 20,
              label: Text(
                "SIGN UP",
                style: TextStyle(fontSize: 6.sp),
              ),
              hoverElevation: 20,
              icon: Icon(
                Icons.login_rounded,
                size: 9.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
