import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SamplePage(),
    );
  }
}

class SamplePage extends StatefulWidget {
  const SamplePage({super.key});

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Tween<Alignment> tween;
  late Animation<Alignment> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    tween = Tween(begin: Alignment.topLeft, end: Alignment.topRight);
    // tween = Tween(begin: Alignment.topLeft, end: Alignment(, y));
    animation = controller.drive(tween);
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: CustomAnimatedWidget(
          listenable: animation,
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          // MaterialPageRoute
          controller.forward();
        },
        child: Text('exec animation'),
      ),
    );
  }
}

class CustomAnimatedWidget extends AnimatedWidget {
  const CustomAnimatedWidget({super.key, required super.listenable});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: (listenable as Animation<Alignment>).value,
      child: Text('abc'),
    );
  }
}
