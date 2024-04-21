import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class navigation_drawer extends StatelessWidget {
  const navigation_drawer({super.key});
  Future<Map<String, String?>> getUserInfo() async {
    // Vérifiez si l'utilisateur est authentifié
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Récupérez l'ID de l'utilisateur connecté
      String userId = user.uid;

      // Récupérez les données de l'utilisateur à partir de Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Récupérez l'e-mail à partir des données de l'utilisateur
      String? email = (userSnapshot.data() as Map<String, dynamic>)['email'];

      // Récupérez l'image de profil à partir des données de l'utilisateur
      String? img = (userSnapshot.data() as Map<String, dynamic>)['imgprofile'];

      // Retournez un map contenant l'e-mail et l'image de profil
      return {'email': email, 'img': img};
    } else {
      // L'utilisateur n'est pas authentifié
      return {'email': null, 'img': null};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder<Map<String, String?>>(
            future: getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                String? email = snapshot.data?['email'];
                String? profilePictureUrl = snapshot.data?['img'];

                return UserAccountsDrawerHeader(
                  accountName: null,
                  accountEmail: Text(email ?? ''),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: profilePictureUrl != null
                        ? NetworkImage(profilePictureUrl)
                        : null, // Load the image if URL is available
                    child: profilePictureUrl == null
                        ? Icon(Icons.person)
                        : null, // Show default icon if URL is not available
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://proactivecreative.com/wp-content/uploads/2022/04/shades-of-blue-featured.jpg')),
                  ),
                );
              }
            },
          ),
          ListTile(
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              Icons.home,
              color: Color.fromARGB(255, 9, 51, 110),
            ), // Add leading icon for Home
            onTap: () {
              Navigator.of(context).pushReplacementNamed('HomeScreen');
            },
          ),
          ListTile(
            title: const Text(
              'History',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              Icons.book,
              color: Color.fromARGB(255, 9, 51, 110),
            ), // Add leading icon for History
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              'Quizz',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              Icons.quiz,
              color: Color.fromARGB(255, 9, 51, 110),
            ), // Add leading icon for Quizz
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text(
              'Maps',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              Icons.map,
              color: Color.fromARGB(255, 9, 51, 110),
            ), // Add leading icon for Maps
            onTap: () {
              //Navigator.of(context).pushReplacementNamed('MapScreen');
            },
          ),
          ListTile(
            title: const Text(
              'Settings',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              Icons.settings,
              color: Color.fromARGB(255, 9, 51, 110),
            ), // Add leading icon for Settings
            onTap: () {
              Navigator.of(context).pushReplacementNamed('SettingScreen');
            },
          ),
          ListTile(
            title: const Text(
              'Rate',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              Icons.star_rate,
              color: Color.fromARGB(255, 225, 225, 35),
            ), // Add leading icon for Rate
            onTap: () {
              Navigator.of(context).pushReplacementNamed('RateScreen');
            },
          ),
          Center(
            child: MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('LoginScreen');
              },
              child: Text('Sign out'),
              elevation: 15,
              color: Colors.red[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
