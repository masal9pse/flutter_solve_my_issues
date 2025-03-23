// ref: https://zenn.dev/flutteruniv_dev/articles/8752d61f522f50?redirected=1
// use case
// 回転をさせながらAlignmentも変える
// design
// １つのAnimationControllerから複数のアニメーションを生成し、単体のWidgetに充てればよい

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
  late Animation<Alignment> alignmentAnimation; // <<< １つ目のアニメーション
  late Animation<double> rotateAnimation; // <<< ２つ目のアニメーション

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    alignmentAnimation = controller
        .drive(Tween(begin: Alignment.centerLeft, end: Alignment.centerRight));
    rotateAnimation = controller.drive(Tween(begin: 0, end: 8 * pi));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: ElevatedButton(onPressed: () {
        controller.animateBack(0.4);
      }, child: Text('half pos')),),
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Align(
              alignment: alignmentAnimation.value,
              child: Transform.rotate(
                angle: rotateAnimation.value,
                child: Text('changed text'),
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
