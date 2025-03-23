// todo
// 単一のwidgetに異なるアニメーションを複数回充てる

import 'dart:math';

import 'package:flutter/material.dart';

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
  late Tween<Alignment> alignTween;
  late Tween<double> rotateTween;
  late Tween<double> opacityTween;
  late Animation<Alignment> alignAnimation;
  late Animation<double> rotateAnimation;
  late Animation<double> opacityAnimation;
  bool animateCompleted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    alignTween = Tween(begin: Alignment.topCenter, end: Alignment.bottomCenter);
    rotateTween = Tween(begin: 0, end: 3.141592);
    opacityTween = Tween(begin: 1, end: 0);
    alignAnimation =
        CurvedAnimation(parent: controller, curve: Interval(0, 0.5))
            .drive(alignTween);
    // alignAnimation = controller.drive(alignTween);

    rotateAnimation =
        CurvedAnimation(parent: controller, curve: Interval(0.5, 0.7))
            .drive(rotateTween);
    // rotateAnimation = controller.drive(rotateTween);

    opacityAnimation =
        CurvedAnimation(parent: controller, curve: Interval(0.7, 1))
            .drive(opacityTween);
    // opacityAnimation = controller.drive(opacityTween);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
            onPressed: () {
              // controller.animateBack(0.4);
              controller.animateBack(0);
            },
            child: Text('half pos')),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Opacity(
              opacity: opacityAnimation.value,
              child: Align(
                alignment: alignAnimation.value,
                child: Transform.rotate(
                  angle: rotateAnimation.value,
                  child: Text('changed text'),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.forward();
          // controller.animateBack(0.4);
        },
        child: Text('aaa'),
      ),
    );
  }
}
