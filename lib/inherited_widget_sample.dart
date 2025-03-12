import 'package:flutter/material.dart';
// import 'package:flutter_engineer_codecheck/sheet_sample.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Page1(),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  void increment() {
    setState(() {
      _count++;
    });
  }

  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return InheritedCount(
      count: _count,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => increment(),
          child: Icon(Icons.plus_one),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetA(),
            WidgetB(),
          ],
        ),
      ),
    );
  }
}

class InheritedCount extends InheritedWidget {
  const InheritedCount({super.key, required super.child, required this.count});
  final int count;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static InheritedCount? of(BuildContext context, {required bool listen}) {
    return listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedCount>()
        : context.getElementForInheritedWidgetOfExactType<InheritedCount>()!.widget as InheritedCount;
  }
}

class WidgetA extends StatelessWidget {
  const WidgetA({super.key});

  @override
  Widget build(BuildContext context) {
    /// MediaQueryと一緒やな
    return Text('Widget A ${InheritedCount.of(context, listen: true)!.count}');
  }
}

class WidgetB extends StatelessWidget {
  const WidgetB({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Widget B ${InheritedCount.of(context, listen: false)!.count}');
  }
}
