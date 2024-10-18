import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NumberHomePage extends StatefulWidget {
  const NumberHomePage({super.key});

  @override
  _NumberHomePageState createState() => _NumberHomePageState();
}

class _NumberHomePageState extends State<NumberHomePage> {
  FlutterTts flutterTts = FlutterTts();
  
  // List of numbers from 1 to 100
  List<String> numbers = List.generate(100, (index) => (index + 1).toString());

  int currentIndex = 0;
  bool isShuffled = false;

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("en-US"); // Set language to English
  }

  // Function to play the current number sound using Text-to-Speech
  Future<void> speakCurrentNumber() async {
    String number = numbers[currentIndex];

    // Set the speech rate to a normal speed (1.0 is normal)
    await flutterTts.setSpeechRate(0.5); // Adjust this to your preferred speed
    await flutterTts.setPitch(1.0); // Normal pitch
    await flutterTts.setVolume(1.0); // Normal volume

    // Speak the current number
    await flutterTts.speak(number);
  }

  void shuffleNumbers() {
    setState(() {
      numbers.shuffle(Random());
      currentIndex = 0;
      isShuffled = true;
    });
  }

  void resetNumbers() {
    setState(() {
      numbers = List.generate(100, (index) => (index + 1).toString()); // Reset to 1-100
      currentIndex = 0;
      isShuffled = false;
    });
  }

  void nextNumber() {
    setState(() {
      if (currentIndex < numbers.length - 1) {
        currentIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentNumber = numbers[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Speech App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              currentNumber,
              style: const TextStyle(fontSize: 120, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 40),

          ElevatedButton.icon(
            onPressed: speakCurrentNumber,
            icon: const Icon(Icons.volume_up),
            label: const Text('Listen to the Number'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: nextNumber,
                child: const Text('Next Number'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: shuffleNumbers,
                child: const Text('Shuffle'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: resetNumbers,
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}