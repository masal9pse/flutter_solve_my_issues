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
  // late Tween<Alignment> alignmentTween;
  late Animatable<Alignment> alignmentTween;
  late Animatable<double> countTween;
  late Animation<Alignment> animation;
  late Animation<double> countAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    alignmentTween =
        Tween(begin: Alignment.topCenter, end: Alignment.center).chain(
      CurveTween(
        curve: Curves.bounceIn,
      ),
    );
    countTween = Tween(begin: 0.0, end: 100.0).chain(
      CurveTween(
        curve: Curves.bounceIn,
      ),
    );
    animation = CurvedAnimation(parent: controller, curve: Interval(0, 0.5))
        .drive(alignmentTween);
    countAnimation =
        CurvedAnimation(parent: controller, curve: Interval(0.5, 1.0))
            .drive(countTween);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => controller.animateBack(0),
        ),
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
