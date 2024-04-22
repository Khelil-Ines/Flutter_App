import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sidi_bou/HistoriqueScreen.dart';
import 'package:sidi_bou/RateScreen.dart';
import 'package:sidi_bou/VoiceCommentScreen.dart';
import 'package:sidi_bou/auth.dart';
import 'package:sidi_bou/firebase_options.dart';
import './SignupScreen.dart';
import './LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import './HomeScreen.dart';
import 'package:sidi_bou/settings/settings_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sidi Bou Said',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Auth(),
      routes: {
        // '/': (context) => const Auth(),
        'SettingScreen': (context) => const SettingsPage(),
        'HomeScreen': (context) => const HomeScreen(),
        'SignUpScreen': (context) => const SignupScreen(),
        'LoginScreen': (context) => const LoginScreen(),
        'RateScreen': (context) => const RateScreen(),
        'VoiceCommentScreen': (context) => const VoiceCommentScreen(),
        'HistoriqueScreen': (context) => const HistoriqueScreen(),
      },
    );
  }
}
