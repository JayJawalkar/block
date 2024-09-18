// ignore_for_file: use_build_context_synchronously

import 'package:exam_block/Widgets/home_page.dart';
import 'package:exam_block/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passCotroller = TextEditingController();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Block Managment",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.white12),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: "Enter Email-Id",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    prefixIcon: Icon(Icons.mail),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: _passCotroller,
                  decoration: InputDecoration(
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
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passCotroller.text)
                      .then((value) {
                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  }).onError(
                    (error, stackTrace) {
                      {
                        final snackBar = SnackBar(
                          content: const Text('Login fail!!'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {

                            },
                          ),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  );
                },
                focusElevation: 20,
                label: const Text("LOGIN"),
                hoverElevation: 20,
                icon: const Icon(Icons.login),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Don't have an Account?",
                      style: TextStyle(fontSize: 16)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign-Up",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
