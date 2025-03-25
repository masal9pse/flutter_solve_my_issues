// todo
// 単一のwidgetにアニメーションを当てる
// TransitionAnimationを使って実装する

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
  late Animation<Alignment> alignAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    alignTween = Tween(begin: Alignment.topCenter, end: Alignment.bottomCenter);
    alignAnimation = controller.drive(alignTween);
    // CurvedAnimation(parent: controller, curve: Interval(0, 0.5))
    //     .drive(alignTween);
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
        // 内部でAnimatedBuilder
        child: AlignTransition(
          alignment: alignAnimation,
          child: Text('abced'),
        ),
        // child: AnimatedBuilder(
        //   animation: controller,
        //   builder: (context, _) {
        //     return Opacity(
        //       opacity: opacityAnimation.value,
        //       child: Align(
        //         alignment: alignAnimation.value,
        //         child: Transform.rotate(
        //           angle: rotateAnimation.value,
        //           child: Text('changed text'),
        //         ),
        //       ),
        //     );
        //   },
        // ),
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
