// import 'dart:math' as math;

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';

// void main() {
//   runApp(App());
// }

// _controller = AnimationController(
//      vsync: this,
//      duration: const Duration(milliseconds: 1000),
//    )

// class App extends StatelessWidget {
//   App({super.key});
//   final Animation<double> delayAnimation = CurvedAnimation(
//       // parent: _sheetController.animation,
//       parent: AnimationController(
//     //  vsync: this,
//      duration: const Duration(milliseconds: 1000), vsync: ,
//    ),
//       curve: Interval(
//         // initialExtent == 1 ? 0 : initialExtent,
//         // initialExtent == 1 ? 0.5 : initialExtent,
//         0.5,
//         1,
//         curve: Curves.linear,
//       ),
//     );

//     final Animation<double> secondaryAnimation = CurvedAnimation(
//       parent: _sheetController.animation,
//       // curve: Interval(0, initialExtent, curve: Curves.linear),
//       curve: Interval(0, initialExtent, curve: Curves.bounceIn),
//     );

//   @override
//   Widget build(BuildContext context) {
//     // return MaterialApp(home: MyWidget());
//     return MaterialApp(
//       home: CupertinoSheetBottomRouteTransition(
//       sheetAnimation: null,
//       secondaryAnimation: null,
//       body: MyWidget(),
//     ));
//   }
// }

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Transform(
//           transform: Matrix4.identity()
//             ..setEntry(3, 2, 0.01)
//             ..rotateX(0.6),
//           alignment: FractionalOffset.center,
//           child: const Padding(
//             padding: EdgeInsets.all(30),
//             child: FlutterLogo(
//               size: 150,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Value extracted from the official sketch iOS UI kit
// /// It is the top offset that will be displayed from the bottom route
// const double _kPreviousRouteVisibleOffset = 10.0;

// /// Value extracted from the official sketch iOS UI kit
// const Radius _kCupertinoSheetTopRadius = Radius.circular(10.0);

// /// Estimated Round corners for iPhone X, XR, 11, 11 Pro
// /// https://kylebashour.com/posts/finding-the-real-iphone-x-corner-radius
// /// It used to animate the bottom route with a top radius that matches
// /// the frame radius. If the device doesn't have round corners it will use
// /// Radius.zero
// const Radius _kRoundedDeviceRadius = Radius.circular(38.5);

// /// Minimal distance from the top of the screen to the top of the previous route
// /// It will be used ff the top safe area is less than this value.
// /// In iPhones the top SafeArea is more or equal to this distance.
// const double _kSheetMinimalOffset = 10;

// /// Value extracted from the official sketch iOS UI kit for iPhone X, XR, 11, 11 Pro
// /// The status bar height is bigger for devices with rounded corners, this is
// /// used to detect if an iPhone has round corners or not
// const double _kRoundedDeviceStatusBarHeight = 20;

// const Curve _kCupertinoSheetCurve = Curves.easeOutExpo;
// const Curve _kCupertinoTransitionCurve = Curves.linear;

// /// Wraps the child into a cupertino modal sheet appearance. This is used to
// /// create a [SheetRoute].
// ///
// /// Clip the child widget to rectangle with top rounded corners and adds
// /// top padding and top safe area.
// class _CupertinoSheetDecorationBuilder extends StatelessWidget {
//   const _CupertinoSheetDecorationBuilder({
//     required this.child,
//     required this.topRadius,
//     this.backgroundColor,
//   });

//   /// The child contained by the modal sheet
//   final Widget child;

//   /// The color to paint behind the child
//   final Color? backgroundColor;

//   /// The top corners of this modal sheet are rounded by this Radius
//   final Radius topRadius;

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoUserInterfaceLevel(
//       data: CupertinoUserInterfaceLevelData.elevated,
//       child: Builder(
//         builder: (BuildContext context) {
//           return Container(
//             clipBehavior: Clip.hardEdge,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.vertical(top: topRadius),
//               color: backgroundColor ??
//                   CupertinoColors.systemBackground.resolveFrom(context),
//             ),
//             child: MediaQuery.removePadding(
//               context: context,
//               removeTop: true,
//               child: child,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class CupertinoSheetBottomRouteTransition extends StatelessWidget {
//   const CupertinoSheetBottomRouteTransition({
//     super.key,
//     required this.sheetAnimation,
//     required this.secondaryAnimation,
//     required this.body,
//   });

//   final Widget body;

//   final Animation<double> sheetAnimation;
//   final Animation<double> secondaryAnimation;

//   // Currently iOS does not provide any way to detect the radius of the
//   // screen device. Right not we detect if the safe area has the size
//   // for the device that contain a notch as they are the ones right
//   // now that has corners with radius
//   Radius _getRadiusForDevice(MediaQueryData mediaQuery) {
//     final double topPadding = mediaQuery.padding.top;
//     // Round corners for iPhone devices from X to the newest version
//     // final bool isRoundedDevice = defaultTargetPlatform == TargetPlatform.iOS &&
//     //     topPadding > _kRoundedDeviceStatusBarHeight;

//     final bool isRoundedDevice = true;

//     return isRoundedDevice ? _kRoundedDeviceRadius : Radius.zero;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double topPadding = MediaQuery.of(context).padding.top;
//     final double topOffset = math.max(_kSheetMinimalOffset, topPadding);
//     final Radius deviceCorner = _getRadiusForDevice(MediaQuery.of(context));

//     final CurvedAnimation curvedAnimation = CurvedAnimation(
//       parent: sheetAnimation,
//       curve: _kCupertinoTransitionCurve,
//       // curve: Curves.bounceIn,
//     );

//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle.light,
//       child: AnimatedBuilder(
//         animation: secondaryAnimation,
//         child: body,
//         builder: (BuildContext context, Widget? child) {
//           final double progress = curvedAnimation.value;
//           final double scale = 1 - progress / 10;
//           final Radius radius = progress == 0
//               ? Radius.zero
//               : Radius.lerp(deviceCorner, _kCupertinoSheetTopRadius, progress)!;
//           return Stack(
//             children: <Widget>[
//               Container(color: CupertinoColors.black),
//               // TODO(jaime): Add ColorFilter based on CupertinoUserInterfaceLevelData
//               // https://github.com/jamesblasco/modal_bottom_sheet/pull/44/files
//               Transform.translate(
//                 offset: Offset(0, progress * topOffset),
//                 child: Transform.scale(
//                   scale: scale,
//                   alignment: Alignment.topCenter,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.vertical(top: radius),
//                     child: ColorFiltered(
//                       colorFilter: ColorFilter.mode(
//                         (CupertinoTheme.brightnessOf(context) == Brightness.dark
//                                 ? CupertinoColors.inactiveGray
//                                 : Colors.black)
//                             .withOpacity(secondaryAnimation.value * 0.1),
//                         BlendMode.srcOver,
//                       ),
//                       child: child,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
