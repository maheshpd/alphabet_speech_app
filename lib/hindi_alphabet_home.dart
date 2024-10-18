import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HindiAlphabetHomePage extends StatefulWidget {
  const HindiAlphabetHomePage({super.key});

  @override
  _HindiAlphabetHomePageState createState() => _HindiAlphabetHomePageState();
}

class _HindiAlphabetHomePageState extends State<HindiAlphabetHomePage> {
  FlutterTts flutterTts = FlutterTts();
  // Hindi vowels and consonants in Devanagari script
  List<String> hindiCharacters = [
    'अ', 'आ', 'इ', 'ई', 'उ', 'ऊ', 'ऋ', 'ए', 'ऐ', 'ओ', 'औ', 'अं', 'अः', // Vowels
    'क', 'ख', 'ग', 'घ', 'च', 'छ', 'ज', 'झ', 'ट', 'ठ', 'ड', 'ढ', 'ण', // Consonants
    'त', 'थ', 'द', 'ध', 'न', 'प', 'फ', 'ब', 'भ', 'म', 'य', 'र', 'ल', 'व', 'श', 'ष', 'स', 'ह' // More consonants
  ];

  int currentIndex = 0;
  bool isShuffled = false;

  @override
  void initState() {
    super.initState();
    // Set default speech language to Hindi
    flutterTts.setLanguage("hi-IN");
  }

// Function to play the current Hindi character sound using Text-to-Speech with prolonged pronunciation
  Future<void> speakCurrentCharacter() async {
    String character = hindiCharacters[currentIndex];

    // Create a prolonged sound by repeating the character
    String prolongedCharacter = character * 2; // Repeat the character 8 times

    // Set the speech rate (you can keep this low, like 0.2, to ensure clarity)
    await flutterTts.setSpeechRate(0.2); // Slow down speech rate
    await flutterTts.setPitch(1.0); // Normal pitch
    await flutterTts.setVolume(1.0); // Normal volume

    // Speak the prolonged character
    await flutterTts.speak(prolongedCharacter);
  }

  // Function to shuffle Hindi characters
  void shuffleCharacters() {
    setState(() {
      hindiCharacters.shuffle(Random());
      currentIndex = 0;
      isShuffled = true;
    });
  }

  // Function to reset Hindi characters to original order
  void resetCharacters() {
    setState(() {
      hindiCharacters = [
        'अ', 'आ', 'इ', 'ई', 'उ', 'ऊ', 'ऋ', 'ए', 'ऐ', 'ओ', 'औ', 'अं', 'अः', // Vowels
        'क', 'ख', 'ग', 'घ', 'च', 'छ', 'ज', 'झ', 'ट', 'ठ', 'ड', 'ढ', 'ण', // Consonants
        'त', 'थ', 'द', 'ध', 'न', 'प', 'फ', 'ब', 'भ', 'म', 'य', 'र', 'ल', 'व', 'श', 'ष', 'स', 'ह' // More consonants
      ];
      currentIndex = 0;
      isShuffled = false;
    });
  }

  // Function to go to the next character
  void nextCharacter() {
    setState(() {
      if (currentIndex < hindiCharacters.length - 1) {
        currentIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentCharacter = hindiCharacters[currentIndex]; // Current character

    return Scaffold(
      appBar: AppBar(
        title: Text('Hindi Alphabet Speech App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display the current Hindi character
          Center(
            child: Text(
              currentCharacter,
              style: TextStyle(fontSize: 120, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 40),

          // Play button for text-to-speech
          ElevatedButton.icon(
            onPressed: speakCurrentCharacter,
            icon: Icon(Icons.volume_up),
            label: Text('Listen to the Character'),
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
                onPressed: nextCharacter,
                child: Text('Next Character'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: shuffleCharacters,
                child: Text('Shuffle'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: resetCharacters,
                child: Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}