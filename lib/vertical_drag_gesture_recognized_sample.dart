// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: VerticalDragGestureRecognizedSample(),
//     );
//   }
// }

// // class VerticalDragGestureRecognizedSample extends StatelessWidget {
// //   const VerticalDragGestureRecognizedSample({super.key});
// //   VerticalDragGestureRecognizer recognizer;
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Placeholder();
// //   }
// // }

// class VerticalDragGestureRecognizedSample extends StatefulWidget {
//   const VerticalDragGestureRecognizedSample({super.key});

//   @override
//   State<VerticalDragGestureRecognizedSample> createState() => _VerticalDragGestureRecognizedSampleState();
// }

// class _VerticalDragGestureRecognizedSampleState extends State<VerticalDragGestureRecognizedSample> {
//   late VerticalDragGestureRecognizer recognizer;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     recognizer = VerticalDragGestureRecognizer(debugOwner: this);
//     recognizer.onStart = (detail) {
//       print('drag start');
//     };
//     recognizer.onUpdate = (detail) {
//       print('drag start');
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     return (
      
//     );
//   }
// }