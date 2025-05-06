import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyWidget(),);
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(vsync: this,duration: const Duration(microseconds: 300));
  late AnimationController controller2 = AnimationController(vsync: this,duration: const Duration(microseconds: 300));
  late Tween<double> tween = Tween(begin: 0.5,end: 10);
  late Animation<double> animation = controller.drive(tween.chain(CurveTween(curve: Curves.decelerate)));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(child: Text('aaaa'),)),
          ElevatedButton(onPressed: () {
            // controller.forward();     
            controller.value = 2.0;
            print(1.2);
          }, child: Text('click')),
          ElevatedButton(onPressed: () {
            controller.reverse();     
          }, child: Text('click2')),
        ],
      ),
    );
  }
}