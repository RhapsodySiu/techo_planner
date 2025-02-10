import 'package:flutter/material.dart';

class DrawingBoard extends StatefulWidget {
  const DrawingBoard({super.key});

  @override
  _DrawingBoardState createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  List<Offset?> points = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          points.add(renderBox.globalToLocal(details.globalPosition));
        });
      },
      onPanEnd: (details) => points.add(null),
      child: Stack(children: [
        ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Image.asset("assets/planner.png", fit: BoxFit.cover),
        ),
         CustomPaint(
        painter: MyPainter(points),
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
        ),
      ),
      ],)
    );
  }
}


class MyPainter extends CustomPainter {
  final List<Offset?> points;

  MyPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}