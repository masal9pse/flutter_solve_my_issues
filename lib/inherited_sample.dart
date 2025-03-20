import 'package:flutter/material.dart';

void main() {
  runApp(TopPage());
}

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Demo'),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          WidgetA(_counter),
          WidgetB(),
          WidgetC(_incrementCounter),
        ],
      ),
    );
  }
}

class WidgetA extends StatelessWidget {
  final int counter;

  WidgetA(this.counter);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${counter}',
        // style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}

class WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('I am a widget that will not be rebuilt.');
  }
}

class WidgetC extends StatelessWidget {
  final void Function() incrementCounter;

  WidgetC(this.incrementCounter);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        incrementCounter();
      },
      child: Icon(Icons.add),
    );
  }
}
