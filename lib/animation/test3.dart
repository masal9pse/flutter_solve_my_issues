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
      home: _CounterPage(),
    );
  }
}

class _InheritedCounter extends InheritedWidget {
  _InheritedCounter(
      {Key? key,
      required Widget child,
      required this.count,
      required this.controller})
      : super(key: key, child: child);

  final int count;
  AnimationController controller;

  @override
  bool updateShouldNotify(_InheritedCounter old) => true;

  static _InheritedCounter? of(BuildContext context, {required bool listen}) {
    return listen
        ? context.dependOnInheritedWidgetOfExactType<_InheritedCounter>()
        : context
            .getElementForInheritedWidgetOfExactType<_InheritedCounter>()
            ?.widget as _InheritedCounter;
  }
}


class _CounterPage extends StatelessWidget {
  _CounterPage({Key? key}) : super(key: key);





  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    print('Built CounterPage');

    return _InheritedCounter(
      count: 0, // Default count value since it's no longer stateful
      controller: controller,
      child: Scaffold(
        appBar: AppBar(title: const Text('Inherited Widget Sample')),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            // Logic to increment count should be handled elsewhere
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [WidgetA(), WidgetB()],
        ),
      ),
    );
  }
}

class WidgetA extends StatefulWidget {
  const WidgetA({Key? key}) : super(key: key);

  @override
  State<WidgetA> createState() => _WidgetAState();
}

class _WidgetAState extends State<WidgetA> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _InheritedCounter.of(context, listen: false)?.controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    print('Built WidgetA');

    return Center(
      child: Column(
        children: [
          Text(
            'Counter: ${_InheritedCounter.of(context, listen: true)?.count}',
            style: const TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () {
              _InheritedCounter.of(context, listen: false)
                  ?.controller
                  .forward();
            },
            child: const Text('Forward'),
          ),
        ],
      ),
    );
  }
}

class WidgetB extends StatefulWidget {
  const WidgetB({Key? key}) : super(key: key);

  @override
  State<WidgetB> createState() => _WidgetBState();
}

class _WidgetBState extends State<WidgetB> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Built WidgetB');

    return Center(
      child: Column(
        children: [
          Text(
            'Counter: ${_InheritedCounter.of(context, listen: false)?.count}',
            style: const TextStyle(fontSize: 20),
          ),
          SlideTransition(
            position: _animation,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     if (_controller.status == AnimationStatus.completed) {
          //       _controller.reverse();
          //     } else {
          //       _controller.forward();
          //     }
          //   },
          //   child: const Text('Animate'),
          // ),
        ],
      ),
    );
  }
}

