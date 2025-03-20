import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

// 画面遷移を監視するクラス
class CustomNavigatorObserver extends NavigatorObserver {
  final String navigatorName;

  CustomNavigatorObserver(this.navigatorName);

  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint('[$navigatorName] Pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint('[$navigatorName] Popped: ${route.settings.name}');
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Navigator(
              observers: [CustomNavigatorObserver('Top')],
              onGenerateRoute: (settings) {
                Widget page = settings.name == '/page1' ? Page1() : Page2();
                return MaterialPageRoute(builder: (_) => page);
              },
            ),
          ),
          Divider(),
          Expanded(
            child: Navigator(
              observers: [CustomNavigatorObserver('Bottom')],
              onGenerateRoute: (settings) {
                Widget page = settings.name == '/pageA' ? PageA() : PageB();
                return MaterialPageRoute(builder: (_) => page);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pushNamed('/page2'),
        child: Text('Go to Page2 (Top)'),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page 2 (Top)'));
  }
}

class PageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pushNamed('/pageB'),
        child: Text('Go to PageB (Bottom)'),
      ),
    );
  }
}

class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page B (Bottom)'));
  }
}
