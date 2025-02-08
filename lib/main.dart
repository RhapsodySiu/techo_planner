import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Techo Planner',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PlaygroundScreen(),
    );
  }
}

class PlaygroundScreen extends StatefulWidget {
  const PlaygroundScreen({super.key});

  @override
  _PlaygroundScreenState createState() => _PlaygroundScreenState();
}

class _PlaygroundScreenState extends State<PlaygroundScreen> {
  List<Sticker> stickers = [];

  void _addSticker(String data, Offset position) {
    setState(() {
      stickers.add(Sticker(data: data, position: position));
    });
  }

  final GlobalKey stackKey = GlobalKey(); // Create a GlobalKey for the Stack

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Canvas'),
        ),
        body: Row(
          children: [
            Container(
              width: 100,
              color: Colors.grey[300],
              child: Column(
                children: [
                  Draggable<String>(
                    data: 'ph1',
                    feedback: SizedBox.fromSize(
                      child: Image.asset('assets/ph1.png'),
                      size: Size.square(100.0),
                    ),
                    child: Image.asset('assets/ph1.png'),
                  ),
                  Draggable<String>(
                    data: 'ph2',
                    feedback: SizedBox.fromSize(
                      child: Image.asset('assets/ph2.png'),
                      size: Size.square(100.0),
                    ),
                    child: Image.asset('assets/ph2.png'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        stickers.clear();
                      });
                    },
                    child: Text('Clear Stickers'),
                  ),
                ],
              ),
            ),
            Expanded(
                child: DragTarget<String>(
              onAcceptWithDetails: (details) {
                print('Dropped: ${details.offset}');
                final canvasOffset = getStackOffset();
                final offset = details.offset;
                _addSticker(details.data, offset.translate(-canvasOffset.dx, -canvasOffset.dy));
              },
              builder: (context, candidateData, rejectedData) {

                return Container(
                    color: Colors.white,
                    child: Stack(
                      key: stackKey,
                      children: stickers.map((sticker) {
                        print('Draw sticker ${sticker.data}');
                        return Positioned(
                          top: sticker.position.dy,
                          left: sticker.position.dx,
                          child: Image.asset(
                            'assets/${sticker.data.toLowerCase()}.png',
                            width: 100.0,
                            height: 100.0,
                          ),
                        );
                      }).toList(),
                    ));
              },
            )),
          ],
        ));
  }

  Offset getStackOffset() {
  final RenderBox renderBox = stackKey.currentContext?.findRenderObject() as RenderBox;
  final Offset offset = renderBox.localToGlobal(Offset.zero);

  return offset;
}
}

class Sticker {
  final String data;
  final Offset position;

  Sticker({required this.data, required this.position});
}
