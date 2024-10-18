import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PaintAndAnimatePage extends StatefulWidget {
  const PaintAndAnimatePage({super.key});

  @override
  _PaintAndAnimatePageState createState() => _PaintAndAnimatePageState();
}

class _PaintAndAnimatePageState extends State<PaintAndAnimatePage>
    with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();

  List<String> alphabet = List.generate(26, (index) => String.fromCharCode(index + 65)); // A-Z
  int currentIndex = 0;
  String currentLetter = 'A';

  List<Offset> points = []; // For drawing

  late AnimationController _controller;
  late Animation<double> _animation;
  bool isDrawingMode = true; // Toggle between drawing and animation mode

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("en-US");

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat(reverse: false);
  }

  void speakCurrentLetter() async {
    await flutterTts.setSpeechRate(0.5); // Slow down speech rate
    await flutterTts.setPitch(1.0); // Normal pitch
    await flutterTts.speak(currentLetter);
  }

  void nextLetter() {
    setState(() {
      currentIndex = (currentIndex + 1) % alphabet.length;
      currentLetter = alphabet[currentIndex];
      points.clear(); // Clear drawing when switching letters
      _controller.reset();
      _controller.forward();
    });
  }

  void toggleMode() {
    setState(() {
      isDrawingMode = !isDrawingMode; // Switch between modes
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice A-Z'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: isDrawingMode
                ? GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        points.add(details.localPosition);
                      });
                    },
                    onPanEnd: (details) {
                      setState(() {
                        points.add(Offset.infinite);
                      });
                    },
                    child: CustomPaint(
                      painter: MyPainter(points, currentLetter),
                      size: Size(300, 300),
                    ),
                  )
                : AnimatedLetter(letter: currentLetter, progress: _animation.value),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: speakCurrentLetter,
            icon: Icon(Icons.volume_up),
            label: Text('Listen to the Letter'),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: toggleMode,
                child: Text(isDrawingMode ? 'Switch to Animation' : 'Switch to Drawing'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: nextLetter,
                child: Text('Next Letter'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom painter for drawing the letter
class MyPainter extends CustomPainter {
  final List<Offset> points;
  final String letter;
  MyPainter(this.points, this.letter);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
        }

    // Drawing an outline letter (e.g., A) on the screen as a guideline
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: letter,
        style: TextStyle(color: Colors.grey.withOpacity(0.3), fontSize: 150),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width / 2 - 50, size.height / 4));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Animated letter tracing widget
class AnimatedLetter extends StatelessWidget {
  final String letter;
  final double progress;

  const AnimatedLetter({super.key, required this.letter, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          letter,
          style: TextStyle(
            fontSize: 200,
            fontWeight: FontWeight.bold,
            color: Colors.grey[300],
          ),
        ),
        ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: progress,
            child: Text(
              letter,
              style: TextStyle(
                fontSize: 200,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}