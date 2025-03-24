import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Alignment> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    animation = controller
        .drive(Tween(begin: Alignment.topCenter, end: Alignment.center));
    // TODO: curve boundInの追加
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedBuilder(animation: controller, builder: (context, _) {
        return Align(
          alignment: animation.value,
          child: Text('abcdefg'),
        );
      }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        controller.forward();
      },
      child: Text('change'),),
    );
  }
}
