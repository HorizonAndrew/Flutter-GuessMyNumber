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
  TextEditingController numberEntered = TextEditingController();
  String userInput = '';
  String messageToUser = '';

  void testShape() {
    int userInputToInt = int.parse(numberEntered.text);
    userInput = numberEntered.text;

    int square = 0;
    int triangular = 0;

    for (int i = 1; i <= userInputToInt; i++) {
      if (pow(i, 2) == userInputToInt) {
        square++;
        break;
      }
    }
    for (int i = 1; i <= userInputToInt; i++) {
      if (pow(i, 3) == userInputToInt) {
        triangular++;
        break;
      }
    }

    if (square == 1 && triangular == 1) {
      setState(() {
        messageToUser = 'Number $userInputToInt is both SQUARE and TRIANGULAR.';
      });
    }
    else if (square == 0 && triangular == 0) {
      setState(() {
        messageToUser = 'Number $userInputToInt is neither TRIANGULAR or SQUARE.';
      });
    }
    else if (square == 1) {
      setState(() {
        messageToUser = 'Number $userInputToInt is SQUARE.';
      });
    }
    else if (triangular == 1) {
      setState(() {
        messageToUser = 'Number $userInputToInt is TRIANGULAR.';
      });
    }

    numberEntered.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
          title: Text('Number Shapes'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Please input a number to see if it is square or triungular.',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: numberEntered,
                    ),
                  ),
                ],
              ),
              FloatingActionButton(
                  child: const Icon(
                    Icons.check,
                  ),
                  onPressed: () {
                    testShape();
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text(userInput),
                            content: Text(messageToUser),
                          );
                        }
                    );
                  })
            ],
          ),
        )
    );
  }
}
