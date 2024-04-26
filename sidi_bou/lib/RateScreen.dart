import 'package:flutter/material.dart';
import 'package:sidi_bou/smiley_controller.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'navigation_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key});

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  double _rating = 5.0;
  String _currentAnimation = '5+';
  SmileyController _smileyController = SmileyController();

  void _onChanged(double value) {
    if (_rating == value) return;

    setState(() {
      var direction = _rating < value ? '+' : '-';
      _rating = value;
      _currentAnimation = '${value.round()}$direction';
    });
  }

  Future<void> _submitRating() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'rate': _rating});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Thank you for your rating!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
            elevation: 50.0,
          ),
        );
      }
    } catch (e) {
      print('Error submitting rating: $e');
      //essayer l'erreur en modifiant les règles sur Firebase
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ooops! an error accured, please try again!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(100.0)),
          elevation: 50.0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navigation_drawer(),
      appBar: AppBar(
        title: Center(
          child: Text(
            'Rate our App ⭐ !',
            style: GoogleFonts.robotoCondensed(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.blue[600],
      ),
      body: Container(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Container(
                    height: 300,
                    width: 700, // Adjust width if needed (originally 700)
                    color: Colors.blue[900],
                    child: FlareActor(
                      'assets/happiness_emoji.flr',
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      controller: _smileyController,
                      animation: _currentAnimation,
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                    ),
                    child: Center(
                        child: Text(
                      'slide to select rating',
                      style: TextStyle(color: Colors.white),
                    ))),
                SizedBox(
                  height: 20,
                  child: Container(
                    color: Colors.blue[900],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Slider(
                    activeColor: Colors.white,
                    inactiveColor: Colors.blue[300],
                    value: _rating,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    onChanged: _onChanged,
                  ),
                ),
                Text(
                  '$_rating',
                  style: TextStyle(color: Colors.blue[300]),
                  // Set text color to white
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200.0, // Set desired width
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () => _submitRating(),
                    child: Text('Submit Rating',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      elevation: 5.0, // Set elevation to 5.0
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
