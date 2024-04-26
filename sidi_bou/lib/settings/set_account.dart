import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sidi_bou/HomeScreen.dart';
import 'package:sidi_bou/LoginScreen.dart';
import 'package:sidi_bou/core/Config.dart';
import 'package:sidi_bou/settings/settings_page.dart';
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

      String? pseudo = (userSnapshot.data() as Map<String, dynamic>)['pseudo'];

      // Retournez un map contenant l'e-mail et l'image de profil
      return {'email': email, 'img': img, 'pseudo': pseudo};
    } else {
      // L'utilisateur n'est pas authentifié
      return {'email': null, 'img': null, 'pseudo': null};
    }
  }

  @override
  State<SetAccount> createState() => _SetAccountState();
}

class _SetAccountState extends State<SetAccount> {
  String imageURL = '';

  var currentPass = TextEditingController();
  var newPass = TextEditingController();

  var emailController = TextEditingController();
  var pseudoController = TextEditingController();

  Future<void> pickImage() async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File(result.files.single.path!);

      DocumentReference imageDoc =
          await FirebaseFirestore.instance.collection('users').add({
        'imgprofile': '',
      });
      Reference imageRef = FirebaseStorage.instance.ref(imageDoc.id + '.jpg');
      await imageRef.putFile(file);
      imageURL = await imageRef.getDownloadURL();

      imageDoc.update({'imgProfile': imageURL});
      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Image modifiée avec succès !'),
      )); // Afficher un message de succès
    } else {
      // Gérer le cas où l'utilisateur annule la sélection de l'image
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Config.Localization["setAccount"]),
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
              Text(
                Config.Localization["account"],
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: Config.Localization["photo"],
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
                                : null,
                            child: profilePictureUrl == null
                                ? Icon(Icons.person)
                                : null,
                            radius: 50,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: pickImage,
                                child: Text(
                                  Config.Localization["uploadImg"],
                                  style: GoogleFonts.robotoCondensed(
                                    color: Colors.blue[500],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              EditItem(
                widget: FutureBuilder<Map<String, String?>>(
                  future: widget.getUserInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      String? userPseudo = snapshot.data?['pseudo'];

                      return TextField(
                        controller: pseudoController,
                        decoration: InputDecoration(
                          hintText: userPseudo ?? '',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      );
                    }
                  },
                ),
                title: "Pseudo",
              ),
              EditItem(
                widget: FutureBuilder<Map<String, String?>>(
                  future: widget.getUserInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      String? userEmail = snapshot.data?['email'];

                      return TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: userEmail ?? '',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      );
                    }
                  },
                ),
                title: "Email",
              ),
              SizedBox(height: 40),
              Text(
                Config.Localization["pwd"],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: currentPass,
                  decoration:
                      InputDecoration(hintText: Config.Localization["current"]),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: newPass,
                  decoration:
                      InputDecoration(hintText: Config.Localization["new"]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (currentPass.value.text.isNotEmpty &&
                        newPass.value.text.isNotEmpty) {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: FirebaseAuth.instance.currentUser!.email!,
                          password: currentPass.text,
                        );

                        await userCredential.user!.updatePassword(newPass.text);

                        // Mettez à jour le mot de passe dans Firestore
                        String userId = FirebaseAuth.instance.currentUser!.uid;
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .update({'password': newPass.text});

                        // Déconnectez l'utilisateur
                        await FirebaseAuth.instance.signOut();

                        // Naviguez vers la page de connexion
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );

                        // Affichez un message de succès
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Password changed with success')),
                        );
                      } catch (error) {
                        print("Error while changing your password: $error");
                      }
                    }
                  },
                  child: Text(Config.Localization["update"]),
                ),
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (emailController.value.text.isNotEmpty) {
                        try {
                          await FirebaseAuth.instance.currentUser!
                              .updateDisplayName(emailController.text);
                          // Mettez à jour l'email' dans Firestore
                          String userId =
                              FirebaseAuth.instance.currentUser!.uid;
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userId)
                              .update({'email': emailController.text});
                          if (!mounted) return;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsPage()));
                        } catch (e) {
                          if (kDebugMode) {
                            print(e);
                          }
                        }
                      }
                      if (pseudoController.value.text.isNotEmpty) {
                        try {
                          await FirebaseAuth.instance.currentUser!
                              .updateDisplayName(pseudoController.text);
                          // Mettez à jour l'email' dans Firestore
                          String userId =
                              FirebaseAuth.instance.currentUser!.uid;
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userId)
                              .update({'pseudo': pseudoController.text});
                          if (!mounted) return;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsPage()));
                        } catch (e) {
                          if (kDebugMode) {
                            print(e);
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fixedSize: const Size(68, 58),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Icon(Ionicons.checkmark),
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
