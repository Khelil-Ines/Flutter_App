import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class navigation_drawer extends StatelessWidget {
  const navigation_drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          MaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('LoginScreen');
            },
            color: Colors.amber,
            child: Text('Sign out'),
          )
        ],
      ),
    );
  }
}
