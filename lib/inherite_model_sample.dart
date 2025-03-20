import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InheritedModel Example',
      home: Scaffold(
        appBar: AppBar(title: Text('InheritedModel Example')),
        body: MyStatefulWidget(),
      ),
    );
  }
}

// InheritedModelを利用した状態管理
class MyModel extends InheritedModel<String> {
  final int counter;
  final String message;

  const MyModel({
    Key? key,
    required Widget child,
    required this.counter,
    required this.message,
  }) : super(key: key, child: child);

  static MyModel? of(BuildContext context, String aspect) {
    // MediaQuery
    return InheritedModel.inheritFrom<MyModel>(context, aspect: aspect);
  }

  // ✅ `updateShouldNotify` を追加
  @override
  bool updateShouldNotify(MyModel oldWidget) {
    return counter != oldWidget.counter || message != oldWidget.message;
  }

  @override
  bool updateShouldNotifyDependent(
      MyModel oldWidget, Set<String> dependencies) {
    if (dependencies.contains('counter') && counter != oldWidget.counter) {
      return true;
    }
    if (dependencies.contains('message') && message != oldWidget.message) {
      return true;
    }
    return false;
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
          ElevatedButton(
              onPressed: increment, child: Text("Increment Counter123")),
          ElevatedButton(
              onPressed: updateMessage, child: Text("Update Message"))
        ],
      ),
    );
  }
}

// カウンターの値のみを監視
class CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("CounterDisplay rebuilt");  // デバッグ用
    final model = MyModel.of(context, 'counter'); // 'counter' の変更のみ監視
    return Text('Counter: ${model?.counter}');
  }
}

// メッセージの値のみを監視
class MessageDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MessageDisplay rebuilt");  // デバッグ用
    final model = MyModel.of(context, 'message'); // 'message' の変更のみ監視
    return Text('Message: ${model?.message}');
  }
}
