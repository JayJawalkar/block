import 'package:exam_block/Widgets/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
            const Center(
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: _userNameController,
                decoration: const InputDecoration(
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
            const SizedBox(
              height: 80,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
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
            const SizedBox(
              height: 80,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
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
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                );
              },
              focusElevation: 20,
              label: const Text("SIGN UP"),
              hoverElevation: 20,
              icon: const Icon(Icons.login_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
