import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterPage(),
    );
  }
}

class Counter {
  int _counter = 0;
  final StreamController<int> _controller = StreamController<int>();
  Stream<int> get stream => _controller.stream;

  void increment() {
    _counter++;
    _controller.add(_counter);
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late final StreamSubscription<String> _subscription;
  String _currentWord = 'Hello';
  int count = 0;
  final counter = Counter();

  @override
  void initState() {
    super.initState();
    _startTimer();
    counter.stream.listen((data) {
      setState(() {
        count = data;
      });
    });
  }

  Stream<String> getTechWord() async* {
    yield 'hello';
    await Future.delayed(const Duration(seconds: 1));
    yield 'world';
    await Future.delayed(const Duration(seconds: 1));
    yield 'flutter';
    await Future.delayed(const Duration(seconds: 1));
    yield 'stream';
    await Future.delayed(const Duration(seconds: 1));    
    // throw Exception('error'); 
  }

  void _startTimer() {
    _subscription = getTechWord().listen(
      (word) {
        setState(() {
          _currentWord = word;
        });
      },
      onError: (err) {
        print('error');
      },
      onDone: () {
        print('done');
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel(); // 必ずキャンセルしてリソース解放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Example'),
        actions: [
          IconButton(
            onPressed: () => _subscription.pause(),
            icon: Icon(Icons.pause),
            tooltip: 'Pause Stream',
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              _currentWord,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          Text('$count'),
          ElevatedButton.icon(onPressed: counter.increment, label: Icon(Icons.plus_one))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _subscription.resume(),
        child: Icon(Icons.play_arrow),
        tooltip: 'Resume Stream',
      ),
    );
  }
}
