import 'package:flutter/material.dart';

void main() {
  runApp(TopPage());
}

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        // key: null,
        // key: null,
        child: Scaffold(
          appBar: AppBar(
            title: Text('InheritedWidget Demo'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              WidgetA(),
              WidgetB(),
              WidgetC(),
            ],
          ),
        ),
      ),
    );
  }
}

// class _MyInheritedWidget extends InheritedWidget {
class _MyInheritedWidget extends InheritedModel<String> {
  _MyInheritedWidget({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  final HomePageState data;

  @override
  bool updateShouldNotifyDependent(_MyInheritedWidget old, Set aspects) {
    return aspects.contains('A'); // A文字列が送られてきた場合だけ通知する
  }

  @override
  bool updateShouldNotify(_MyInheritedWidget oldWidget) {
    // return true;
    return false;
  }
}

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  HomePageState createState() => HomePageState();

  static HomePageState of(BuildContext context, String aspect) {
    // return InheritedWidget
    return InheritedModel.inheritFrom<_MyInheritedWidget>(
      context,
      aspect: aspect,
    )!
        .data;
  }

}

class HomePageState extends State<HomePage> {
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      data: this,
      child: widget.child,
    );
  }
}

class WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomePageState state = HomePage.of(context, 'A');

    return Center(
      child: Text(
        '${state.counter}',
        // style: Theme.of(context).textTheme.display1,
      ),
    );
  }
}

class WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('I am a widget that will not be rebuilt.');
  }
}

class WidgetC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomePageState state = HomePage.of(context, 'C');
    return ElevatedButton(
      onPressed: () {
        state._incrementCounter();
      },
      child: Icon(Icons.add),
    );
  }
}
