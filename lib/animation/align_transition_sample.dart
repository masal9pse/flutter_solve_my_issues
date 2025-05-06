import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SizeTransitionExample(),
    );
  }
}

class SizeTransitionExample extends StatefulWidget {
  const SizeTransitionExample({super.key});

  @override
  State<SizeTransitionExample> createState() => _SizeTransitionExampleState();
}

class _SizeTransitionExampleState extends State<SizeTransitionExample> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
      value: 0.5, // 初期値を0.5に設定
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void _expand() {
    _controller.animateTo(1.0); // 完全に表示
  }

  void _collapse() {
    _controller.animateTo(0.0); // 完全に非表示
  }

  void _half() {
    _controller.animateTo(0.5); // 半分のサイズに戻す
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SizeTransition 初期値0.5')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizeTransition(
              sizeFactor: _animation,
              axis: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.blueAccent,
                child: const Text(
                  'Hello SizeTransition!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(onPressed: _expand, child: const Text('Expand')),
                ElevatedButton(onPressed: _half, child: const Text('Half')),
                ElevatedButton(onPressed: _collapse, child: const Text('Collapse')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
