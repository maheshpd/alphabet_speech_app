import 'dart:math';

import 'package:alphabet_speech_app/hindi_alphabet_home.dart';
import 'package:alphabet_speech_app/multiplication.dart';
import 'package:alphabet_speech_app/number_learning.dart';
import 'package:alphabet_speech_app/paint_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alphabet Speech App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const PaintAndAnimatePage(),
    );
  }
}

class AlphabetHomePage extends StatefulWidget {
  @override
  _AlphabetHomePageState createState() => _AlphabetHomePageState();
}

class _AlphabetHomePageState extends State<AlphabetHomePage> {
  FlutterTts flutterTts = FlutterTts();
  List<String> alphabet = List.generate(26, (index) => String.fromCharCode(65 + index)); // A-Z
  int currentIndex = 0;
  bool isShuffled = false;

  @override
  void initState() {
    super.initState();
    // Set default speech language
    flutterTts.setLanguage("en-US");
  }

  // Function to play the current alphabet sound using Text-to-Speech
  Future<void> speakCurrentLetter() async {
    String letter = alphabet[currentIndex];
    await flutterTts.speak(letter);
  }

  // Function to shuffle alphabet
  void shuffleAlphabet() {
    setState(() {
      alphabet.shuffle(Random());
      currentIndex = 0;
      isShuffled = true;
    });
  }

  // Function to reset alphabet to A-Z order
  void resetAlphabet() {
    setState(() {
      alphabet = List.generate(26, (index) => String.fromCharCode(65 + index)); // A-Z
      currentIndex = 0;
      isShuffled = false;
    });
  }

  // Function to go to the next letter
  void nextLetter() {
    setState(() {
      if (currentIndex < alphabet.length - 1) {
        currentIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentLetter = alphabet[currentIndex]; // Current letter

    return Scaffold(
      appBar: AppBar(
        title: Text('Alphabet Speech App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display the current letter
          Center(
            child: Text(
              currentLetter,
              style: TextStyle(fontSize: 120, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 40),

          // Play button for text-to-speech
          ElevatedButton.icon(
            onPressed: speakCurrentLetter,
            icon: Icon(Icons.volume_up),
            label: Text('Listen to the Letter'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              textStyle: TextStyle(fontSize: 20),
            ),
          ),

          SizedBox(height: 20),

          // Next, Shuffle, and Reset buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: nextLetter,
                child: Text('Next Letter'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: shuffleAlphabet,
                child: Text('Shuffle'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: resetAlphabet,
                child: Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}