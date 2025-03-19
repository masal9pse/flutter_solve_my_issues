import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InheritedWidget Example',
      home: Scaffold(
        appBar: AppBar(title: Text('InheritedWidget Example')),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyModel extends InheritedWidget {
  final int counter;
  final String message;

  const MyModel({
    Key? key,
    required Widget child,
    required this.counter,
    required this.message,
  }) : super(key: key, child: child);

  static MyModel? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyModel>();
  }

  @override
  bool updateShouldNotify(MyModel oldWidget) {
    return counter != oldWidget.counter || message != oldWidget.message;
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int counter = 0;
  String message = "Hello";

  void increment() {
    setState(() {
      counter++;
    });
  }

  void updateMessage() {
    setState(() {
      message = "Updated Message!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyModel(
      counter: counter,
      message: message,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CounterDisplay(),
          MessageDisplay(),
          ElevatedButton(onPressed: increment, child: Text("Increment Counter")),
          ElevatedButton(onPressed: updateMessage, child: Text("Update Message"))
        ],
      ),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = MyModel.of(context);
    return Text('Counter: ${model?.counter}');
  }
}

class MessageDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = MyModel.of(context);
    return Text('Message: ${model?.message}');
  }
}
