import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sheet/route.dart';

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

  StreamController<String> getTechWordController() {
    final controller = StreamController<String>();
    final word = ['naruto', 'sasuke', 'rufi', 'masato'];
    Stream.periodic(Duration(seconds: 1), (time) {
      // controller.add(word[time % word.length]);
      return word[time % word.length];
    }).listen((event) {
      controller.add(event);
    });
    // Future(() async {
    //   controller.add('hello');
    //   await Future.delayed(const Duration(seconds: 1));
    //   controller.add('world');
    //   await Future.delayed(const Duration(seconds: 1));
    //   controller.add('flutter');
    //   await Future.delayed(const Duration(seconds: 1));
    //   controller.add('stream');
    // });
    return controller;
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
    _subscription = getTechWordController().stream.listen(
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
          // ElevatedButton.icon(
          //     onPressed: counter.increment, label: Icon(Icons.plus_one))
          ElevatedButton.icon(
              onPressed: () {
                // showCupertinoModalBottomSheet(
                //     context: context,
                //     expand: true,
                //     builder: (context) {
                //       return MyWidget();
                //     });
                // showShee
                Navigator.of(context).push(SheetRoute(
                  initialExtent: 0.8,
                  
                  builder: (context) {
                    return MyWidget();
                  },
                ));
                // SheetRoute(
                //   builder: (context) {
                //     return MyWidget();
                //   },
                //   initialExtent: 200
                // );
              },
              label: Icon(Icons.plus_one)),
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

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('masato'),
      ),
    );
  }
}
