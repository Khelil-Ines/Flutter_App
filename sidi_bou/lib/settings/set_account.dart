import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sidi_bou/widgets/edit_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SetAccount extends StatefulWidget {
  const SetAccount({Key? key}) : super(key: key);
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
  State<SetAccount> createState() => _SetAccountState();
}

class _SetAccountState extends State<SetAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Account'),
        leading: IconButton(
          icon: const Icon(Ionicons.chevron_back_outline),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Photo",
                widget: FutureBuilder<Map<String, String?>>(
                  future: widget.getUserInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      String? profilePictureUrl = snapshot.data?['img'];

                      return Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: profilePictureUrl != null
                                ? NetworkImage(profilePictureUrl)
                                : null, // Load the image if URL is available
                            child: profilePictureUrl == null
                                ? Icon(Icons.person)
                                : null, // Show default icon if URL is not available
                            radius:
                                50, // Adjust the radius according to your preference
                          ),
                          const SizedBox(height: 10),
                          Text(
                            snapshot.data?['email'] ?? '', // Display the email
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              const EditItem(
                title: "Name",
                widget: TextField(),
              ),
              const SizedBox(height: 40),
              const EditItem(
                widget: TextField(),
                title: "Email",
              ),
              const SizedBox(height: 40),
              const EditItem(
                widget: TextField(),
                title: "Current Password",
              ),
              const SizedBox(height: 40),
              const EditItem(
                widget: TextField(),
                title: "New password",
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {}, // Replace with your button action
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fixedSize: const Size(68, 58),
                      backgroundColor:
                          Colors.blue, // Set background color to blue
                      foregroundColor:
                          Colors.white, // Set text and icon color to white
                    ),
                    child: const Icon(Ionicons
                        .checkmark), // Center icon using const constructor
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
