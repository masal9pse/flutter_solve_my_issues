import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyWidget());
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var _alignments = [
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.bottomRight,
    Alignment.bottomLeft,
  ];
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: AnimatedAlign(
        alignment: _alignments[value],
        duration: const Duration(microseconds: 2000),
        child: Text('aaaaa'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            value = Random().nextInt(_alignments.length);
          });
        },
        child: Text('change'),
      ),
    );
  }
}
