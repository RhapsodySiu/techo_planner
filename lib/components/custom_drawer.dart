import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onToggle;

  const CustomDrawer({Key? key, required this.isOpen, required this.onToggle}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onToggle,
      child: AnimatedPositioned(
        duration: Duration(milliseconds: 300),
        left: widget.isOpen ? 0 : -300, // Adjust width as needed
        top: 0,
        bottom: 0,
        child: Container(
          width: 300,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Draggable<String>(
                        data: 'icon1',
                        feedback: Icon(Icons.star, size: 50),
                        child: Icon(Icons.star, size: 50),
                      ),
                      SizedBox(width: 20),
                      Draggable<String>(
                        data: 'icon2',
                        feedback: Icon(Icons.favorite, size: 50),
                        child: Icon(Icons.favorite, size: 50),
                      ),
                      SizedBox(width: 20),
                      Draggable<String>(
                        data: 'icon3',
                        feedback: Icon(Icons.home, size: 50),
                        child: Icon(Icons.home, size: 50),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
