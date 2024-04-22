import 'package:flutter/material.dart';
import 'package:sidi_bou/navigation_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navigation_drawer(),
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 50.0),
          child: Text(
            'Welcome to Sidi Bou App !',
            style: GoogleFonts.robotoCondensed(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.blue[600],
      ),
      body: SafeArea(
        child: Flexible(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/test.jpg'),
                  // image: NetworkImage(
                  //     "https://i.pinimg.com/originals/f1/fa/ef/f1faefc6bc91bfa1f8abd86b9d3c0464.jpg"), // Replace with your image URL
                  fit: BoxFit
                      .fill, // Adjusts the image to cover the entire container
                ),
                color: Color.fromARGB(255, 70, 103, 140)),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 150,
                  child: Image.asset('images/tunisia.png'),
                ),
                Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.white.withOpacity(0.8),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text(
                      'Sidi Bou Said,       THE place to be 🧿!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.white.withOpacity(0.6),
                  // ),
                  child: Text(
                    'Press to begin!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed('HistoriqueScreen');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(60, 25, 60, 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue[900],
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                SizedBox(
                  height: 150,
                  child: Image.asset('images/mascotte.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
