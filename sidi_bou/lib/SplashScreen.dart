// import 'package:flutter/material.dart';
// import 'package:sidi_bou/LoginScreen.dart';
// import 'package:sidi_bou/auth.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Ajoutez un délai pour afficher le splash screen pendant quelques secondes
//     Future.delayed(Duration(seconds: 1), () {
//       // Naviguez vers l'écran principal de votre application
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => Auth()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Image.asset(
//           'images/mascotte.png',
//           height: 250,
//         ),
//       ),
//     );
//   }
// }
