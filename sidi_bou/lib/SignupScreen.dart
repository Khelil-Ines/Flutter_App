import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pseudoController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isEmailValid(String email) {
    RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._]+@gmail+\.[a-zA-Z]+',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email);
  }

  Future<void> SignUp() async {
    if (!isEmailValid(_emailController.text.trim())) {
      showAlertDialog('Error', 'Please enter a valid email address.');
      return;
    }
    // Check if any of the fields are empty
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _pseudoController.text.trim().isEmpty) {
      showAlertDialog('Error', 'Please fill in all fields.');
      return;
    }

    // Confirm the password
    if (!passwordConfirmed()) {
      showAlertDialog('Error', 'Passwords do not match.');
      return;
    }

    try {
      // Attempt to create a new user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Set additional user information in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': _emailController.text.trim(),
        'comments': [],
        'foodscore': 0,
        'placescore': 0,
        'maraboutscore': 0,
        'imgprofile': null, // Use 'null' instead of 'Null'
        'pseudo': _pseudoController.text.trim(),
        'rate': 0
      });

      // Redirect the user to the login screen upon successful registration
      Navigator.of(context).pushNamed('HomeScreen');
    } catch (e) {
      // Print the error to the console and show an error dialog
      print('An error occurred during sign up: $e');
      showAlertDialog('Error',
          'An error occurred while creating your account. Please try again.');
    }
  }

  void showAlertDialog(String title, String content) {
    // Display an alert dialog with the provided title and content
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  void openLoginScreen() {
    Navigator.of(context).pushReplacementNamed('LoginScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[700],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //image
                  Image.asset(
                    'images/mascotte.png',
                    height: 100,
                  ),
                  SizedBox(height: 30),

                  //Title
                  Text(
                    'SIGN UP',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  //Subtitle
                  Text(
                    'Get Started with Sidi Bou App !',
                    style: GoogleFonts.robotoCondensed(fontSize: 18),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  //EMAIL
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Nickname
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _pseudoController,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Nickname'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Password'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Confirm Password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm Password'),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  //Button SignUP
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: SignUp,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red[900],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                            child: Text(
                          'Sign up',
                          style: GoogleFonts.robotoCondensed(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  //TEXT ALREADY A MEMBER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member? ',
                        style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                          onTap: openLoginScreen,
                          child: Text(
                            'Sign in here',
                            style: GoogleFonts.robotoCondensed(
                              color: Colors.red[500],
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
