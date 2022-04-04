import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int randomNumber = Random().nextInt(100);
  TextEditingController userInputController = TextEditingController();
  String messageToUser = '';
  String guessButtonText = 'Guess';
  bool reset = false;
  bool visibleMessage = false;

  void changed(bool visibility, String field) {
    setState(() {
      if (field == "messageText"){
        visibleMessage = visibility;
      }
    });
  }

  void resetGame() {
    randomNumber = Random().nextInt(100);
    changed(false, "messageText");
    guessButtonText = 'Guess';
    userInputController.clear();
    reset = false;
  }

  void userGuess(String userInput) {
    int userInputToInt = int.parse(userInput);
    if (userInput.isEmpty || int.tryParse(userInput) == null) {
      // TODO
    }
    if(userInputToInt == randomNumber) {
      setState(() {
        messageToUser = 'You tried $userInputToInt\nYou guessed right.';
        guessButtonText = 'Reset';
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text('You guessed right'),
                content: Text('It was $userInputToInt'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Try again!'),
                    onPressed: () {
                      reset = false;
                      randomNumber = Random().nextInt(100);
                      guessButtonText = 'Guess';
                      changed(false, "messageText");
                      userInputController.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      setState(() {
                        reset = true;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
        );
      });
    }
    else if(userInputToInt < randomNumber) {
      setState(() {
        messageToUser = 'You tried $userInputToInt\nTry higher';
      });
    }
    else if(userInputToInt > randomNumber) {
      setState(() {
        messageToUser = 'You tried $userInputToInt\nTry lower';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Text('Guess my number'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: [
                Padding(padding: const EdgeInsets.all(16.0),
                child: Text(
                  'I\'m thinking of a number between 1 and 100.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),),
                Padding(padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'It\'s your turn to guess my number!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),),
                visibleMessage ? (Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      messageToUser,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xA0000000),
                          fontSize: 36.0
                      ),
                    )
                )) : Container(),
              ],
            ),
            Container(
                child: Card(
                  margin: EdgeInsets.all(16.0),
                    elevation: 8,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Try a number!',
                          style: TextStyle(
                            color: Color(0xA0000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                            keyboardType: TextInputType.number,
                            controller: userInputController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                            ),
                          ),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0x60FFFFFF),
                              onPrimary: Colors.black,
                            ),
                            onPressed: () {
                              if(reset) {
                                resetGame();
                              }
                              else {
                                userGuess(userInputController.text);
                                changed(true, "messageText");
                              }
                            },
                            child: Text(guessButtonText)),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
