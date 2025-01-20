import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/authService.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = Get.put(AuthService());

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthService>(builder: (as) {
      return as.isLoading
          ? Container(
              color: Colors.white,
              child: const Center(
                  child: CircularProgressIndicator(color: Colors.deepPurple)))
          : Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.store,
                          size: 140, color: Colors.deepPurple),
                      const Text(
                        'Shop Name',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 50),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter your phone number',
                          labelText: 'Phone number',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          authService.signin(
                              identifier: phoneController.text,
                              password: passwordController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          minimumSize: const Size(double.infinity,
                              50), // double.infinity is the width and 50 is the height
                        ),
                        child: const Text('Sign In',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
