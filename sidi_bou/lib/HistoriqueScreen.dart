import 'package:flutter/material.dart';
import 'package:sidi_bou/navigation_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoriqueScreen extends StatefulWidget {
  const HistoriqueScreen({Key? key});

  @override
  State<HistoriqueScreen> createState() => _HistoriqueScreenState();
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navigation_drawer(),
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text(
            'Learn more about Sidi Bou Said !',
            style: GoogleFonts.robotoCondensed(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.blue[600],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://www.boky.tn/wp-content/uploads/2023/07/The-beautiful-towns-of-Northern-Tunisia-Bizerte-and-Sidi-Bou-Said.png"), // Replace with your image URL
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 100,
                width: 200,
                child: Image.asset('images/mascotte.png'),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text(
                    'Sidi Bou Said (Arabic: سيدي بو سعيد Sīdi Bū Sʻīdⓘ) is a town in northern Tunisia located about 20 km northeast from the capital, Tunis. Cafe de delice and coast view Named after a religious figure who lived there, Abu Said al-Baji, it was previously called Jabal el-Menar. The town itself is a tourist attraction and is known for its extensive use of blue and white. It can be reached by a TGM train, which runs from Tunis to La Marsa. In the 12th century/13th century AD Abu Said Ibn Khalaf Yahya al-Tamimi al-Beji arrived in the village of Jabal el-Menar and established a sanctuary. After his death in 1231, he was buried there. In the 18th century wealthy citizens of Tunis built residences in Sidi Bou Said. During the 1920s, Rodolphe d\'Erlanger introduced the blue-white theme to the town. His home, Ennejma Ezzahra, is now a museum that has a collection of musical instruments, and organizes concerts of classical and Arabic music',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSerif(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                ),
                child: Text(
                  'Press to play!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed('HistoriqueScreen');
                },
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.blue[900],
                  ),
                  child: const Text(
                    "Start Quizz",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
