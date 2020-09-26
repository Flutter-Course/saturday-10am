import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> questions = [
    'Have you ever wrote a letter?',
    'Have you ever smoked a cigarette?',
    'Have you ever been hit on by someone who was too old?',
    'Have you ever been on the radio or on television?',
    'Have you ever stayed awake for an entire night?',
    'Have you ever broken something, like a window, and ran away?',
    'Have you ever won a contest and received a prize?',
    'Have you ever met a famous person or a celebrity?',
  ];

  int index = 0, yesCounter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Have You Ever'),
      ),
      body: Center(
        child: (index < 5)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    questions[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.green[900],
                    onPressed: () {
                      setState(() {
                        index++;
                        yesCounter++;
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      'No',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        index++;
                      });
                    },
                  )
                ],
              )
            : Column(
                children: [
                  Image.asset(
                    'assets/images/${(yesCounter >= 3) ? 'loser' : 'winner'}.png',
                  ),
                  RaisedButton(
                    child: Text('Play Again'),
                    onPressed: () {
                      setState(() {
                        index = 0;
                        yesCounter = 0;
                        questions.shuffle();
                      });
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
