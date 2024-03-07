import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  Color _scaffoldBackgroundColor = Colors.blue; // Initial background color

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = ColorTween(
      begin: _scaffoldBackgroundColor,
      end: Colors.greenAccent, // End color (you can change it)
    ).animate(_controller);
  }

  void _changeColor() {
    setState(() {
      // Change the scaffold background color to a random color
      _scaffoldBackgroundColor = Colors.greenAccent;
    });

    _controller.forward(from: 0.0);
  }

  // Color _generateRandomColor() {
  //   // Generate a random color
  //   return Color.fromRGBO(
  //     (0..255).toList()[_getRandomIndex()],
  //     (0..255).toList()[_getRandomIndex()],
  //     (0..255).toList()[_getRandomIndex()],
  //     1.0,
  //   );
  // }

  // int _getRandomIndex() {
  //   // Generate a random index within the valid color range
  //   return (0..255).toList().indexOf((0..255).toList().shuffle().first);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scaffold Color Change Animation'),
      ),
      body: Center(
        child: Text(
          'Tap to Change Scaffold Background Color',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: _animation.value,
      floatingActionButton: FloatingActionButton(
        onPressed: _changeColor,
        tooltip: 'Change Color',
        child: Icon(Icons.color_lens),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
