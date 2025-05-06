import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AnimationControllerScope(
        child: HomePage(),
      ),
    ),
  );
}

/// 1. InheritedWidget
class AnimationControllerProvider extends InheritedWidget {
  final AnimationController controller;

  const AnimationControllerProvider({
    required this.controller,
    required super.child,
    super.key,
  });

  static AnimationController of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<AnimationControllerProvider>();
    // final provider = context.getElementForInheritedWidgetOfExactType<AnimationControllerProvider>();
    assert(provider != null, 'No AnimationControllerProvider found in context');
    return provider!.controller;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

/// 2. Controllerを作る StatefulWidget
class AnimationControllerScope extends StatefulWidget {
  final Widget child;

  const AnimationControllerScope({super.key, required this.child});

  @override
  State<AnimationControllerScope> createState() => _AnimationControllerScopeState();
}

class _AnimationControllerScopeState extends State<AnimationControllerScope>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationControllerProvider(
      controller: _controller,
      child: widget.child,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


/// 3. SlideTransition を使ったホーム画面
class _HomePageState extends State<HomePage> {
  late Animation<Offset> animation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = AnimationControllerProvider.of(context);
    animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    final controller = AnimationControllerProvider.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('SlideTransition Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: animation,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                if (controller.status == AnimationStatus.completed) {
                  controller.reverse();
                } else {
                  controller.forward();
                }
              },
              child: const Text('Slide!'),
            ),
          ],
        ),
      ),
    );
  }
}
