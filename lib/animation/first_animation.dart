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
  late Animation<double> countAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    animation = controller.drive(
      Tween(begin: Alignment.topCenter, end: Alignment.center).chain(
        CurveTween(
          curve: Curves.bounceIn,
        ),
      ),
    );
    countAnimation = controller.drive(
      Tween(begin: 0.0, end: 100.0).chain(
        CurveTween(
          curve: Curves.bounceIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => controller.animateBack(0),),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return Align(
            alignment: animation.value,
            child: Text('数字は${countAnimation.value}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.isCompleted) {
            controller.animateBack(0);
            return;
          }
          controller.forward();
        },
        child: Text('change'),
      ),
    );
  }
}
