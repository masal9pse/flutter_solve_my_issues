import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterPage(),
    );
  }
}

class Counter {
  int _counter = 0;
  final StreamController<int> controller = StreamController<int>();
  Stream<int> get stream => controller.stream;

  void increment() {
    _counter++;
    controller.add(_counter);    
  }

  void dispose() {
    controller.close();
  }
}

class CounterPage extends HookConsumerWidget {
  late final StreamSubscription<String> _subscription;  
  // int count = 0;
  // final counter = Counter();

  CounterPage({super.key});  

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final counter = useMemoized(() => Counter());
    // final count = useState(0);
    final count = useStream(counter.stream, initialData: 0);
    useEffect(() {
      return counter.dispose;
    }, [counter]);
  
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Example'),
        actions: [
          IconButton(
            onPressed: () => _subscription.pause(),
            icon: Icon(Icons.pause),
            tooltip: 'Pause Stream',
          ),
        ],
      ),
      body: Column(
        children: [
          Text('${count.data!}'),
          ElevatedButton.icon(onPressed: counter.increment, label: Icon(Icons.plus_one))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _subscription.resume(),
        child: Icon(Icons.play_arrow),
        tooltip: 'Resume Stream',
      ),
    );
  }
}
