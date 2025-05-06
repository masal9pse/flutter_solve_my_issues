import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inherited Widget Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _CounterPage(),
    );
  }
}

class _InheritedCounter extends InheritedWidget {
  const _InheritedCounter(
      {Key? key,
        required Widget child,
        required this.count
      }): super(key: key, child: child);

  final int count;

  @override
  bool updateShouldNotify(_InheritedCounter old) => true;

  static _InheritedCounter? of(BuildContext context, {required bool listen}) {
    return listen
        ? context.dependOnInheritedWidgetOfExactType<_InheritedCounter>()
        : context.getElementForInheritedWidgetOfExactType<_InheritedCounter>()?.widget as _InheritedCounter;
  }
}

class _CounterPage extends StatefulWidget {
  const _CounterPage({Key? key}): super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}


class _CounterPageState extends State<_CounterPage> {
  var _count = 0;

  @override
  Widget build(BuildContext context) {
    print('Built CounterPageState');

    return
      _InheritedCounter(
        count: _count,
        child: Scaffold(
            appBar: AppBar(title: const Text('Inherited Widget Sample')),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: _increment,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                WidgetA(),
                WidgetB()
              ],
            )),
      );
  }

  void _increment() {
    setState(() {
      _count++;
    });
  }
}

class WidgetA extends StatelessWidget {
  const WidgetA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Built WidgetA');

    return Center(
        child: Text(
            'Counter: ${_InheritedCounter.of(context, listen: true)?.count}',
            style: const TextStyle(
                fontSize: 20
            )
        )
    );
  }
}

class WidgetB extends StatelessWidget {
  const WidgetB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Built WidgetB');

    return Center(
        child: Text(
            'Counter: ${_InheritedCounter.of(context, listen: false)?.count}',
            style: const TextStyle(
                fontSize: 20
            )
        )
    );
  }
}