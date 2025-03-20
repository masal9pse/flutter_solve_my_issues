import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/main.dart';

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
        body: MyStatefulWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CounterDisplay(),
              MessageDisplay(),
              CounterButton(),
              // ElevatedButton(onPressed: widget., child: Text("Increment Counter")),
              // ElevatedButton(
              //     onPressed: updateMessage, child: Text("Update Message"))
            ],
          ),
        ),
      ),
    );
  }
}

class MyModel extends InheritedWidget {
  final int counter;
  final String message;
  final _MyStatefulWidgetState data;

  const MyModel({
    super.key,
    required super.child,
    required this.counter,
    required this.message,
    required this.data,
  });

  static MyModel? of(BuildContext context,{bool rebuild = true}) {
    if (rebuild) {
      return context.getElementForInheritedWidgetOfExactType<MyModel>()!.widget as MyModel;
    // return context.dependOnInheritedWidgetOfExactType<MyModel>();
    }
    return context.getElementForInheritedWidgetOfExactType<MyModel>() as MyModel;
    // return context.dependOnInheritedWidgetOfExactType<InheritedWidget>();
  }

  @override
  bool updateShouldNotify(MyModel oldWidget) {
    return counter != oldWidget.counter || message != oldWidget.message;
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key, required this.child});

  final Widget child;

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
      data: this,
      child: widget.child,
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     CounterDisplay(),
      //     MessageDisplay(),
      //     CounterButton(),
      //     // ElevatedButton(onPressed: widget., child: Text("Increment Counter")),
      //     ElevatedButton(
      //         onPressed: updateMessage, child: Text("Update Message"))
      //   ],
      // ),
    );
  }
}

class CounterButton extends StatelessWidget {
  const CounterButton({super.key});

  @override
  Widget build(BuildContext context) {
    // MyStatefulWidgetではなく、_MyStatefulWidgetStateを取得できるようにしたい！！
    final state = MyModel.of(context)!.data;
    return ElevatedButton(
        onPressed: () {
          state.increment();
        },
        child: Text('Increment Counter'));
  }
}

class CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final c = MediaQuery;
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
