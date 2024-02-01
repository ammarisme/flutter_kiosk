import 'dart:math';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> with TickerProviderStateMixin {
  late AnimationController _animationController;
  double _rotation = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      // Use a CurvedAnimation to create a spinning effect
      animationBehavior: AnimationBehavior.normal,

    );

    _animationController.addListener(() {
      setState(() {
        _rotation = _animationController.value * 2 * pi;
      });
    });
  }
Future<void> runAnimations() async {

  for (int i = 0; i < 5; i++) {
        print(i);

    await _spinWheel();
  }

  double luck_round = Random().nextDouble();
  await luckySpin(luck_round);

  gameVM.attempt_count++;
}

Future<void> _spinWheel() async {  
  _animationController.reset();

  await _animationController.animateTo(
    1,
    duration: Duration(seconds: 1),
    curve: Curves.linear,
  );

  _animationController.stop();
}

Future<void> luckySpin(luck_round) async {  
  _animationController.reset();

  await _animationController.animateTo(
    luck_round,
    duration: Duration(seconds: 1),
    curve: Curves.linear,
  );

  _animationController.stop();
}


// Call runAnimations to start the loop





  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  GameVM gameVM = GameVM();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Attempts ${gameVM.attempt_count}/${gameVM.max_attempts}", style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height:50),
        Container(
          height: 40, // Adjust the height of the arrow
          child: Icon(
            Icons.arrow_downward,
            size: 40,
            color: Colors.black, // Adjust the color of the arrow
          ),
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotation,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Stack(
                  children: List.generate(
                    10,
                    (index) {
                      double angle = 2 * pi / 10 * index;
                      double sweepAngle = 2 * pi / 10;

                      return Positioned.fill(
                        child: CustomPaint(
                          painter: SegmentPainter(angle, sweepAngle, index),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: !gameVM.gameOver() ? runAnimations : null,
          child: Text("Spin the Wheel"),
        ),        SizedBox(height: 20),

        !gameVM.isLoggedIn() && !gameVM.gameOver()? Text("(Sign-in/Register to start playing)") : Container(),
        gameVM.gameOver()? Text("You've used up your attempts. Try again another day.") : Container()
      ],
    );
  }
}

class SegmentPainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;
  final int index;

  SegmentPainter(this.startAngle, this.sweepAngle, this.index);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;

    // Generate a random color for each segment
    final Paint paint = Paint()..color = getColor(index);

   
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);

   
    // Display random text closer to the perimeter of the circle
    final double radius = size.width / 2;
    final double centerX = size.width / 2 + radius * 0.8 * cos(startAngle + sweepAngle / 2);
    final double centerY = size.height / 2 + radius * 0.8 * sin(startAngle + sweepAngle / 2);

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: getText(index),
        style: TextStyle(
          color: Colors.white, // Adjust the color of the text
          fontSize: 12, // Adjust the font size
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(centerX - textPainter.width / 2, centerY - textPainter.height / 2));

    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  Color getColor(index) {
    final List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.grey, Colors.black, Colors.purple,Colors.teal, Colors.indigo, Colors.orange, Colors.pink];
    final Random random = Random();
    return colors[index];
  }

  String getText(index) {
    final List<String> text = ["20%", "", "10%", "", "5%", "", "", "BOGO", "", ""];
    final Random random = Random();
    return text[index];
  }
}

class GameVM{
  int attempt_count=0;
  int max_attempts = 3;
  
  gameOver() {
    return !(attempt_count<max_attempts);
  }

  isLoggedIn(){
    return false;
  }
}