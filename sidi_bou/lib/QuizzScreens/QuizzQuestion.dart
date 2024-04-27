import 'package:flutter/material.dart';

class QuizzQuestion extends StatefulWidget {
  const QuizzQuestion({super.key});

  @override
  State<QuizzQuestion> createState() => _QuizzQuestionState();
}

class _QuizzQuestionState extends State<QuizzQuestion> {
  List<Map<String, dynamic>> questions = [
    {
      'questionText': 'What is this called?',
      'answers': ['Bambalouni', 'Balbalouni', 'Banbalouni'],
      'correctAnswerIndex': 0,
    },
    {
      'questionText': 'What famous Coffee Shop is this?',
      'answers': ['Delta Coffe Shop', 'Delice Coffee Shop', 'Sidi Coffee Shop'],
      'correctAnswerIndex': 1,
    },
  ];
  int questionIndex = 0;
  int score = 0;

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[questionIndex]['correctAnswerIndex']) {
      score++;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Correct!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Wrong!'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    }

    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      // Navigate to results page or show score
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Finished!'),
          content: Text('You scored $score out of ${questions.length}'),
          actions: <Widget>[
            TextButton(
              child: Text('Restart'),
              onPressed: () {
                setState(() {
                  questionIndex = 0;
                  score = 0;
                });
                Navigator.of(ctx).pop();
              },
            ),
            TextButton(
              child: Text('Quit'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('QuizzScreen');
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> answerButtons = questions[questionIndex]['answers']
        .asMap()
        .entries
        .map<Widget>((entry) {
      int idx = entry.key;
      String answer = entry.value;
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 20.0),
              iconColor: Colors.white,
            ),
            onPressed: () => checkAnswer(idx),
            child: Text(answer),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 10.0).copyWith(bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      questions[questionIndex]['questionText'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ...answerButtons, // Spread operator to include all buttons
            ],
          ),
        ),
      ),
    );
  }
}
